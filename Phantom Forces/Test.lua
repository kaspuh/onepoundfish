local run_service = game:GetService("RunService")
local teams = game:GetService("Teams")
local players = game:GetService("Players")
local camera = workspace.CurrentCamera
local user_input_service = game:GetService("UserInputService")
local tween_service = game:GetService("TweenService")

local easing_strength = 0.1
local tween_sensitivity = Instance.new("NumberValue")
tween_sensitivity.Value = 0.1
local is_visibility_check_enabled = false
local original_properties = {}
local is_optimized = false
local is_right_click_held = false
local target_part = nil
local is_fov_enabled = false
local is_auto_target_switch_enabled = false

local fov_circle = Drawing.new("Circle")
fov_circle.Visible = false
fov_circle.Color = Color3.fromRGB(255, 255, 255)
fov_circle.Thickness = 1
fov_circle.Filled = false
fov_circle.Transparency = 1
fov_circle.Radius = 100
fov_circle.Position = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)

local vec2 = Vector2.new
local storage = { esp_cache = {} }

local features = {
    box = { color = Color3.fromRGB(255, 255, 255), border_size_pixel = 1 },
    tracer = { color = Color3.fromRGB(255, 255, 255), thickness = 1 },
    distance_text = { size = 14, color = Color3.fromRGB(255, 255, 255) },
    chams = { team_check = true }
}

local function get_players()
    local entity_list = {}
    for _, team in ipairs(workspace.Players:GetChildren()) do
        for _, player in ipairs(team:GetChildren()) do
            if player:IsA("Model") then
                table.insert(entity_list, player)
            end
        end
    end
    return entity_list
end

local function is_enemy(player)
    local local_player_team = players.LocalPlayer.Team
    local helmet = player:FindFirstChildWhichIsA("Folder") and player:FindFirstChildWhichIsA("Folder"):FindFirstChildOfClass("MeshPart")
    if not helmet then return false end

    local player_color = helmet.BrickColor.Name
    if player_color == "Black" and local_player_team.Name == "Phantoms" then
        return false
    elseif player_color ~= "Black" and local_player_team.Name == "Ghosts" then
        return false
    end
    return true
end

local function cache_object(object)
    if not storage.esp_cache[object] then
        storage.esp_cache[object] = {
            box_square = Drawing.new("Square"),
            box_outline = Drawing.new("Square"),
            box_inline = Drawing.new("Square"),
            tracer_line = Drawing.new("Line"),
            distance_label = Drawing.new("Text"),
            name_label = Drawing.new("Text")
        }
    end
end

local function uncache_object(object)
    if storage.esp_cache[object] then
        for _, cached_instance in pairs(storage.esp_cache[object]) do
            cached_instance:Remove()
        end
        storage.esp_cache[object] = nil
    end
end

local function get_body_part(player, body_part_name)
    for _, body_part in player:GetChildren() do
        if body_part:IsA("BasePart") then
            local mesh = body_part:FindFirstChildOfClass("SpecialMesh")
            if mesh and mesh.MeshId == "rbxassetid://4049240078" then
                return body_part
            end
        end
    end
    return nil
end

local function get_head(player, body_part_name)
    for _, body_part in player:GetChildren() do
        if body_part:IsA("BasePart") then
            local mesh = body_part:FindFirstChildOfClass("SpecialMesh")
            if mesh and mesh.MeshId == "rbxassetid://6179256256" then
                return body_part
            end
        end
    end
    return nil
end

local function is_ally(player)
    if not player then return end
    local helmet = player:FindFirstChildWhichIsA("Folder"):FindFirstChildOfClass("MeshPart")
    if not helmet then return end

    if helmet.BrickColor == BrickColor.new("Black") then
        return teams.Phantoms == players.LocalPlayer.Team, teams.Phantoms
    end
    return teams.Ghosts == players.LocalPlayer.Team, teams.Ghosts
end

local function get_closest_player()
    local closest_part = nil
    local shortest_distance = math.huge
    local screen_center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)

    for _, player in ipairs(get_players()) do
        if player:IsDescendantOf(workspace.Ignore.DeadBody) then continue end
        local is_ally_player, _ = is_ally(player)
        if features.chams.team_check and is_ally_player then continue end

        local head = get_head(player, "Head")
        if head then
            local ray = Ray.new(camera.CFrame.Position, (head.Position - camera.CFrame.Position).unit * 1000)
            local part_position, on_screen = camera:WorldToViewportPoint(head.Position)

            if on_screen then
                local screen_position = Vector2.new(part_position.X, part_position.Y)
                local distance_to_center = (screen_position - screen_center).Magnitude

                if is_fov_enabled then
                    if distance_to_center <= fov_circle.Radius then
                        local distance_to_camera = (head.Position - camera.CFrame.Position).Magnitude
                        if distance_to_camera <= 20 then
                            closest_part = head
                            break
                        end
                        if distance_to_center < shortest_distance then
                            closest_part = head
                            shortest_distance = distance_to_center
                        end
                    end
                else
                    local distance_to_camera = (head.Position - camera.CFrame.Position).Magnitude
                    if distance_to_camera <= 20 then
                        closest_part = head
                        break
                    end
                    if distance_to_center < shortest_distance then
                        closest_part = head
                        shortest_distance = distance_to_center
                    end
                end
            end
        end
    end
    return closest_part
end



local interpolation_connection = nil

local function aim_at()
    if not easing_strength then return end

    if is_right_click_held then
        if not target_part or not target_part:IsDescendantOf(workspace.Players) then
            if is_auto_target_switch_enabled then
                target_part = get_closest_player()
                if not target_part then
                    is_right_click_held = false
                    return
                end
            else
                is_right_click_held = false
                return
            end
        end

        local part_position, on_screen = camera:WorldToViewportPoint(target_part.Position)
        if on_screen then
            local mouse_location = user_input_service:GetMouseLocation()
            local target_mouse_position = Vector2.new(part_position.X, part_position.Y)
            local delta = target_mouse_position - mouse_location
            local distance = delta.Magnitude

            if distance > 1 then
                local move_vector = delta * tween_sensitivity.Value
                mousemoverel(move_vector.X, move_vector.Y)
            end
        end
    end
end

local function update_sensitivity(new_sensitivity)
    local tween_info = TweenInfo.new(
        0.4,
        Enum.EasingStyle.Linear, 
        Enum.EasingDirection.Out
    )

    local tween = tween_service:Create(tween_sensitivity, tween_info, {Value = new_sensitivity})
    tween:Play()
end

local function store_original_properties(instance)
    if instance:IsA("BasePart") or instance:IsA("UnionOperation") or instance:IsA("MeshPart") then
        original_properties[instance] = {
            material = instance.Material,
            reflectance = instance.Reflectance,
            cast_shadow = instance.CastShadow,
            texture_id = instance:FindFirstChild("TextureId") and instance.TextureId or nil
        }
    end
end

local function optimize_map()
    local map = workspace:FindFirstChild("Map")
    if not map then return end

    local descendants = map:GetDescendants()
    for _, instance in ipairs(descendants) do
        store_original_properties(instance)
        if instance:IsA("BasePart") or instance:IsA("UnionOperation") or instance:IsA("MeshPart") then
            instance.Material = Enum.Material.SmoothPlastic
            instance.Reflectance = 0
            instance.CastShadow = false
            if instance:IsA("MeshPart") and instance:FindFirstChild("TextureId") then
                instance.TextureId = ""
            end
        end
    end
    is_optimized = true
end

local function revert_map()
    local map = workspace:FindFirstChild("Map")
    if not map then return end

    local descendants = map:GetDescendants()
    for _, instance in ipairs(descendants) do
        if original_properties[instance] then
            instance.Material = original_properties[instance].material
            instance.Reflectance = original_properties[instance].reflectance
            instance.CastShadow = original_properties[instance].cast_shadow
            if instance:IsA("MeshPart") and instance:FindFirstChild("TextureId") then
                instance.TextureId = original_properties[instance].texture_id or ""
            end
        end
    end
    is_optimized = false
end

local function is_visible(target_part)
    if is_visibility_check_enabled then
        local ray = Ray.new(camera.CFrame.Position, (target_part.Position - camera.CFrame.Position).unit * 1000)
        local hit_part, hit_position = workspace:FindPartOnRay(ray, players.LocalPlayer.Character, false, true)
        return hit_part == target_part
    else
        return true
    end
end

local ui_loader = loadstring(game:HttpGet('https://raw.githubusercontent.com/kaspuh/wanpaundfeesh/refs/heads/main/ui-lib'))
getgenv().jump_height_value = 30

local env = identifyexecutor()
local ui = ui_loader({ rounding = false, theme = 'lime', smoothDragging = false })
ui.autoDisableToggles = true

local window = ui.newWindow({ text = 'Crobster.lol | DEV TEST V0.8 | discord.gg/getxeno', resize = false, size = Vector2.new(550, 376) })
local menu = window:addMenu({ text = 'Main' })

local aimbot_section
if env == "Xeno" then
    aimbot_section = menu:addSection({ text = 'Aimbot', side = 'left', showMinButton = false }):addLabel({ text = 'Xeno Doesn\'t have Aimbot Support :(' })
else
    aimbot_section = menu:addSection({ text = 'Aimbot', side = 'left', showMinButton = false })
    local aimbot_toggle = aimbot_section:addToggle({ text = 'Enabled', state = false })
    local wall_check_toggle = aimbot_section:addToggle({ text = 'Wall Check', state = false })
    local auto_target_switch_toggle = aimbot_section:addToggle({ text = 'Auto Target Switch', state = false })
  
    auto_target_switch_toggle:bindToEvent('onToggle', function(new_state) is_auto_target_switch_enabled = new_state end)

    aimbot_toggle:bindToEvent('onToggle', function(new_state)
        is_aimbot_enabled = new_state
        if is_aimbot_enabled then
            input_began_connection = user_input_service.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton2 then
                    is_right_click_held = true
                    target_part = get_closest_player()
                end
            end)

            input_ended_connection = user_input_service.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton2 then
                    is_right_click_held = false
                    target_part = nil
                end
            end)

            render_stepped_connection = run_service.RenderStepped:Connect(function()
                if is_right_click_held and target_part then
                    if wall_check_toggle:getState() then
                        if is_visible(target_part) then aim_at() end
                    else
                        aim_at()
                    end
                end
            end)
        else
            is_right_click_held = false
            target_part = nil
            if input_began_connection then input_began_connection:Disconnect() end
            if input_ended_connection then input_ended_connection:Disconnect() end
            if render_stepped_connection then render_stepped_connection:Disconnect() end
        end
    end)
end

local easing_slider = aimbot_section:addSlider({ text = 'Strength', min = 0.1, max = 1.5, default = 0.1, float = true, step = 0.1 })
local aimbot_warning_text = aimbot_section:addLabel({ text = "* Values above 1 will be shaky!" })

local esp_section = menu:addSection({ text = "ESP", side = "right", showMinButton = false })
local esp_toggle = esp_section:addToggle({ text = 'Enabled', state = false })
local box_toggle = esp_section:addToggle({ text = 'Box', state = false })
local tracer_toggle = esp_section:addToggle({ text = 'Tracer', state = false })
local head_dot_toggle = esp_section:addToggle({ text = 'Head Dot', state = false })
local distance_toggle = esp_section:addToggle({ text = 'Distance', state = false })
local name_toggle = esp_section:addToggle({ text = 'Name', state = false })
local visibility_toggle = esp_section:addToggle({ text = 'Wall Check', state = false })

local box_color_picker = esp_section:addColorPicker({ text = 'Box Color', color = Color3.fromRGB(255, 255, 255) })
local tracer_color_picker = esp_section:addColorPicker({ text = 'Tracer Color', color = Color3.fromRGB(255, 255, 255) })
local distance_color_picker = esp_section:addColorPicker({ text = 'Distance Color', color = Color3.fromRGB(255, 255, 255) })
local head_dot_color_picker = esp_section:addColorPicker({ text = 'Head Dot Color', color = Color3.fromRGB(255, 255, 255) })
local name_color_picker = esp_section:addColorPicker({ text = 'Name Color', color = Color3.fromRGB(255, 255, 255) })

local fov_section = menu:addSection({ text = 'FOV', side = 'left', showMinButton = false })
local fov_toggle = fov_section:addToggle({ text = 'Show FOV Circle', state = false })
local fov_radius_slider = fov_section:addSlider({ text = 'FOV Radius', min = 50, max = 300, default = 100, float = false, step = 1 })

local player_menu = window:addMenu({ text = 'Player' })
local player_mods = player_menu:addSection({ text = 'LocalPlayer Mods', side = 'left' })
local walk_speed_slider = player_mods:addSlider({ text = 'WalkSpeed', min = 0, max = 0.17, default = 0, float = true, step = 0.01 })
local jump_height_slider = player_mods:addSlider({ text = 'JumpPower', min = 0, max = 100, default = 50, float = true, step = 1 })

local fun_mods = player_menu:addSection({ text = "Fun Mods" })
local jump_delay_bypass_toggle = fun_mods:addToggle({ text = 'Jump Delay Bypass', state = false })

local misc_mods = window:addMenu({ text = "Misc" })
local optimizations = misc_mods:addSection({ text = "Misc Mods", side = "left" })
local safety_section = misc_mods:addSection({ text = "Safety", side = "right" })
local votekick_rejoiner_toggle = safety_section:addToggle({ text = "Anti Votekick", state = false })
local texture_toggle = optimizations:addToggle({ text = "Toggle Textures", state = false })

local t_speed = walk_speed_slider:getValue()

local function get_character()
    local character
    repeat
        character = workspace:FindFirstChild("Ignore") and workspace:FindFirstChild("Ignore"):FindFirstChildWhichIsA("Model")
        task.wait()
    until character
    return character
end

walk_speed_slider:bindToEvent('onNewValue', function(walk_speed_func) t_speed = walk_speed_func end)
jump_height_slider:bindToEvent('onNewValue', function(jump_height_func) getgenv().jump_height_value = jump_height_func end)
easing_slider:bindToEvent('onNewValue', function(value) update_sensitivity(value) end)
visibility_toggle:bindToEvent('onToggle', function(state) is_visibility_check_enabled = state end)
fov_toggle:bindToEvent('onToggle', function(state) is_fov_enabled = state; fov_circle.Visible = state end)
fov_radius_slider:bindToEvent('onNewValue', function(value) fov_circle.Radius = value end)

local lastJumpTime = 0
local jumpCooldown = 0.8681
local local_player = players.LocalPlayer

local function kick_and_rejoin()
    local teleport_service = game:GetService("TeleportService")
    local place_id = game.PlaceId
    local_player:Kick("You have been vote-kicked. Rejoining a different server...")
    teleport_service:Teleport(place_id)
end

local function initialize_votekick_rejoiner()
    local chat_screen_gui = local_player.PlayerGui:WaitForChild("ChatScreenGui")
    local display_vote_kick = chat_screen_gui.Main:WaitForChild("DisplayVoteKick")

    display_vote_kick:GetPropertyChangedSignal("Visible"):Connect(function()
        if display_vote_kick.Visible and votekick_rejoiner_toggle:getState() then
            local text_title = display_vote_kick.TextTitle.Text
            local words = {}
            for word in text_title:gmatch("%S+") do table.insert(words, word) end
            if words[2] == local_player.Name then kick_and_rejoin() end
        end
    end)
end

user_input_service.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Space then
        local currentTime = tick()
        if (currentTime - lastJumpTime) < jumpCooldown and jump_delay_bypass_toggle:getState() then
            local humanoid = get_character():FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.Jump = true end
        end
        lastJumpTime = currentTime
    end
end)

esp_toggle:bindToEvent('onToggle', function(state)
    if state then
        esp_loop = run_service.RenderStepped:Connect(function()
            for _, player in ipairs(get_players()) do
                if is_enemy(player) then cache_object(player) end
            end

            for player, cache in pairs(storage.esp_cache) do
                if player then
                    local torso = get_body_part(player, "Torso")
                    local head = get_head(player, "Head")
                    if torso and head then
                        local w2s, on_screen = camera:WorldToViewportPoint(torso.Position)
                        if on_screen then
                            local screen_position = Vector2.new(w2s.X, w2s.Y)
                            local screen_center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
                            local distance_to_center = (screen_position - screen_center).Magnitude

                            if not fov_toggle:getState() or distance_to_center <= fov_circle.Radius then
                                local billboardGui = head:FindFirstChildOfClass("BillboardGui")
                                local textLabel = billboardGui and billboardGui:FindFirstChildOfClass("TextLabel")

                                if not billboardGui or not textLabel then
                                    uncache_object(player)
                                    continue
                                end

                                local scale = 1000 / (camera.CFrame.Position - torso.Position).Magnitude * 80 / camera.FieldOfView
                                local box_scale = vec2(math.round(3 * scale), math.round(4 * scale))

                                local box_color = is_visible(head) and box_color_picker:getColor() or Color3.fromRGB(255, 0, 0)
                                if box_toggle:getState() then
                                    local box_position = vec2(w2s.X - box_scale.X / 2, w2s.Y - box_scale.Y / 2)
                                    local box_size = box_scale

                                    cache.box_square.Visible = true
                                    cache.box_square.Color = box_color
                                    cache.box_square.Thickness = 1
                                    cache.box_square.Position = box_position
                                    cache.box_square.Size = box_size
                                    cache.box_square.Filled = false

                                    cache.box_outline.Visible = true
                                    cache.box_outline.Color = Color3.fromRGB(0, 0, 0)
                                    cache.box_outline.Thickness = 1
                                    cache.box_outline.Position = vec2(box_position.X - 1, box_position.Y - 1)
                                    cache.box_outline.Size = vec2(box_size.X + 2, box_size.Y + 2)
                                    cache.box_outline.Filled = false
                                else
                                    cache.box_square.Visible = false
                                    cache.box_outline.Visible = false
                                end

                                if tracer_toggle:getState() then
                                    cache.tracer_line.Visible = true
                                    cache.tracer_line.Color = tracer_color_picker:getColor()
                                    cache.tracer_line.Thickness = features.tracer.thickness
                                    cache.tracer_line.From = vec2(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                                    cache.tracer_line.To = vec2(w2s.X, w2s.Y)
                                else
                                    cache.tracer_line.Visible = false
                                end

                                if name_toggle:getState() then
                                    cache.name_label.Visible = true
                                    cache.name_label.Text = textLabel.Text
                                    cache.name_label.Size = features.distance_text.size
                                    cache.name_label.Color = name_color_picker:getColor()
                                    cache.name_label.Center = true
                                    cache.name_label.Outline = true
                                    cache.name_label.Position = vec2(cache.box_square.Position.X + (cache.box_square.Size.X / 2), cache.box_square.Position.Y - 30)
                                else
                                    cache.name_label.Visible = false
                                end

                                if distance_toggle:getState() then
                                    local distance = math.floor((camera.CFrame.Position - torso.Position).Magnitude)
                                    cache.distance_label.Visible = true
                                    cache.distance_label.Text = tostring(distance) .. " studs"
                                    cache.distance_label.Size = features.distance_text.size
                                    cache.distance_label.Color = distance_color_picker:getColor()
                                    cache.distance_label.Center = true
                                    cache.distance_label.Outline = true
                                    cache.distance_label.Position = vec2(cache.box_square.Position.X + (cache.box_square.Size.X / 2), cache.box_square.Position.Y - 15)
                                else
                                    cache.distance_label.Visible = false
                                end

                                if head_dot_toggle:getState() then
                                    if not cache.head_dot then cache.head_dot = Drawing.new("Circle") end
                                    local head_w2s, head_on_screen = camera:WorldToViewportPoint(head.Position)
                                    if head_on_screen then
                                        cache.head_dot.Visible = true
                                        cache.head_dot.Color = head_dot_color_picker:getColor()
                                        cache.head_dot.Thickness = 1
                                        cache.head_dot.Filled = true
                                        cache.head_dot.Transparency = 1
                                        cache.head_dot.Radius = (box_scale.Y / 20)
                                        cache.head_dot.Position = Vector2.new(head_w2s.X, head_w2s.Y)
                                    else
                                        cache.head_dot.Visible = false
                                    end
                                else
                                    if cache.head_dot then cache.head_dot.Visible = false end
                                end
                            else
                                uncache_object(player)
                            end
                        else
                            uncache_object(player)
                        end
                    else
                        uncache_object(player)
                    end
                else
                    uncache_object(player)
                end
            end
        end)
    else
        if esp_loop then
            esp_loop:Disconnect()
            for player in pairs(storage.esp_cache) do uncache_object(player) end
        end
    end
end)

votekick_rejoiner_toggle:bindToEvent('onToggle', function(state)
    if state then initialize_votekick_rejoiner() end
end)

box_color_picker:bindToEvent('onColorChanged', function(new_color) features.box.color = new_color end)
tracer_color_picker:bindToEvent('onColorChanged', function(new_color) features.tracer.color = new_color end)
distance_color_picker:bindToEvent('onColorChanged', function(new_color) features.distance_text.color = new_color end)
name_color_picker:bindToEvent('onColorChanged', function(new_color) features.name_color = new_color end)
head_dot_color_picker:bindToEvent('onColorChanged', function(new_color) features.head_dot_color = new_color end)

texture_toggle:bindToEvent('onToggle', function(state)
    if state then optimize_map() else revert_map() end
end)

user_input_service.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or not window then return end
    if input.KeyCode == Enum.KeyCode.F4 then window:minimize() end
end)

local function is_number(str) return tonumber(str) ~= nil or str == 'inf' end

local hb = game:GetService("RunService").Heartbeat
local tp_walking = true

while tp_walking do
    local chr = get_character()
    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

    hum.JumpPower = getgenv().jump_height_value

    hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        hum.JumpPower = getgenv().jump_height_value
    end)

    while chr and hum and hum.Parent and tp_walking do
        if hum.MoveDirection.Magnitude > 0 then
            if t_speed and is_number(t_speed) then
                chr:TranslateBy(hum.MoveDirection * tonumber(t_speed))
            else
                chr:TranslateBy(hum.MoveDirection)
            end
        end
        if not chr.Parent then break end
        hb:Wait()
    end
end
