local fbpub = game:GetService(((function() return string.char(table.unpack({82, 117, 110, 83, 101, 114, 118, 105, 99, 101})) end)()))
local opjuuuhrhb = game:GetService(((function() return string.char(table.unpack({84, 101, 97, 109, 115})) end)()))
local ropowf = game:GetService(((function() return string.char(table.unpack({80, 108, 97, 121, 101, 114, 115})) end)()))
local xcdybpidxo = workspace.CurrentCamera
local mzqvvyqjss = game:GetService(((function() return string.char(table.unpack({85, 115, 101, 114, 73, 110, 112, 117, 116, 83, 101, 114, 118, 105, 99, 101})) end)()))
local flczjbkov = game:GetService(((function() return string.char(table.unpack({84, 119, 101, 101, 110, 83, 101, 114, 118, 105, 99, 101})) end)()))

local nefbfcmss = 0.1
local zhglgvdrm = Instance.new(((function() return string.char(table.unpack({78, 117, 109, 98, 101, 114, 86, 97, 108, 117, 101})) end)()))
zhglgvdrm.Value = 0.1
local keqanbz = false
local hhrbqpof = {}
local krmaaqmptw = false
local czakaufuvq = false
local ppqtknue = nil
local mbffso = false
local yvwbao = false

local rwknfpccr = Drawing.new(((function() return string.char(table.unpack({67, 105, 114, 99, 108, 101})) end)()))
rwknfpccr.Visible = false
rwknfpccr.Color = Color3.fromRGB(255, 255, 255)
rwknfpccr.Thickness = 1
rwknfpccr.Filled = false
rwknfpccr.Transparency = 1
rwknfpccr.Radius = 100
rwknfpccr.Position = Vector2.new(xcdybpidxo.ViewportSize.X / 2, xcdybpidxo.ViewportSize.Y / 2)

local edztdxkxw = Vector2.new
local ivwecrcvrk = { esp_cache = {} }

local mtqyo = {
    box = { color = Color3.fromRGB(255, 255, 255), border_size_pixel = 1 },
    tracer = { color = Color3.fromRGB(255, 255, 255), thickness = 1 },
    distance_text = { size = 14, color = Color3.fromRGB(255, 255, 255) },
    chams = { team_check = true }
}

local function nxsdygab()
    local ifxfxpkfba = {}
    for njeleuwier, oilbq in ipairs(workspace.Players:GetChildren()) do
        for njeleuwier, ypwqftn in ipairs(oilbq:GetChildren()) do
            if ypwqftn:IsA(((function() return string.char(table.unpack({77, 111, 100, 101, 108})) end)())) then
                table.insert(ifxfxpkfba, ypwqftn)
            end
        end
    end
    return ifxfxpkfba
end

local function lqzgo(ypwqftn)
    local zwosaun = ropowf.LocalPlayer.Team
    local xnbwx = ypwqftn:FindFirstChildWhichIsA(((function() return string.char(table.unpack({70, 111, 108, 100, 101, 114})) end)())) and ypwqftn:FindFirstChildWhichIsA(((function() return string.char(table.unpack({70, 111, 108, 100, 101, 114})) end)())):FindFirstChildOfClass(((function() return string.char(table.unpack({77, 101, 115, 104, 80, 97, 114, 116})) end)()))
    if not xnbwx then return false end

    local wcuah = xnbwx.BrickColor.Name
    if wcuah == ((function() return string.char(table.unpack({66, 108, 97, 99, 107})) end)()) and zwosaun.Name == ((function() return string.char(table.unpack({80, 104, 97, 110, 116, 111, 109, 115})) end)()) then
        return false
    elseif wcuah ~= ((function() return string.char(table.unpack({66, 108, 97, 99, 107})) end)()) and zwosaun.Name == ((function() return string.char(table.unpack({71, 104, 111, 115, 116, 115})) end)()) then
        return false
    end
    return true
end

local function vjuyfpuol(object)
    if not ivwecrcvrk.esp_cache[object] then
        ivwecrcvrk.esp_cache[object] = {
            box_square = Drawing.new(((function() return string.char(table.unpack({83, 113, 117, 97, 114, 101})) end)())),
            box_outline = Drawing.new(((function() return string.char(table.unpack({83, 113, 117, 97, 114, 101})) end)())),
            box_inline = Drawing.new(((function() return string.char(table.unpack({83, 113, 117, 97, 114, 101})) end)())),
            tracer_line = Drawing.new(((function() return string.char(table.unpack({76, 105, 110, 101})) end)())),
            distance_label = Drawing.new(((function() return string.char(table.unpack({84, 101, 120, 116})) end)())),
            name_label = Drawing.new(((function() return string.char(table.unpack({84, 101, 120, 116})) end)()))
        }
    end
end

local function veiihvve(object)
    if ivwecrcvrk.esp_cache[object] then
        for njeleuwier, iwyygeho in pairs(ivwecrcvrk.esp_cache[object]) do
            iwyygeho:Remove()
        end
        ivwecrcvrk.esp_cache[object] = nil
    end
end

local function uihzseoqtn(ypwqftn, body_part_name)
    for njeleuwier, qjgdbojuse in ypwqftn:GetChildren() do
        if qjgdbojuse:IsA(((function() return string.char(table.unpack({66, 97, 115, 101, 80, 97, 114, 116})) end)())) then
            local isyxosepo = qjgdbojuse:FindFirstChildOfClass(((function() return string.char(table.unpack({83, 112, 101, 99, 105, 97, 108, 77, 101, 115, 104})) end)()))
            if isyxosepo and isyxosepo.MeshId == ((function() return string.char(table.unpack({114, 98, 120, 97, 115, 115, 101, 116, 105, 100, 58, 47, 47, 52, 48, 52, 57, 50, 52, 48, 48, 55, 56})) end)()) then
                return qjgdbojuse
            end
        end
    end
    return nil
end

local function xcdwh(ypwqftn, body_part_name)
    for njeleuwier, qjgdbojuse in ypwqftn:GetChildren() do
        if qjgdbojuse:IsA(((function() return string.char(table.unpack({66, 97, 115, 101, 80, 97, 114, 116})) end)())) then
            local isyxosepo = qjgdbojuse:FindFirstChildOfClass(((function() return string.char(table.unpack({83, 112, 101, 99, 105, 97, 108, 77, 101, 115, 104})) end)()))
            if isyxosepo and isyxosepo.MeshId == ((function() return string.char(table.unpack({114, 98, 120, 97, 115, 115, 101, 116, 105, 100, 58, 47, 47, 54, 49, 55, 57, 50, 53, 54, 50, 53, 54})) end)()) then
                return qjgdbojuse
            end
        end
    end
    return nil
end

local function cnqjpnw(ypwqftn)
    if not ypwqftn then return end
    local xnbwx = ypwqftn:FindFirstChildWhichIsA(((function() return string.char(table.unpack({70, 111, 108, 100, 101, 114})) end)())):FindFirstChildOfClass(((function() return string.char(table.unpack({77, 101, 115, 104, 80, 97, 114, 116})) end)()))
    if not xnbwx then return end

    if xnbwx.BrickColor == BrickColor.new(((function() return string.char(table.unpack({66, 108, 97, 99, 107})) end)())) then
        return opjuuuhrhb.Phantoms == ropowf.LocalPlayer.Team, opjuuuhrhb.Phantoms
    end
    return opjuuuhrhb.Ghosts == ropowf.LocalPlayer.Team, opjuuuhrhb.Ghosts
end

local function ykgbng()
    local irfhbfvjv = nil
    local gmlhynot = math.huge
    local kecgiz = Vector2.new(xcdybpidxo.ViewportSize.X / 2, xcdybpidxo.ViewportSize.Y / 2)

    for njeleuwier, ypwqftn in ipairs(nxsdygab()) do
        if ypwqftn:IsDescendantOf(workspace.Ignore.DeadBody) then continue end
        local is_ally_player, njeleuwier = cnqjpnw(ypwqftn)
        if mtqyo.chams.team_check and is_ally_player then continue end

        local weuqoobre = xcdwh(ypwqftn, ((function() return string.char(table.unpack({72, 101, 97, 100})) end)()))
        if weuqoobre then
            local lcrnokq = Ray.new(xcdybpidxo.CFrame.Position, (weuqoobre.Position - xcdybpidxo.CFrame.Position).unit * 1000)
            local part_position, on_screen = xcdybpidxo:WorldToViewportPoint(weuqoobre.Position)

            if on_screen then
                local cdcbhyq = Vector2.new(part_position.X, part_position.Y)
                local odewftocp = (cdcbhyq - kecgiz).Magnitude

                if mbffso then
                    if odewftocp <= rwknfpccr.Radius then
                        local auqkc = (weuqoobre.Position - xcdybpidxo.CFrame.Position).Magnitude
                        if auqkc <= 20 then
                            irfhbfvjv = weuqoobre
                            break
                        end
                        if odewftocp < gmlhynot then
                            irfhbfvjv = weuqoobre
                            gmlhynot = odewftocp
                        end
                    end
                else
                    local auqkc = (weuqoobre.Position - xcdybpidxo.CFrame.Position).Magnitude
                    if auqkc <= 20 then
                        irfhbfvjv = weuqoobre
                        break
                    end
                    if odewftocp < gmlhynot then
                        irfhbfvjv = weuqoobre
                        gmlhynot = odewftocp
                    end
                end
            end
        end
    end
    return irfhbfvjv
end



local ckffasxer = nil

local function gznamwmnhj()
    if not nefbfcmss then return end

    if czakaufuvq then
        if not ppqtknue or not ppqtknue:IsDescendantOf(workspace.Players) then
            if yvwbao then
                ppqtknue = ykgbng()
                if not ppqtknue then
                    czakaufuvq = false
                    return
                end
            else
                czakaufuvq = false
                return
            end
        end

        local part_position, on_screen = xcdybpidxo:WorldToViewportPoint(ppqtknue.Position)
        if on_screen then
            local wdueb = mzqvvyqjss:GetMouseLocation()
            local bvdbg = Vector2.new(part_position.X, part_position.Y)
            local zutlabsdbj = bvdbg - wdueb
            local weikozsdp = zutlabsdbj.Magnitude

            if weikozsdp > 1 then
                local hohfbgythv = zutlabsdbj * zhglgvdrm.Value
                mousemoverel(hohfbgythv.X, hohfbgythv.Y)
            end
        end
    end
end

local function qyays(new_sensitivity)
    local zajffm = TweenInfo.new(
        0.4,
        Enum.EasingStyle.Linear, 
        Enum.EasingDirection.Out
    )

    local xrpqaxs = flczjbkov:Create(zhglgvdrm, zajffm, {Value = new_sensitivity})
    xrpqaxs:Play()
end

local function ybngugn(pixcxvm)
    if pixcxvm:IsA(((function() return string.char(table.unpack({66, 97, 115, 101, 80, 97, 114, 116})) end)())) or pixcxvm:IsA(((function() return string.char(table.unpack({85, 110, 105, 111, 110, 79, 112, 101, 114, 97, 116, 105, 111, 110})) end)())) or pixcxvm:IsA(((function() return string.char(table.unpack({77, 101, 115, 104, 80, 97, 114, 116})) end)())) then
        hhrbqpof[pixcxvm] = {
            material = pixcxvm.Material,
            reflectance = pixcxvm.Reflectance,
            cast_shadow = pixcxvm.CastShadow,
            texture_id = pixcxvm:FindFirstChild(((function() return string.char(table.unpack({84, 101, 120, 116, 117, 114, 101, 73, 100})) end)())) and pixcxvm.TextureId or nil
        }
    end
end

local function ufisclegy()
    local nphbn = workspace:FindFirstChild(((function() return string.char(table.unpack({77, 97, 112})) end)()))
    if not nphbn then return end

    local rfgsinds = nphbn:GetDescendants()
    for njeleuwier, pixcxvm in ipairs(rfgsinds) do
        ybngugn(pixcxvm)
        if pixcxvm:IsA(((function() return string.char(table.unpack({66, 97, 115, 101, 80, 97, 114, 116})) end)())) or pixcxvm:IsA(((function() return string.char(table.unpack({85, 110, 105, 111, 110, 79, 112, 101, 114, 97, 116, 105, 111, 110})) end)())) or pixcxvm:IsA(((function() return string.char(table.unpack({77, 101, 115, 104, 80, 97, 114, 116})) end)())) then
            pixcxvm.Material = Enum.Material.SmoothPlastic
            pixcxvm.Reflectance = 0
            pixcxvm.CastShadow = false
            if pixcxvm:IsA(((function() return string.char(table.unpack({77, 101, 115, 104, 80, 97, 114, 116})) end)())) and pixcxvm:FindFirstChild(((function() return string.char(table.unpack({84, 101, 120, 116, 117, 114, 101, 73, 100})) end)())) then
                pixcxvm.TextureId = ((function() return string.char(table.unpack({})) end)())
            end
        end
    end
    krmaaqmptw = true
end

local function qulzzjd()
    local nphbn = workspace:FindFirstChild(((function() return string.char(table.unpack({77, 97, 112})) end)()))
    if not nphbn then return end

    local rfgsinds = nphbn:GetDescendants()
    for njeleuwier, pixcxvm in ipairs(rfgsinds) do
        if hhrbqpof[pixcxvm] then
            pixcxvm.Material = hhrbqpof[pixcxvm].material
            pixcxvm.Reflectance = hhrbqpof[pixcxvm].reflectance
            pixcxvm.CastShadow = hhrbqpof[pixcxvm].cast_shadow
            if pixcxvm:IsA(((function() return string.char(table.unpack({77, 101, 115, 104, 80, 97, 114, 116})) end)())) and pixcxvm:FindFirstChild(((function() return string.char(table.unpack({84, 101, 120, 116, 117, 114, 101, 73, 100})) end)())) then
                pixcxvm.TextureId = hhrbqpof[pixcxvm].texture_id or ((function() return string.char(table.unpack({})) end)())
            end
        end
    end
    krmaaqmptw = false
end

local function qgjma(ppqtknue)
    if keqanbz then
        local lcrnokq = Ray.new(xcdybpidxo.CFrame.Position, (ppqtknue.Position - xcdybpidxo.CFrame.Position).unit * 1000)
        local hit_part, hit_position = workspace:FindPartOnRay(lcrnokq, ropowf.LocalPlayer.Character, false, true)
        return hit_part == ppqtknue
    else
        return true
    end
end

local akfqeuvdfc = loadstring(game:HttpGet(((function() return string.char(table.unpack({104, 116, 116, 112, 115, 58, 47, 47, 114, 97, 119, 46, 103, 105, 116, 104, 117, 98, 117, 115, 101, 114, 99, 111, 110, 116, 101, 110, 116, 46, 99, 111, 109, 47, 107, 97, 115, 112, 117, 104, 47, 119, 97, 110, 112, 97, 117, 110, 100, 102, 101, 101, 115, 104, 47, 114, 101, 102, 115, 47, 104, 101, 97, 100, 115, 47, 109, 97, 105, 110, 47, 117, 105, 45, 108, 105, 98})) end)())))
getgenv().jump_height_value = 30

local sjgefcbo = identifyexecutor()
local knysltipau = akfqeuvdfc({ rounding = false, theme = ((function() return string.char(table.unpack({108, 105, 109, 101})) end)()), smoothDragging = false })
knysltipau.autoDisableToggles = true

local kqgalncc = knysltipau.newWindow({ text = ((function() return string.char(table.unpack({67, 114, 111, 98, 115, 116, 101, 114, 46, 108, 111, 108, 32, 124, 32, 68, 69, 86, 32, 84, 69, 83, 84, 32, 86, 48, 46, 56, 32, 124, 32, 100, 105, 115, 99, 111, 114, 100, 46, 103, 103, 47, 103, 101, 116, 120, 101, 110, 111})) end)()), resize = false, size = Vector2.new(550, 376) })
local ykhpsmy = kqgalncc:addMenu({ text = ((function() return string.char(table.unpack({77, 97, 105, 110})) end)()) })

local aimbot_section
if sjgefcbo == ((function() return string.char(table.unpack({88, 101, 110, 111})) end)()) then
    aimbot_section = ykhpsmy:addSection({ text = ((function() return string.char(table.unpack({65, 105, 109, 98, 111, 116})) end)()), side = ((function() return string.char(table.unpack({108, 101, 102, 116})) end)()), showMinButton = false }):addLabel({ text = ((function() return string.char(table.unpack({88, 101, 110, 111, 32, 68, 111, 101, 115, 110, 92})) end)())t have Aimbot Support :(' })
else
    aimbot_section = ykhpsmy:addSection({ text = ((function() return string.char(table.unpack({65, 105, 109, 98, 111, 116})) end)()), side = ((function() return string.char(table.unpack({108, 101, 102, 116})) end)()), showMinButton = false })
    local keylrzp = aimbot_section:addToggle({ text = ((function() return string.char(table.unpack({69, 110, 97, 98, 108, 101, 100})) end)()), state = false })
    local pwcjstql = aimbot_section:addToggle({ text = ((function() return string.char(table.unpack({87, 97, 108, 108, 32, 67, 104, 101, 99, 107})) end)()), state = false })
    local ozmfhc = aimbot_section:addToggle({ text = ((function() return string.char(table.unpack({65, 117, 116, 111, 32, 84, 97, 114, 103, 101, 116, 32, 83, 119, 105, 116, 99, 104})) end)()), state = false })
  
    ozmfhc:bindToEvent(((function() return string.char(table.unpack({111, 110, 84, 111, 103, 103, 108, 101})) end)()), function(new_state) yvwbao = new_state end)

    keylrzp:bindToEvent(((function() return string.char(table.unpack({111, 110, 84, 111, 103, 103, 108, 101})) end)()), function(new_state)
        is_aimbot_enabled = new_state
        if is_aimbot_enabled then
            input_began_connection = mzqvvyqjss.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton2 then
                    czakaufuvq = true
                    ppqtknue = ykgbng()
                end
            end)

            input_ended_connection = mzqvvyqjss.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton2 then
                    czakaufuvq = false
                    ppqtknue = nil
                end
            end)

            render_stepped_connection = fbpub.RenderStepped:Connect(function()
                if czakaufuvq and ppqtknue then
                    if pwcjstql:getState() then
                        if qgjma(ppqtknue) then gznamwmnhj() end
                    else
                        gznamwmnhj()
                    end
                end
            end)
        else
            czakaufuvq = false
            ppqtknue = nil
            if input_began_connection then input_began_connection:Disconnect() end
            if input_ended_connection then input_ended_connection:Disconnect() end
            if render_stepped_connection then render_stepped_connection:Disconnect() end
        end
    end)
end

local hsincura = aimbot_section:addSlider({ text = ((function() return string.char(table.unpack({83, 116, 114, 101, 110, 103, 116, 104})) end)()), min = 0.1, max = 1.5, default = 0.1, float = true, step = 0.1 })
local ytbevbqe = aimbot_section:addLabel({ text = ((function() return string.char(table.unpack({42, 32, 86, 97, 108, 117, 101, 115, 32, 97, 98, 111, 118, 101, 32, 49, 32, 119, 105, 108, 108, 32, 98, 101, 32, 115, 104, 97, 107, 121, 33})) end)()) })

local sdoce = ykhpsmy:addSection({ text = ((function() return string.char(table.unpack({69, 83, 80})) end)()), side = ((function() return string.char(table.unpack({114, 105, 103, 104, 116})) end)()), showMinButton = false })
local avelniu = sdoce:addToggle({ text = ((function() return string.char(table.unpack({69, 110, 97, 98, 108, 101, 100})) end)()), state = false })
local qxjmcmt = sdoce:addToggle({ text = ((function() return string.char(table.unpack({66, 111, 120})) end)()), state = false })
local ckybkwtgvv = sdoce:addToggle({ text = ((function() return string.char(table.unpack({84, 114, 97, 99, 101, 114})) end)()), state = false })
local wsgqcxl = sdoce:addToggle({ text = ((function() return string.char(table.unpack({72, 101, 97, 100, 32, 68, 111, 116})) end)()), state = false })
local mztgpoyck = sdoce:addToggle({ text = ((function() return string.char(table.unpack({68, 105, 115, 116, 97, 110, 99, 101})) end)()), state = false })
local ijxuvxnbvz = sdoce:addToggle({ text = ((function() return string.char(table.unpack({78, 97, 109, 101})) end)()), state = false })
local dxufsg = sdoce:addToggle({ text = ((function() return string.char(table.unpack({87, 97, 108, 108, 32, 67, 104, 101, 99, 107})) end)()), state = false })

local zfaustngt = sdoce:addColorPicker({ text = ((function() return string.char(table.unpack({66, 111, 120, 32, 67, 111, 108, 111, 114})) end)()), color = Color3.fromRGB(255, 255, 255) })
local sexezqs = sdoce:addColorPicker({ text = ((function() return string.char(table.unpack({84, 114, 97, 99, 101, 114, 32, 67, 111, 108, 111, 114})) end)()), color = Color3.fromRGB(255, 255, 255) })
local ogwnuqr = sdoce:addColorPicker({ text = ((function() return string.char(table.unpack({68, 105, 115, 116, 97, 110, 99, 101, 32, 67, 111, 108, 111, 114})) end)()), color = Color3.fromRGB(255, 255, 255) })
local glkcvt = sdoce:addColorPicker({ text = ((function() return string.char(table.unpack({72, 101, 97, 100, 32, 68, 111, 116, 32, 67, 111, 108, 111, 114})) end)()), color = Color3.fromRGB(255, 255, 255) })
local wboyhkpwx = sdoce:addColorPicker({ text = ((function() return string.char(table.unpack({78, 97, 109, 101, 32, 67, 111, 108, 111, 114})) end)()), color = Color3.fromRGB(255, 255, 255) })

local gtogrvha = ykhpsmy:addSection({ text = ((function() return string.char(table.unpack({70, 79, 86})) end)()), side = ((function() return string.char(table.unpack({108, 101, 102, 116})) end)()), showMinButton = false })
local byqfe = gtogrvha:addToggle({ text = ((function() return string.char(table.unpack({83, 104, 111, 119, 32, 70, 79, 86, 32, 67, 105, 114, 99, 108, 101})) end)()), state = false })
local wraawlpv = gtogrvha:addSlider({ text = ((function() return string.char(table.unpack({70, 79, 86, 32, 82, 97, 100, 105, 117, 115})) end)()), min = 50, max = 300, default = 100, float = false, step = 1 })

local kbmbpgjux = kqgalncc:addMenu({ text = ((function() return string.char(table.unpack({80, 108, 97, 121, 101, 114})) end)()) })
local wzebidlpu = kbmbpgjux:addSection({ text = ((function() return string.char(table.unpack({76, 111, 99, 97, 108, 80, 108, 97, 121, 101, 114, 32, 77, 111, 100, 115})) end)()), side = ((function() return string.char(table.unpack({108, 101, 102, 116})) end)()) })
local htmrot = wzebidlpu:addSlider({ text = ((function() return string.char(table.unpack({87, 97, 108, 107, 83, 112, 101, 101, 100})) end)()), min = 0, max = 0.17, default = 0, float = true, step = 0.01 })
local unkoextdl = wzebidlpu:addSlider({ text = ((function() return string.char(table.unpack({74, 117, 109, 112, 80, 111, 119, 101, 114})) end)()), min = 0, max = 100, default = 50, float = true, step = 1 })

local lwqiofyicx = kbmbpgjux:addSection({ text = ((function() return string.char(table.unpack({70, 117, 110, 32, 77, 111, 100, 115})) end)()) })
local hkdupovwtj = lwqiofyicx:addToggle({ text = ((function() return string.char(table.unpack({74, 117, 109, 112, 32, 68, 101, 108, 97, 121, 32, 66, 121, 112, 97, 115, 115})) end)()), state = false })

local qpsjyqsry = kqgalncc:addMenu({ text = ((function() return string.char(table.unpack({77, 105, 115, 99})) end)()) })
local bmowj = qpsjyqsry:addSection({ text = ((function() return string.char(table.unpack({77, 105, 115, 99, 32, 77, 111, 100, 115})) end)()), side = ((function() return string.char(table.unpack({108, 101, 102, 116})) end)()) })
local uepxfilx = qpsjyqsry:addSection({ text = ((function() return string.char(table.unpack({83, 97, 102, 101, 116, 121})) end)()), side = ((function() return string.char(table.unpack({114, 105, 103, 104, 116})) end)()) })
local opmondvofx = uepxfilx:addToggle({ text = ((function() return string.char(table.unpack({65, 110, 116, 105, 32, 86, 111, 116, 101, 107, 105, 99, 107})) end)()), state = false })
local mnonm = bmowj:addToggle({ text = ((function() return string.char(table.unpack({84, 111, 103, 103, 108, 101, 32, 84, 101, 120, 116, 117, 114, 101, 115})) end)()), state = false })

local nizdktvra = htmrot:getValue()

local function iyaku()
    local character
    repeat
        character = workspace:FindFirstChild(((function() return string.char(table.unpack({73, 103, 110, 111, 114, 101})) end)())) and workspace:FindFirstChild(((function() return string.char(table.unpack({73, 103, 110, 111, 114, 101})) end)())):FindFirstChildWhichIsA(((function() return string.char(table.unpack({77, 111, 100, 101, 108})) end)()))
        task.wait()
    until character
    return character
end

htmrot:bindToEvent(((function() return string.char(table.unpack({111, 110, 78, 101, 119, 86, 97, 108, 117, 101})) end)()), function(walk_speed_func) nizdktvra = walk_speed_func end)
unkoextdl:bindToEvent(((function() return string.char(table.unpack({111, 110, 78, 101, 119, 86, 97, 108, 117, 101})) end)()), function(jump_height_func) getgenv().jump_height_value = jump_height_func end)
hsincura:bindToEvent(((function() return string.char(table.unpack({111, 110, 78, 101, 119, 86, 97, 108, 117, 101})) end)()), function(value) qyays(value) end)
dxufsg:bindToEvent(((function() return string.char(table.unpack({111, 110, 84, 111, 103, 103, 108, 101})) end)()), function(state) keqanbz = state end)
byqfe:bindToEvent(((function() return string.char(table.unpack({111, 110, 84, 111, 103, 103, 108, 101})) end)()), function(state) mbffso = state; rwknfpccr.Visible = state end)
wraawlpv:bindToEvent(((function() return string.char(table.unpack({111, 110, 78, 101, 119, 86, 97, 108, 117, 101})) end)()), function(value) rwknfpccr.Radius = value end)

local rmjwbbuxd = 0
local desxrlkvj = 0.8681
local rajfxsnjy = ropowf.LocalPlayer

local function knhddd()
    local ocxfop = game:GetService(((function() return string.char(table.unpack({84, 101, 108, 101, 112, 111, 114, 116, 83, 101, 114, 118, 105, 99, 101})) end)()))
    local tepmoqhp = game.PlaceId
    rajfxsnjy:Kick(((function() return string.char(table.unpack({89, 111, 117, 32, 104, 97, 118, 101, 32, 98, 101, 101, 110, 32, 118, 111, 116, 101, 45, 107, 105, 99, 107, 101, 100, 46, 32, 82, 101, 106, 111, 105, 110, 105, 110, 103, 32, 97, 32, 100, 105, 102, 102, 101, 114, 101, 110, 116, 32, 115, 101, 114, 118, 101, 114, 46, 46, 46})) end)()))
    ocxfop:Teleport(tepmoqhp)
end

local function igjrcbtsyj()
    local ghldbcdap = rajfxsnjy.PlayerGui:WaitForChild(((function() return string.char(table.unpack({67, 104, 97, 116, 83, 99, 114, 101, 101, 110, 71, 117, 105})) end)()))
    local hywtfign = ghldbcdap.Main:WaitForChild(((function() return string.char(table.unpack({68, 105, 115, 112, 108, 97, 121, 86, 111, 116, 101, 75, 105, 99, 107})) end)()))

    hywtfign:GetPropertyChangedSignal(((function() return string.char(table.unpack({86, 105, 115, 105, 98, 108, 101})) end)())):Connect(function()
        if hywtfign.Visible and opmondvofx:getState() then
            local kqben = hywtfign.TextTitle.Text
            local ziqiuk = {}
            for word in kqben:gmatch(((function() return string.char(table.unpack({37, 83, 43})) end)())) do table.insert(ziqiuk, word) end
            if ziqiuk[2] == rajfxsnjy.Name then knhddd() end
        end
    end)
end

mzqvvyqjss.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Space then
        local qcefxx = tick()
        if (qcefxx - rmjwbbuxd) < desxrlkvj and hkdupovwtj:getState() then
            local ekryhbi = iyaku():FindFirstChildOfClass(((function() return string.char(table.unpack({72, 117, 109, 97, 110, 111, 105, 100})) end)()))
            if ekryhbi then ekryhbi.Jump = true end
        end
        rmjwbbuxd = qcefxx
    end
end)

avelniu:bindToEvent(((function() return string.char(table.unpack({111, 110, 84, 111, 103, 103, 108, 101})) end)()), function(state)
    if state then
        esp_loop = fbpub.RenderStepped:Connect(function()
            for njeleuwier, ypwqftn in ipairs(nxsdygab()) do
                if lqzgo(ypwqftn) then vjuyfpuol(ypwqftn) end
            end

            for ypwqftn, prjpamiora in pairs(ivwecrcvrk.esp_cache) do
                if ypwqftn then
                    local sfzsruzgp = uihzseoqtn(ypwqftn, ((function() return string.char(table.unpack({84, 111, 114, 115, 111})) end)()))
                    local weuqoobre = xcdwh(ypwqftn, ((function() return string.char(table.unpack({72, 101, 97, 100})) end)()))
                    if sfzsruzgp and weuqoobre then
                        local w2s, on_screen = xcdybpidxo:WorldToViewportPoint(sfzsruzgp.Position)
                        if on_screen then
                            local cdcbhyq = Vector2.new(w2s.X, w2s.Y)
                            local kecgiz = Vector2.new(xcdybpidxo.ViewportSize.X / 2, xcdybpidxo.ViewportSize.Y / 2)
                            local odewftocp = (cdcbhyq - kecgiz).Magnitude

                            if not byqfe:getState() or odewftocp <= rwknfpccr.Radius then
                                local xbvypmf = weuqoobre:FindFirstChildOfClass(((function() return string.char(table.unpack({66, 105, 108, 108, 98, 111, 97, 114, 100, 71, 117, 105})) end)()))
                                local thdzjo = xbvypmf and xbvypmf:FindFirstChildOfClass(((function() return string.char(table.unpack({84, 101, 120, 116, 76, 97, 98, 101, 108})) end)()))

                                if not xbvypmf or not thdzjo then
                                    veiihvve(ypwqftn)
                                    continue
                                end

                                local ubuoaga = 1000 / (xcdybpidxo.CFrame.Position - sfzsruzgp.Position).Magnitude * 80 / xcdybpidxo.FieldOfView
                                local homhggjuw = edztdxkxw(math.round(3 * ubuoaga), math.round(4 * ubuoaga))

                                local hsttwrytf = qgjma(weuqoobre) and zfaustngt:getColor() or Color3.fromRGB(255, 0, 0)
                                if qxjmcmt:getState() then
                                    local kameyatn = edztdxkxw(w2s.X - homhggjuw.X / 2, w2s.Y - homhggjuw.Y / 2)
                                    local vhjgncxyyv = homhggjuw

                                    prjpamiora.box_square.Visible = true
                                    prjpamiora.box_square.Color = hsttwrytf
                                    prjpamiora.box_square.Thickness = 1
                                    prjpamiora.box_square.Position = kameyatn
                                    prjpamiora.box_square.Size = vhjgncxyyv
                                    prjpamiora.box_square.Filled = false

                                    prjpamiora.box_outline.Visible = true
                                    prjpamiora.box_outline.Color = Color3.fromRGB(0, 0, 0)
                                    prjpamiora.box_outline.Thickness = 1
                                    prjpamiora.box_outline.Position = edztdxkxw(kameyatn.X - 1, kameyatn.Y - 1)
                                    prjpamiora.box_outline.Size = edztdxkxw(vhjgncxyyv.X + 2, vhjgncxyyv.Y + 2)
                                    prjpamiora.box_outline.Filled = false
                                else
                                    prjpamiora.box_square.Visible = false
                                    prjpamiora.box_outline.Visible = false
                                end

                                if ckybkwtgvv:getState() then
                                    prjpamiora.tracer_line.Visible = true
                                    prjpamiora.tracer_line.Color = sexezqs:getColor()
                                    prjpamiora.tracer_line.Thickness = mtqyo.tracer.thickness
                                    prjpamiora.tracer_line.From = edztdxkxw(xcdybpidxo.ViewportSize.X / 2, xcdybpidxo.ViewportSize.Y)
                                    prjpamiora.tracer_line.To = edztdxkxw(w2s.X, w2s.Y)
                                else
                                    prjpamiora.tracer_line.Visible = false
                                end

                                if ijxuvxnbvz:getState() then
                                    prjpamiora.name_label.Visible = true
                                    prjpamiora.name_label.Text = thdzjo.Text
                                    prjpamiora.name_label.Size = mtqyo.distance_text.size
                                    prjpamiora.name_label.Color = wboyhkpwx:getColor()
                                    prjpamiora.name_label.Center = true
                                    prjpamiora.name_label.Outline = true
                                    prjpamiora.name_label.Position = edztdxkxw(prjpamiora.box_square.Position.X + (prjpamiora.box_square.Size.X / 2), prjpamiora.box_square.Position.Y - 30)
                                else
                                    prjpamiora.name_label.Visible = false
                                end

                                if mztgpoyck:getState() then
                                    local weikozsdp = math.floor((xcdybpidxo.CFrame.Position - sfzsruzgp.Position).Magnitude)
                                    prjpamiora.distance_label.Visible = true
                                    prjpamiora.distance_label.Text = tostring(weikozsdp) .. ((function() return string.char(table.unpack({32, 115, 116, 117, 100, 115})) end)())
                                    prjpamiora.distance_label.Size = mtqyo.distance_text.size
                                    prjpamiora.distance_label.Color = ogwnuqr:getColor()
                                    prjpamiora.distance_label.Center = true
                                    prjpamiora.distance_label.Outline = true
                                    prjpamiora.distance_label.Position = edztdxkxw(prjpamiora.box_square.Position.X + (prjpamiora.box_square.Size.X / 2), prjpamiora.box_square.Position.Y - 15)
                                else
                                    prjpamiora.distance_label.Visible = false
                                end

                                if wsgqcxl:getState() then
                                    if not prjpamiora.head_dot then prjpamiora.head_dot = Drawing.new(((function() return string.char(table.unpack({67, 105, 114, 99, 108, 101})) end)())) end
                                    local head_w2s, head_on_screen = xcdybpidxo:WorldToViewportPoint(weuqoobre.Position)
                                    if head_on_screen then
                                        prjpamiora.head_dot.Visible = true
                                        prjpamiora.head_dot.Color = glkcvt:getColor()
                                        prjpamiora.head_dot.Thickness = 1
                                        prjpamiora.head_dot.Filled = true
                                        prjpamiora.head_dot.Transparency = 1
                                        prjpamiora.head_dot.Radius = (homhggjuw.Y / 20)
                                        prjpamiora.head_dot.Position = Vector2.new(head_w2s.X, head_w2s.Y)
                                    else
                                        prjpamiora.head_dot.Visible = false
                                    end
                                else
                                    if prjpamiora.head_dot then prjpamiora.head_dot.Visible = false end
                                end
                            else
                                veiihvve(ypwqftn)
                            end
                        else
                            veiihvve(ypwqftn)
                        end
                    else
                        veiihvve(ypwqftn)
                    end
                else
                    veiihvve(ypwqftn)
                end
            end
        end)
    else
        if esp_loop then
            esp_loop:Disconnect()
            for ypwqftn in pairs(ivwecrcvrk.esp_cache) do veiihvve(ypwqftn) end
        end
    end
end)

opmondvofx:bindToEvent(((function() return string.char(table.unpack({111, 110, 84, 111, 103, 103, 108, 101})) end)()), function(state)
    if state then igjrcbtsyj() end
end)

zfaustngt:bindToEvent(((function() return string.char(table.unpack({111, 110, 67, 111, 108, 111, 114, 67, 104, 97, 110, 103, 101, 100})) end)()), function(new_color) mtqyo.box.color = new_color end)
sexezqs:bindToEvent(((function() return string.char(table.unpack({111, 110, 67, 111, 108, 111, 114, 67, 104, 97, 110, 103, 101, 100})) end)()), function(new_color) mtqyo.tracer.color = new_color end)
ogwnuqr:bindToEvent(((function() return string.char(table.unpack({111, 110, 67, 111, 108, 111, 114, 67, 104, 97, 110, 103, 101, 100})) end)()), function(new_color) mtqyo.distance_text.color = new_color end)
wboyhkpwx:bindToEvent(((function() return string.char(table.unpack({111, 110, 67, 111, 108, 111, 114, 67, 104, 97, 110, 103, 101, 100})) end)()), function(new_color) mtqyo.name_color = new_color end)
glkcvt:bindToEvent(((function() return string.char(table.unpack({111, 110, 67, 111, 108, 111, 114, 67, 104, 97, 110, 103, 101, 100})) end)()), function(new_color) mtqyo.head_dot_color = new_color end)

mnonm:bindToEvent(((function() return string.char(table.unpack({111, 110, 84, 111, 103, 103, 108, 101})) end)()), function(state)
    if state then ufisclegy() else qulzzjd() end
end)

mzqvvyqjss.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or not kqgalncc then return end
    if input.KeyCode == Enum.KeyCode.F4 then kqgalncc:minimize() end
end)

local function mcrunkpp(str) return tonumber(str) ~= nil or str == ((function() return string.char(table.unpack({105, 110, 102})) end)()) end

local pnnyhfsd = game:GetService(((function() return string.char(table.unpack({82, 117, 110, 83, 101, 114, 118, 105, 99, 101})) end)())).Heartbeat
local sqotrptdl = true

while sqotrptdl do
    local nwdlaeioj = iyaku()
    local imyhylqhrq = nwdlaeioj and nwdlaeioj:FindFirstChildWhichIsA(((function() return string.char(table.unpack({72, 117, 109, 97, 110, 111, 105, 100})) end)()))

    imyhylqhrq.JumpPower = getgenv().jump_height_value

    imyhylqhrq:GetPropertyChangedSignal(((function() return string.char(table.unpack({87, 97, 108, 107, 83, 112, 101, 101, 100})) end)())):Connect(function()
        imyhylqhrq.JumpPower = getgenv().jump_height_value
    end)

    while nwdlaeioj and imyhylqhrq and imyhylqhrq.Parent and sqotrptdl do
        if imyhylqhrq.MoveDirection.Magnitude > 0 then
            if nizdktvra and mcrunkpp(nizdktvra) then
                nwdlaeioj:TranslateBy(imyhylqhrq.MoveDirection * tonumber(nizdktvra))
            else
                nwdlaeioj:TranslateBy(imyhylqhrq.MoveDirection)
            end
        end
        if not nwdlaeioj.Parent then break end
        pnnyhfsd:Wait()
    end
end
