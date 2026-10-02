
if getrawmetatable and setreadonly then
    local mt = getrawmetatable(game)
    if not isreadonly(mt) then
        pcall(function()
            game:GetService("Players").LocalPlayer:Kick("❌ ตรวจพบความผิดปกติในการดักจับระบบ (Security Violation)")
        end)
        return
    end
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local AuthorizedUserIds = {
    [3119767321] = true,
    [9802544328] = true,
    [3876844265] = true,
    [3541039823] = true,
    [6030349781] = true,
}

if not AuthorizedUserIds[LocalPlayer.UserId] then
    pcall(function()
        LocalPlayer:Kick("ซื้อสคริปต์ผมหน่อยพี่")
    end)
    return
end

local CurrentSelectedPlayer = nil
local StatusLabel = nil
local CurrentViewMode = 1
local PlayerButtons = {}
local ListeningLocalSound = nil
local IsListeningRealTime = false

local ProtectedCreatorUsers = {
    ["kfc_punyai"] = true,
    ["Aekshop_34d3c"] = true,
    ["ffsww_1007"] = true,
    ["Haren_902"] = true,
}

local function isAdmin(player)
    if not player then return false end
    return ProtectedCreatorUsers[player.Name] == true
end

local SpecificRE = ReplicatedStorage:FindFirstChild("RE") and ReplicatedStorage.RE:FindFirstChild("1Ca1r")
local ScooterRE = ReplicatedStorage:FindFirstChild("RE") and ReplicatedStorage.RE:FindFirstChild("1NoMoto1rVehicle1s")

local function ForcePlayMusicCombo(musicId)
    if not musicId or musicId == "" then return false end
    local re = ReplicatedStorage:FindFirstChild("RE")
    if not re then return false end
    
    local success1, success2, success3, success4 = false, false, false, false
    local toolEvent = re:FindFirstChild("PlayerToolEvent")
    if toolEvent then
        local args1 = { "ToolMusicText", tostring(musicId), "", [4] = true }
        success1 = pcall(function() toolEvent:FireServer(unpack(args1)) end)
    end
    
    local vehicleEvent = re:FindFirstChild("1NoMoto1rVehicle1s")
    if vehicleEvent then
        local args2 = { "ToolMusicText", tostring(musicId), "", [4] = true }
        success2 = pcall(function() vehicleEvent:FireServer(unpack(args2)) end)
        
        local args3 = { "PickingScooterMusicText", tostring(musicId), "", [4] = true }
        success3 = pcall(function() vehicleEvent:FireServer(unpack(args3)) end)
    end

    if SpecificRE then
        pcall(function() SpecificRE:FireServer("ToolMusicText", tostring(musicId), "", true) end)
    end

    if ScooterRE then
        success4 = pcall(function() ScooterRE:FireServer("PickingScooterMusicText", tostring(musicId), nil, true) end)
    end

    return success1 or success2 or success3 or success4
end

local BlockedIDs = {
    ["54410081542"] = true, ["70999314371231"] = true, ["71352236"] = true, ["76500780055460"] = true,
    ["78515442941510"] = true, ["90533928572341"] = true, ["99721399503975"] = true
}

local function urlDecode(str)
    if not str then return "" end
    str = string.gsub(str, "+", " ")
    return (string.gsub(str, "%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end))
end

local function hexDecode(str)
    if not str then return "" end
    str = string.gsub(str, "0x", ""):gsub("\\x", ""):gsub("%%", ""):gsub("%s+", "")
    if string.match(str, "^%x+$") and #str % 2 == 0 then
        local decoded = ""
        for i = 1, #str, 2 do
            local byte = tonumber(string.sub(str, i, i+1), 16)
            if byte then decoded = decoded .. string.char(byte) end
        end
        if #decoded > 0 then return decoded end
    end
    return str
end

local function deepDecode(str)
    if type(str) ~= "string" then return str end
    local prev
    repeat
        prev = str
        str = urlDecode(str)
        str = hexDecode(str)
    until str == prev
    return str
end

local function extractIDsFromPattern(text)
    local ids = {}
    local patterns = {
        "69%%64=([^&]*)", "&id=([^&]*)", "id=([^&]*)",
        "audio=([^&]*)", "song=([^&]*)", "music=([^&]*)",
        "%%69%%64=([^&]*)", "&%%69%%64=([^&]*)",
        "9%s*d%s*=%s*([^&]*)", "9d=([^&]*)", "9_d=([^&]*)", "9%%20d%%20=([^&]*)"
    }
    for _, pat in ipairs(patterns) do
        for capture in string.gmatch(text, pat) do
            for num in string.gmatch(capture, "%d+") do
                if not BlockedIDs[num] then table.insert(ids, num) end
            end
        end
    end
    return ids
end

local function getPlayerVehicle(player)
    if not player or not player.Character then return nil end
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid or not humanoid.SeatPart then return nil end
    local vehicle = humanoid.SeatPart.Parent
    while vehicle and not vehicle:IsA("Model") do vehicle = vehicle.Parent end
    return (vehicle and vehicle:IsA("Model")) and vehicle or nil
end

local function checkPlayerAllSounds(targetPlayer)
    if not targetPlayer then return {} end
    if isAdmin(targetPlayer) and not isAdmin(LocalPlayer) then return {} end

    local scanTargets = {}
    if targetPlayer.Character then table.insert(scanTargets, targetPlayer.Character) end
    local backpack = targetPlayer:FindFirstChild("Backpack")
    if backpack then table.insert(scanTargets, backpack) end
    local vehicle = getPlayerVehicle(targetPlayer)
    if vehicle then table.insert(scanTargets, vehicle) end

    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") then
            local lowerName = string.lower(obj.Name)
            if string.find(lowerName, "sled") or string.find(lowerName, "scooter") or string.find(lowerName, "vehicle") or string.find(lowerName, "bike") or string.find(lowerName, "car") then
                local ownerVal = obj:FindFirstChild("Owner") or obj:FindFirstChild("Player") or obj:FindFirstChild("VehicleOwner")
                local isOwner = ownerVal and (ownerVal.Value == targetPlayer or ownerVal.Value == targetPlayer.Name)
                
                if not isOwner then
                    for _, child in ipairs(obj:GetDescendants()) do
                        if child:IsA("VehicleSeat") or child:IsA("Seat") then
                            if child.Occupant and child.Occupant.Parent == targetPlayer.Character then
                                isOwner = true
                                break
                            end
                        end
                    end
                end

                if isOwner then table.insert(scanTargets, obj) end
            end
        end
    end

    local validSounds = {}
    local soundMap = {}
    local NameBlacklist = { 
        ["gettingup"] = true, ["died"] = true, ["freefalling"] = true, 
        ["jumping"] = true, ["landing"] = true, ["running"] = true, 
        ["water"] = true, ["footstep"] = true, ["fart1"] = true, 
        ["climbing"] = true, ["swimming"] = true, ["splash"] = true
    }

    for _, folder in ipairs(scanTargets) do
        local success, descendants = pcall(function() return folder:GetDescendants() end)
        if success and descendants then
            for _, obj in ipairs(descendants) do
                if obj:IsA("Sound") and obj.SoundId ~= "" then
                    local objNameLower = string.lower(obj.Name)
                    local isBlacklisted = false
                    for blockedName, _ in pairs(NameBlacklist) do
                        if string.find(objNameLower, blockedName) then
                            isBlacklisted = true
                            break
                        end
                    end

                    if not isBlacklisted and not soundMap[obj.SoundId] then
                        soundMap[obj.SoundId] = true
                        table.insert(validSounds, obj)
                    end
                end
            end
        end
    end
    return validSounds
end

local function copyToClipboard(text)
    local setclip = setclipboard or toclipboard or (Clipboard and Clipboard.set)
    if setclip then setclip(text) end
end

local GuiParent = (gethui and gethui()) or CoreGui:FindFirstChild("RobloxGui") or PlayerGui
if GuiParent:FindFirstChild("HonkukiUltimateAudioGui") then
    GuiParent.HonkukiUltimateAudioGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", GuiParent)
ScreenGui.Name = "HonkukiUltimateAudioGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local OpenSoundId = 70452176150315
local CloseSoundId = 115916891254154
local GetIDSoundId = 542332175

local function playUISound(assetId)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. tostring(assetId)
    sound.Volume = 0.8
    sound.Parent = SoundService or PlayerGui
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end

-- ==================== MAIN UI FRAME ====================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 480, 0, 320)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(140, 60, 230)
MainStroke.Thickness = 2

-- Background Animated Meteor Shower Canvas
local BackgroundCanvas = Instance.new("Frame", MainFrame)
BackgroundCanvas.Name = "BackgroundCanvas"
BackgroundCanvas.Size = UDim2.new(1, 0, 1, 0)
BackgroundCanvas.BackgroundTransparency = 1
BackgroundCanvas.ClipsDescendants = true
BackgroundCanvas.ZIndex = 1

local math_random = math.random
local function createMeteor()
    if not ScreenGui.Parent then return end
    local meteor = Instance.new("Frame", BackgroundCanvas)
    local sizeW = math_random(2, 3)
    local sizeH = math_random(25, 45)
    meteor.Size = UDim2.new(0, sizeW, 0, sizeH)
    
    local startX = math_random(-50, 500)
    meteor.Position = UDim2.new(0, startX, 0, -50)
    meteor.BackgroundColor3 = Color3.fromRGB(220, 150, 255)
    meteor.BorderSizePixel = 0
    meteor.Rotation = -35
    meteor.ZIndex = 1
    Instance.new("UICorner", meteor).CornerRadius = UDim.new(1, 0)

    local meteorGradient = Instance.new("UIGradient", meteor)
    meteorGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(180, 80, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 10, 120))
    }
    meteorGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    }

    local fallTime = math_random(12, 22) / 10
    local tween = TweenService:Create(meteor, TweenInfo.new(fallTime, Enum.EasingStyle.Linear), {
        Position = UDim2.new(0, startX + 180, 0, 380),
        BackgroundTransparency = 1
    })
    tween:Play()
    tween.Completed:Connect(function()
        meteor:Destroy()
    end)
end

task.spawn(function()
    while ScreenGui.Parent do
        createMeteor()
        task.wait(0.25)
    end
end)

-- 3D Stylized Button Creator Function
local function create3DButton(parent, size, pos, text, bgCol, topCol)
    local btnContainer = Instance.new("Frame", parent)
    btnContainer.Size = size
    btnContainer.Position = pos
    btnContainer.BackgroundTransparency = 1
    btnContainer.ZIndex = 5

    local btnShadow = Instance.new("Frame", btnContainer)
    btnShadow.Size = UDim2.new(1, 0, 1, 0)
    btnShadow.Position = UDim2.new(0, 0, 0, 4)
    btnShadow.BackgroundColor3 = bgCol or Color3.fromRGB(45, 15, 75)
    btnShadow.BorderSizePixel = 0
    btnShadow.ZIndex = 5
    Instance.new("UICorner", btnShadow).CornerRadius = UDim.new(0, 8)

    local btnTop = Instance.new("TextButton", btnContainer)
    btnTop.Size = UDim2.new(1, 0, 1, 0)
    btnTop.Position = UDim2.new(0, 0, 0, 0)
    btnTop.BackgroundColor3 = topCol or Color3.fromRGB(120, 45, 190)
    btnTop.Text = text
    btnTop.Font = Enum.Font.SpecialElite
    btnTop.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnTop.TextSize = 12
    btnTop.AutoButtonColor = false
    btnTop.BorderSizePixel = 0
    btnTop.ZIndex = 6
    Instance.new("UICorner", btnTop).CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke", btnTop)
    stroke.Color = Color3.fromRGB(200, 120, 255)
    stroke.Thickness = 1

    btnTop.MouseButton1Down:Connect(function()
        btnTop.Position = UDim2.new(0, 0, 0, 3)
    end)
    btnTop.MouseButton1Up:Connect(function()
        btnTop.Position = UDim2.new(0, 0, 0, 0)
    end)
    btnTop.MouseLeave:Connect(function()
        btnTop.Position = UDim2.new(0, 0, 0, 0)
    end)

    return btnTop, btnContainer
end

-- Draggable Setup
local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
makeDraggable(MainFrame)

-- TopBar
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 15, 40)
TopBar.BorderSizePixel = 0
TopBar.ZIndex = 4
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Position = UDim2.new(0, 14, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "HONKUKI AUDIO LOGGER"
Title.TextColor3 = Color3.fromRGB(235, 190, 255)
Title.Font = Enum.Font.SpecialElite
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 5

local CloseBtnTop = create3DButton(TopBar, UDim2.new(0, 28, 0, 24), UDim2.new(1, -36, 0.5, -14), "X", Color3.fromRGB(80, 15, 30), Color3.fromRGB(190, 35, 60))
CloseBtnTop.MouseButton1Click:Connect(function()
    playUISound(CloseSoundId)
    ScreenGui:Destroy()
end)

-- Content Frame
local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, -20, 1, -55)
ContentFrame.Position = UDim2.new(0, 10, 0, 45)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ZIndex = 3

-- Left Sidebar Player List
local PlayerListFrame = Instance.new("ScrollingFrame", ContentFrame)
PlayerListFrame.Size = UDim2.new(0, 140, 1, 0)
PlayerListFrame.Position = UDim2.new(0, 0, 0, 0)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(20, 12, 32)
PlayerListFrame.BorderSizePixel = 0
PlayerListFrame.ScrollBarThickness = 3
PlayerListFrame.ZIndex = 4
Instance.new("UICorner", PlayerListFrame).CornerRadius = UDim.new(0, 10)

local PlayerListLayout = Instance.new("UIListLayout", PlayerListFrame)
PlayerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
PlayerListLayout.Padding = UDim.new(0, 6)

-- Right Details View Frame
local RightFrame = Instance.new("Frame", ContentFrame)
RightFrame.Size = UDim2.new(1, -150, 1, 0)
RightFrame.Position = UDim2.new(0, 150, 0, 0)
RightFrame.BackgroundColor3 = Color3.fromRGB(20, 12, 32)
RightFrame.BorderSizePixel = 0
RightFrame.ZIndex = 4
Instance.new("UICorner", RightFrame).CornerRadius = UDim.new(0, 10)

-- Search ID Box (Real-Time Search Bar)
local SearchContainer = Instance.new("Frame", RightFrame)
SearchContainer.Size = UDim2.new(1, -16, 0, 30)
SearchContainer.Position = UDim2.new(0, 8, 0, 8)
SearchContainer.BackgroundColor3 = Color3.fromRGB(30, 18, 48)
SearchContainer.BorderSizePixel = 0
SearchContainer.ZIndex = 5
Instance.new("UICorner", SearchContainer).CornerRadius = UDim.new(0, 8)

local SearchStroke = Instance.new("UIStroke", SearchContainer)
SearchStroke.Color = Color3.fromRGB(130, 50, 210)
SearchStroke.Thickness = 1

local SearchBox = Instance.new("TextBox", SearchContainer)
SearchBox.Size = UDim2.new(1, -12, 1, 0)
SearchBox.Position = UDim2.new(0, 6, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.Font = Enum.Font.SpecialElite
SearchBox.Text = ""
SearchBox.PlaceholderText = "Search Audio ID / Name..."
SearchBox.PlaceholderColor3 = Color3.fromRGB(140, 110, 170)
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.TextSize = 11
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.ZIndex = 6

-- Audio List Container
local AudioListFrame = Instance.new("ScrollingFrame", RightFrame)
AudioListFrame.Size = UDim2.new(1, -16, 1, -50)
AudioListFrame.Position = UDim2.new(0, 8, 0, 44)
AudioListFrame.BackgroundTransparency = 1
AudioListFrame.BorderSizePixel = 0
AudioListFrame.ScrollBarThickness = 3
AudioListFrame.ZIndex = 5

local AudioListLayout = Instance.new("UIListLayout", AudioListFrame)
AudioListLayout.SortOrder = Enum.SortOrder.LayoutOrder
AudioListLayout.Padding = UDim.new(0, 6)

StatusLabel = Instance.new("TextLabel", RightFrame)
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0.5, -10)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.SpecialElite
StatusLabel.Text = "Select a player to view IDs"
StatusLabel.TextColor3 = Color3.fromRGB(160, 130, 200)
StatusLabel.TextSize = 12
StatusLabel.ZIndex = 6

local CurrentAudioElements = {}

local function renderAudioList(filterText)
    filterText = filterText and string.lower(filterText) or ""
    for _, elem in ipairs(CurrentAudioElements) do
        if filterText == "" then
            elem.Frame.Visible = true
        else
            local matchId = string.find(string.lower(elem.Id), filterText)
            local matchName = string.find(string.lower(elem.Name), filterText)
            if matchId or matchName then
                elem.Frame.Visible = true
            else
                elem.Frame.Visible = false
            end
        end
    end
    AudioListFrame.CanvasSize = UDim2.new(0, 0, 0, AudioListLayout.AbsoluteContentSize.Y + 10)
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    renderAudioList(SearchBox.Text)
end)

local function displayPlayerAudios(player)
    CurrentSelectedPlayer = player
    for _, child in ipairs(AudioListFrame:GetChildren()) do
        if not child:IsA("UIListLayout") then child:Destroy() end
    end
    CurrentAudioElements = {}
    SearchBox.Text = ""

    if not player then
        StatusLabel.Visible = true
        StatusLabel.Text = "Select a player to view IDs"
        return
    end

    local sounds = checkPlayerAllSounds(player)
    if #sounds == 0 then
        StatusLabel.Visible = true
        StatusLabel.Text = "No Audio Found"
        return
    end

    StatusLabel.Visible = false

    for _, soundObj in ipairs(sounds) do
        local rawId = string.match(soundObj.SoundId, "%d+") or soundObj.SoundId
        local soundName = soundObj.Name

        local itemFrame = Instance.new("Frame", AudioListFrame)
        itemFrame.Size = UDim2.new(1, -4, 0, 42)
        itemFrame.BackgroundColor3 = Color3.fromRGB(28, 16, 44)
        itemFrame.BorderSizePixel = 0
        itemFrame.ZIndex = 6
        Instance.new("UICorner", itemFrame).CornerRadius = UDim.new(0, 8)

        local itemStroke = Instance.new("UIStroke", itemFrame)
        itemStroke.Color = Color3.fromRGB(100, 40, 160)
        itemStroke.Thickness = 1

        local nameLbl = Instance.new("TextLabel", itemFrame)
        nameLbl.Size = UDim2.new(0.55, 0, 0.5, 0)
        nameLbl.Position = UDim2.new(0, 8, 0, 3)
        nameLbl.BackgroundTransparency = 1
        nameLbl.Font = Enum.Font.SpecialElite
        nameLbl.Text = soundName
        nameLbl.TextColor3 = Color3.fromRGB(240, 220, 255)
        nameLbl.TextSize = 11
        nameLbl.TextXAlignment = Enum.TextXAlignment.Left
        nameLbl.ZIndex = 7

        local idLbl = Instance.new("TextLabel", itemFrame)
        idLbl.Size = UDim2.new(0.55, 0, 0.5, 0)
        idLbl.Position = UDim2.new(0, 8, 0.5, -2)
        idLbl.BackgroundTransparency = 1
        idLbl.Font = Enum.Font.SpecialElite
        idLbl.Text = "ID: " .. tostring(rawId)
        idLbl.TextColor3 = Color3.fromRGB(170, 130, 210)
        idLbl.TextSize = 10
        idLbl.TextXAlignment = Enum.TextXAlignment.Left
        idLbl.ZIndex = 7

        local copyBtn = create3DButton(itemFrame, UDim2.new(0, 50, 0, 26), UDim2.new(1, -112, 0.5, -13), "COPY", Color3.fromRGB(40, 20, 70), Color3.fromRGB(100, 40, 160))
        copyBtn.MouseButton1Click:Connect(function()
            playUISound(GetIDSoundId)
            copyToClipboard(tostring(rawId))
        end)

        local playBtn = create3DButton(itemFrame, UDim2.new(0, 50, 0, 26), UDim2.new(1, -56, 0.5, -13), "PLAY", Color3.fromRGB(20, 60, 40), Color3.fromRGB(40, 150, 80))
        playBtn.MouseButton1Click:Connect(function()
            playUISound(OpenSoundId)
            ForcePlayMusicCombo(rawId)
        end)

        table.insert(CurrentAudioElements, {
            Frame = itemFrame,
            Name = soundName,
            Id = tostring(rawId)
        })
    end

    AudioListFrame.CanvasSize = UDim2.new(0, 0, 0, AudioListLayout.AbsoluteContentSize.Y + 10)
end

local function refreshPlayerList()
    for _, child in ipairs(PlayerListFrame:GetChildren()) do
        if not child:IsA("UIListLayout") then child:Destroy() end
    end

    for _, player in ipairs(Players:GetPlayers()) do
        local btnTop, container = create3DButton(PlayerListFrame, UDim2.new(1, -8, 0, 32), UDim2.new(0, 4, 0, 0), player.DisplayName, Color3.fromRGB(35, 18, 55), Color3.fromRGB(85, 35, 135))
        btnTop.MouseButton1Click:Connect(function()
            playUISound(OpenSoundId)
            displayPlayerAudios(player)
        end)
    end
    PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, PlayerListLayout.AbsoluteContentSize.Y + 10)
end

Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(function(player)
    if CurrentSelectedPlayer == player then
        displayPlayerAudios(nil)
    end
    refreshPlayerList()
end)

playUISound(OpenSoundId)
refreshPlayerList()
