--// services 
local run_service = game:GetService("RunService")
local teams = game:GetService("Teams")
local players = game:GetService("Players")
local camera = workspace.CurrentCamera
local user_input_service = game:GetService("UserInputService")
local easing_strength = 0.1
local is_visibility_check_enabled = false

--// variables
local vec2 = Vector2.new
local storage = { esp_cache = {} }
local is_right_click_held = false
local target_part = nil
local features = {
    box = {
        color = Color3.fromRGB(255, 255, 255),
        border_size_pixel = 1,
    },
    tracer = {
        color = Color3.fromRGB(255, 255, 255),
        thickness = 1
    },
    distance_text = {
        size = 14,
        color = Color3.fromRGB(255, 255, 255),
    },
    chams = {team_check = true}
}

--// functions
function get_players()
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

function is_enemy(player)
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

function cache_object(object)
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

function uncache_object(object)
    if storage.esp_cache[object] then
        for _, cached_instance in pairs(storage.esp_cache[object]) do
            cached_instance:Remove()
        end
        storage.esp_cache[object] = nil
    end
end

function get_body_part(player, body_part_name)
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

function get_head(player, body_part_name)
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

function is_ally(player)
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
        local is_ally_player, _ = is_ally(player)

        if features.chams.team_check and is_ally_player then
            continue
        end

        local head = get_head(player, "Head")
        if head then
            local ray = Ray.new(camera.CFrame.Position, (head.Position - camera.CFrame.Position).unit * 1000)
            local part_position, on_screen = camera:WorldToViewportPoint(head.Position)

            if on_screen then
                local distance_to_camera = (head.Position - camera.CFrame.Position).Magnitude

                -- Prioritize heads within 20 studs
                if distance_to_camera <= 20 then
                    closest_part = head
                    break
                end

                local screen_position = Vector2.new(part_position.X, part_position.Y)
                local distance_to_center = (screen_position - screen_center).Magnitude

                if distance_to_center < shortest_distance then
                    closest_part = head
                    shortest_distance = distance_to_center
                end
            end
        end
    end

    return closest_part
end

local function aim_at()
    if target_part then
        local part_position, on_screen = camera:WorldToViewportPoint(target_part.Position)

        if on_screen then
            local mouse_location = user_input_service:GetMouseLocation()
            local target_mouse_position = Vector2.new(part_position.X, part_position.Y)

            local delta = target_mouse_position - mouse_location
            local distance = delta.Magnitude

            if distance > 1 then
                local move_vector = delta * easing_strength
                mousemoverel(move_vector.X, move_vector.Y)
            end
        end
    end
end

local function is_visible(target_part)
    if is_visibility_check_enabled then
        local ray = Ray.new(camera.CFrame.Position, (target_part.Position - camera.CFrame.Position).unit * 1000)
        local hit_part, hit_position = workspace:FindPartOnRay(ray, players.LocalPlayer.Character, false, true) -- dont know how the fuck this works but we keep it
        
        return hit_part == target_part
    else
        return true
    end
end

local ui_loader = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/dollarware/main/library.lua'))
getgenv().jump_height_value = 30

local env = identifyexecutor()

local ui = ui_loader({
    rounding = false,
    theme = 'lime',
    smoothDragging = false
})

ui.autoDisableToggles = true

local window = ui.newWindow({
    text = 'Crobster.lol | DEV TEST V0.01 | discord.gg/getxeno',
    resize = false,
    size = Vector2.new(550, 376),
})

local menu = window:addMenu({
    text = 'Main'
})

local aimbot_section
if env == "Xeno" then
    aimbot_section = menu:addSection({
        text = 'Aimbot',
        side = 'left',
        showMinButton = false
    }):addLabel({
        text = 'Xeno Doesn\'t have Aimbot Support :(',
    })
else
    aimbot_section = menu:addSection({
        text = 'Aimbot',
        side = 'left',
        showMinButton = false
    }) 
    local aimbot_toggle = aimbot_section:addToggle({
        text = 'Enabled',
        state = false
    })
    local wall_check_toggle = aimbot_section:addToggle({
    text = 'Wall Check',
    state = false -- Default to enabled
    })
    aimbot_toggle:bindToEvent('onToggle', function(new_state)
        is_aimbot_enabled = new_state
        if is_aimbot_enabled then
            print("Aimbot Enabled")

            -- Connect input events
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

            -- Connect render stepped event
            render_stepped_connection = run_service.RenderStepped:Connect(function()
            if is_right_click_held and target_part then
                if wall_check_toggle:getState() then
                    if is_visible(target_part) then
                        aim_at()
                    end
                else
                    aim_at()
                end
            end
        end)
        else
            print("Aimbot Disabled")
            is_right_click_held = false
            target_part = nil

            -- Disconnect events
            if input_began_connection then
                input_began_connection:Disconnect()
            end
            if input_ended_connection then
                input_ended_connection:Disconnect()
            end
            if render_stepped_connection then
                render_stepped_connection:Disconnect()
            end
        end
    end)
end


local easing_slider = aimbot_section:addSlider({
    text = 'Strength',
    min = 0.1,
    max = 1.5,
    default = 0.1,
    float = true,
    step = 0.1
})

local aimbot_warning_text = aimbot_section:addLabel({
       text = "* Values above 1 will be shaky!",
})

local esp_section = menu:addSection({
    text = "ESP",
    side = "right",
    showMinButton = false
}) 
local esp_toggle = esp_section:addToggle({
        text = 'Enabled',
        state = false,
})
local box_toggle = esp_section:addToggle({
    text = 'Box',
    state = false,
})

local tracer_toggle = esp_section:addToggle({
    text = 'Tracer',
    state = false,
})

local distance_toggle = esp_section:addToggle({
    text = 'Distance Text',
    state = false,
})

local name_toggle = esp_section:addToggle({
    text = 'Name',
    state = false,
})

local visibility_toggle = esp_section:addToggle({
    text = 'Wall Check',
    state = false -- Default to enabled
})
local player_menu = window:addMenu({
    text = 'Player'
})

local player_mods = player_menu:addSection({
    text = 'LocalPlayer Mods',
    side = 'left'
})

local walk_speed_slider = player_mods:addSlider({
    text = 'WalkSpeed',
    min = 0,
    max = 0.17,
    default = 0,
    float = true,
    step = 0.01
})

local jump_height_slider = player_mods:addSlider({
    text = 'JumpPower',
    min = 0,
    max = 100,
    default = 50,
    float = true,
    step = 1
})

local t_speed = walk_speed_slider:getValue()

local function get_character()
    local character
    repeat
        character = workspace:FindFirstChild("Ignore") and workspace:FindFirstChild("Ignore"):FindFirstChildWhichIsA("Model")
        task.wait()
    until character
    return character
end

walk_speed_slider:bindToEvent('onNewValue', function(walk_speed_func)
    t_speed = walk_speed_func
    print("Slider value is: " .. string.format("%.3f", walk_speed_func))
end)
jump_height_slider:bindToEvent('onNewValue', function(jump_height_func)
    getgenv().jump_height_value = jump_height_func
    print("JumpPower slider value is: " .. string.format("%.0f", jump_height_func))
end)
easing_slider:bindToEvent('onNewValue', function(value)
    easing_strength = value
    print("Easing Strength set to:", value)
end)
visibility_toggle:bindToEvent('onToggle', function(state)
    is_visibility_check_enabled = state
end)

esp_toggle:bindToEvent('onToggle', function(state)
    if state then
        esp_loop = run_service.RenderStepped:Connect(function()
            for _, player in ipairs(get_players()) do
                if is_enemy(player) then
                    cache_object(player)
                end
            end

            for player, cache in pairs(storage.esp_cache) do
                if player then
                    local torso = get_body_part(player, "Torso")
                    local head = get_head(player, "Head")
                    if torso then
                        local w2s, on_screen = camera:WorldToViewportPoint(torso.Position)
                        if on_screen then
                            local scale = 1000 / (camera.CFrame.Position - torso.Position).Magnitude * 80 / camera.FieldOfView
                            local box_scale = vec2(math.round(3 * scale), math.round(4 * scale))

                            -- Box ESP
                            local box_color = is_visible(head) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 0, 0)
                            if box_toggle:getState() then
                            local box_position = vec2(w2s.X - box_scale.X / 2, w2s.Y - box_scale.Y / 2)
                            local box_size = box_scale

                            -- Main Box
                            cache.box_square.Visible = true
                            cache.box_square.Color = box_color
                            cache.box_square.Thickness = 1
                            cache.box_square.Position = box_position
                            cache.box_square.Size = box_size
                            cache.box_square.Filled = false

                             -- Box Outline
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

                            -- Tracer ESP
                            if tracer_toggle:getState() then
                                cache.tracer_line.Visible = true
                                cache.tracer_line.Color = features.tracer.color
                                cache.tracer_line.Thickness = features.tracer.thickness
                                cache.tracer_line.From = vec2(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                                cache.tracer_line.To = vec2(w2s.X, w2s.Y)
                            else
                                cache.tracer_line.Visible = false
                            end

                            -- Name ESP (buggy, will be fixed soon)
                             if name_toggle:getState() then
                                cache.name_label.Visible = true
                                cache.name_label.Text = head:FindFirstChildOfClass("BillboardGui"):FindFirstChildOfClass("TextLabel").Text
                                cache.name_label.Size = features.distance_text.size
                                cache.name_label.Color = features.distance_text.color
                                cache.name_label.Center = true
                                cache.name_label.Outline = true
                                cache.name_label.Position = vec2(
                                    cache.box_square.Position.X + (cache.box_square.Size.X / 2),
                                    cache.box_square.Position.Y - 30
                                )
                            else
                                cache.name_label.Visible = false
                            end
                            -- Distance Text ESP
                            if distance_toggle:getState() then
                                local distance = math.floor((camera.CFrame.Position - torso.Position).Magnitude)
                                cache.distance_label.Visible = true
                                cache.distance_label.Text = tostring(distance) .. " studs"
                                cache.distance_label.Size = features.distance_text.size
                                cache.distance_label.Color = features.distance_text.color
                                cache.distance_label.Center = true
                                cache.distance_label.Outline = true
                                cache.distance_label.Position = vec2(
                                    cache.box_square.Position.X + (cache.box_square.Size.X / 2),
                                    cache.box_square.Position.Y - 15
                                )
                            else
                                cache.distance_label.Visible = false
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
            for player in pairs(storage.esp_cache) do
                uncache_object(player)
            end
        end
    end
end)

function is_number(str)
    return tonumber(str) ~= nil or str == 'inf'
end

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
