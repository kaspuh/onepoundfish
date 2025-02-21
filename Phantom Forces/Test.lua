--// services 
local runservice = game:GetService("RunService")
local teams = game:GetService("Teams")
local players = game:GetService("Players")
local camera = workspace.CurrentCamera
local userinputservice = game:GetService("UserInputService")
local easingstrength = 0.1

--// variables
local vec2 = Vector2.new
local storage = { esp_cache = {} }
local isrightclickheld = false
local targetpart = nil -- The part to aim at
local features = {
    box = {
        color = Color3.fromRGB(255, 255, 255),
        borderSizePixel = 1,
    },
    tracer = {
        color = Color3.fromRGB(255, 255, 255),
        thickness = 1
    },
    distance_text = {
        size = 14,
        color = Color3.fromRGB(255, 255, 255),
    },
    chams = {teamcheck = true}
}

--// functions
function getplayers()
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

function isenemy(player)
    local localPlayerTeam = players.LocalPlayer.Team
    local helmet = player:FindFirstChildWhichIsA("Folder") and player:FindFirstChildWhichIsA("Folder"):FindFirstChildOfClass("MeshPart")
    if not helmet then return false end

    local playerColor = helmet.BrickColor.Name
    if playerColor == "Black" and localPlayerTeam.Name == "Phantoms" then
        return false
    elseif playerColor ~= "Black" and localPlayerTeam.Name == "Ghosts" then
        return false
    end
    return true
end

function cacheobject(object)
    if not storage.esp_cache[object] then
        storage.esp_cache[object] = {
            box_square = Drawing.new("Square"),
            tracer_line = Drawing.new("Line"),
            distance_label = Drawing.new("Text"),
            name_label = Drawing.new("Text")
        }
    end
end

function uncacheobject(object)
    if storage.esp_cache[object] then
        for _, cached_instance in pairs(storage.esp_cache[object]) do
            cached_instance:Remove()
        end
        storage.esp_cache[object] = nil
    end
end

function getbodypart(player, bodypart_name)
    for _, bodypart in player:GetChildren() do
        if bodypart:IsA("BasePart") then
            local mesh = bodypart:FindFirstChildOfClass("SpecialMesh")
            if mesh and mesh.MeshId == "rbxassetid://4049240078" then
                return bodypart
            end
        end
    end
    return nil
end

function gethead(player, bodypart_name)
    for _, bodypart in player:GetChildren() do
        if bodypart:IsA("BasePart") then
            local mesh = bodypart:FindFirstChildOfClass("SpecialMesh")
            if mesh and mesh.MeshId == "rbxassetid://6179256256" then
                return bodypart
            end
        end
    end
    return nil
end

function isally(player)
    if not player then return end

    local helmet = player:FindFirstChildWhichIsA("Folder"):FindFirstChildOfClass("MeshPart")
    if not helmet then return end

    if helmet.BrickColor == BrickColor.new("Black") then
        return teams.Phantoms == players.LocalPlayer.Team, teams.Phantoms
    end

    return teams.Ghosts == players.LocalPlayer.Team, teams.Ghosts
end

local function getclosestplayer()
    local closestPart = nil
    local shortestDistance = math.huge
    local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)

    for _, player in ipairs(getplayers()) do
        local isallyplayer, _ = isally(player)


        if features.chams.teamcheck and isallyplayer then
            continue
        end

        local has_decals = false


        for _, child in ipairs(player:GetChildren()) do
            if child:IsA("Part") then
                for _, decal in ipairs(child:GetChildren()) do
                    if decal:IsA("Decal") and decal.Texture == "rbxassetid://5196259061" then
                        has_decals = true

                        local ray = Ray.new(camera.CFrame.Position, (child.Position - camera.CFrame.Position).unit * 1000)
                        local partPosition, onScreen = camera:WorldToViewportPoint(child.Position)

                        if onScreen then
                            local screenPosition = Vector2.new(partPosition.X, partPosition.Y)
                            local distance = (screenPosition - screenCenter).Magnitude

                            if distance < shortestDistance then
                                closestPart = child
                                shortestDistance = distance
                            end
                        end
                    end
                end
            end
        end

        if not has_decals then
            print("No parts with the matching Decal ID found for:", player.Name)
        end
    end

    return closestPart
end


local function aimat()
    if targetpart then
        local partPosition, onScreen = camera:WorldToViewportPoint(targetpart.Position)

        if onScreen then
            local mouseLocation = userinputservice:GetMouseLocation()
            local targetMousePosition = Vector2.new(partPosition.X, partPosition.Y)

            local delta = targetMousePosition - mouseLocation
            local distance = delta.Magnitude

            if distance > 1 then
                local moveVector = delta * easingstrength -- Use adjustable easing
                getfenv().mousemoverel(moveVector.X, moveVector.Y)
            end
        end
    end
end


local uiLoader = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/dollarware/main/library.lua'))
getgenv().jumpheightvalue = 30

local env = identifyexecutor()

local ui = uiLoader({
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



local aimbotsection
if env == "Xeno" then
    aimbotsection = menu:addSection({
        text = 'Aimbot',
        side = 'left',
        showMinButton = false
    }):addLabel({
        text = 'Xeno Doesn\'t have Aimbot Support :(',
    })
else
    aimbotsection = menu:addSection({
        text = 'Aimbot',
        side = 'left',
        showMinButton = false
    }) 
    local aimbottoggle = aimbotsection:addToggle({
        text = 'Enabled',
        state = false
    })
    aimbottoggle:bindToEvent('onToggle', function(newState)
    isAimbotEnabled = newState
    if isAimbotEnabled then
        print("Aimbot Enabled")

 
        if inputBeganConnection then
            inputBeganConnection:Disconnect()
        end
        if inputEndedConnection then
            inputEndedConnection:Disconnect()
        end
        if renderSteppedConnection then
            renderSteppedConnection:Disconnect()
        end


        inputBeganConnection = userinputservice.InputBegan:Connect(function(input)
            if isAimbotEnabled and input.UserInputType == Enum.UserInputType.MouseButton2 then
                isrightclickheld = true
                targetpart = getclosestplayer()
            end
        end)

   
        inputEndedConnection = userinputservice.InputEnded:Connect(function(input)
            if isAimbotEnabled and input.UserInputType == Enum.UserInputType.MouseButton2 then
                isrightclickheld = false
                targetpart = nil
            end
        end)


        renderSteppedConnection = runservice.RenderStepped:Connect(function()
            if isAimbotEnabled and isrightclickheld and targetpart then
                aimat()
            end
        end)
    else
        print("Aimbot Disabled")
        isrightclickheld = false
        targetpart = nil

        if inputBeganConnection then
            inputBeganConnection:Disconnect()
        end
        if inputEndedConnection then
            inputEndedConnection:Disconnect()
        end
        if renderSteppedConnection then
            renderSteppedConnection:Disconnect()
        end
    end
end)
end
local easingslider = aimbotsection:addSlider({
    text = 'Strength',
    min = 0.1,
    max = 1.5,
    default = 0.1,
    float = true,
    step = 0.1
})

local aimbotwarningtet = aimbotsection:addLabel({
       text = "* Values above 1 will be shaky!",
})

local espsection = menu:addSection({
    text = "ESP",
    side = "right",
    showMinButton = false
}) local esptoggle = espsection:addToggle({
        text = 'Enabled',
        state = false,
})
local boxToggle = espsection:addToggle({
    text = 'Box',
    state = false,
})

local tracerToggle = espsection:addToggle({
    text = 'Tracer',
    state = false,
})

local distanceToggle = espsection:addToggle({
    text = 'Distance Text',
    state = false,
})

local nameToggle = espsection:addToggle({
    text = 'Name',
    state = false,
})

local playerMenu = window:addMenu({
    text = 'Player'
})

local playermods = playerMenu:addSection({
    text = 'LocalPlayer Mods',
    side = 'left'
})

local walkspeedslider = playermods:addSlider({
    text = 'WalkSpeed',
    min = 0,
    max = 0.17,
    default = 0,
    float = true,
    step = 0.01
})

local jumpheightslider = playermods:addSlider({
    text = 'JumpPower',
    min = 0,
    max = 100,
    default = 50,
    float = true,
    step = 1
})



tspeed = walkspeedslider:getValue()


local function getchr()
    local character
    repeat
        character = workspace:FindFirstChild("Ignore") and workspace:FindFirstChild("Ignore"):FindFirstChildWhichIsA("Model")
        task.wait()
    until character
    return character
end

walkspeedslider:bindToEvent('onNewValue', function(walkspeedfunc)
    tspeed = walkspeedfunc
    print("Slider value is: " .. string.format("%.3f", walkspeedfunc))
end)
jumpheightslider:bindToEvent('onNewValue', function(jumpheightfunc)
    getgenv().jumpheightvalue = jumpheightfunc
    print("JumpPower slider value is: " .. string.format("%.0f", jumpheightfunc))
end)
easingslider:bindToEvent('onNewValue', function(value)
    easingstrength = value
    print("Easing Strength set to:", value)
end)

esptoggle:bindToEvent('onToggle', function(state)
    if state then
        esp_loop = runservice.RenderStepped:Connect(function()
            for _, player in ipairs(getplayers()) do
                if isenemy(player) then
                    cacheobject(player)
                end
            end

            for player, cache in pairs(storage.esp_cache) do
                if player then
                    local torso = getbodypart(player, "Torso")
                    local head = gethead(player, "Head")
                    if torso then
                        local w2s, onscreen = camera:WorldToViewportPoint(torso.Position)
                        if onscreen then
                            local scale = 1000 / (camera.CFrame.Position - torso.Position).Magnitude * 80 / camera.FieldOfView
                            local box_scale = vec2(math.round(3 * scale), math.round(4 * scale))

                            -- Box ESP
                            if boxToggle:getState() then
                                cache.box_square.Visible = true
                                cache.box_square.Color = features.box.color
                                cache.box_square.Thickness = features.box.borderSizePixel
                                cache.box_square.Position = vec2(w2s.X - box_scale.X / 2, w2s.Y - box_scale.Y / 2)
                                cache.box_square.Size = box_scale
                                cache.box_square.Filled = false
                            else
                                cache.box_square.Visible = false
                            end

                            -- Tracer ESP
                            if tracerToggle:getState() then
                                cache.tracer_line.Visible = true
                                cache.tracer_line.Color = features.tracer.color
                                cache.tracer_line.Thickness = features.tracer.thickness
                                cache.tracer_line.From = vec2(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                                cache.tracer_line.To = vec2(w2s.X, w2s.Y)
                            else
                                cache.tracer_line.Visible = false
                            end

                            -- Name ESP (buggy, will be fixed soon)
                             if nameToggle:getState() then
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
                            if distanceToggle:getState() then
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
                            uncacheobject(player)
                        end
                    else
                        uncacheobject(player)
                    end
                else
                    uncacheobject(player)
                end
            end
        end)
    else
        if esp_loop then
            esp_loop:Disconnect()
            for player in pairs(storage.esp_cache) do
                uncacheobject(player)
            end
        end
    end
end)



function isNumber(str)
    return tonumber(str) ~= nil or str == 'inf'
end

local hb = game:GetService("RunService").Heartbeat
local tpwalking = true

while tpwalking do
    local chr = getchr()
    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

    hum.JumpPower = getgenv().jumpheightvalue

    hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        hum.JumpPower = getgenv().jumpheightvalue
    end)
    while chr and hum and hum.Parent and tpwalking do
        if hum.MoveDirection.Magnitude > 0 then
            if tspeed and isNumber(tspeed) then
                chr:TranslateBy(hum.MoveDirection * tonumber(tspeed))
            else
                chr:TranslateBy(hum.MoveDirection)
            end
        end
        if not chr.Parent then break end
        hb:Wait()
    end
end
