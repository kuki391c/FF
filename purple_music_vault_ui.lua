--[[
    ═══════════════════════════════════════════════════════════════
     PURPLE MUSIC VAULT  —  standalone music ID extractor UI
     Theme: Obsidian + Neon Violet glow lines
     Features:
       • Real-time list of players currently playing music (left)
       • Steal ID / Follow-Play with anti-steal junk / Vault history (right)
       • Smooth open/close, freely draggable, floating toggle
    ═══════════════════════════════════════════════════════════════
]]

local Players            = game:GetService("Players")
local RunService         = game:GetService("RunService")
local TweenService       = game:GetService("TweenService")
local UserInputService   = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local SoundService       = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function getGuiParent()
    local ok, h = pcall(function() return (gethui and gethui()) or game:GetService("CoreGui") end)
    if ok and h then return h end
    return LocalPlayer:WaitForChild("PlayerGui")
end
local GuiParent = getGuiParent()

-- Clean previous instance
for _, n in ipairs({ "PurpleMusicVault_Root", "PurpleMusicVault_Toggle" }) do
    local old = GuiParent:FindFirstChild(n)
    if old then old:Destroy() end
end
if _G.PurpleMusicVaultConn then
    pcall(function() _G.PurpleMusicVaultConn:Disconnect() end)
    _G.PurpleMusicVaultConn = nil
end

-- ════════════════════════════════════════
-- THEME
-- ════════════════════════════════════════
local Theme = {
    Bg          = Color3.fromRGB(10, 6, 18),
    Panel       = Color3.fromRGB(18, 10, 32),
    PanelSoft   = Color3.fromRGB(28, 16, 48),
    Card        = Color3.fromRGB(22, 12, 40),
    CardHover   = Color3.fromRGB(36, 20, 62),
    Accent      = Color3.fromRGB(168, 85, 247),   -- violet-500
    AccentSoft  = Color3.fromRGB(192, 132, 252), -- violet-400
    AccentDeep  = Color3.fromRGB(109, 40, 217),  -- violet-700
    Glow        = Color3.fromRGB(216, 180, 254), -- violet-200
    Text        = Color3.fromRGB(245, 240, 255),
    TextDim     = Color3.fromRGB(170, 155, 200),
    TextMuted   = Color3.fromRGB(120, 105, 150),
    Success     = Color3.fromRGB(74, 222, 128),
    Danger      = Color3.fromRGB(248, 113, 113),
    Border      = Color3.fromRGB(88, 40, 140),
    Font        = Enum.Font.GothamMedium,
    FontBold    = Enum.Font.GothamBold,
}

local function tween(obj, dur, props, style, dir)
    local t = TweenService:Create(obj, TweenInfo.new(dur or 0.28, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

local function playClick()
    task.spawn(function()
        local s = Instance.new("Sound")
        s.SoundId = "rbxassetid://6895079853"
        s.Volume = 0.35
        s.Parent = SoundService
        s:Play()
        s.Ended:Connect(function() s:Destroy() end)
        task.delay(2, function() if s.Parent then s:Destroy() end end)
    end)
end

-- ════════════════════════════════════════
-- AUDIO DECODE + SCAN + PLAY (self-contained)
-- ════════════════════════════════════════
local function urlDecode(str)
    if type(str) ~= "string" then return "" end
    return (str:gsub("%%(%x%x)", function(hex)
        local n = tonumber(hex, 16)
        return n and string.char(n) or hex
    end))
end

local function cppStripSpacesAndDecode(str)
    if type(str) ~= "string" then return "" end
    return urlDecode(str:gsub(" ", ""))
end

local function decodeAudioId(rawSoundId)
    if type(rawSoundId) ~= "string" or rawSoundId == "" then return nil, false end
    local isObf = (#rawSoundId > 60) or (rawSoundId:find("%%") ~= nil) or (rawSoundId:find("&") ~= nil)

    if rawSoundId:find("::%[%d%]") then
        local extracted = rawSoundId:gsub("%D", "")
        if extracted and #extracted >= 4 then return extracted, true end
    end

    local bodyAfterScheme = rawSoundId:gsub("^rbxassetid://", "")
    local rawBasePart = bodyAfterScheme:match("^([^&]+)") or ""
    local decBasePart = cppStripSpacesAndDecode(rawBasePart)
    local baseCppValidId = decBasePart:match("^0*(%d+)$")
    local currentCppId = nil

    for param in bodyAfterScheme:gmatch("&([^&]+)") do
        local rawKey, rawVal = param:match("^([^=]+)=(.+)$")
        if rawKey and rawVal then
            local decKey = cppStripSpacesAndDecode(rawKey)
            if not decKey:find("%z") and (decKey == "Id" or decKey == "iD" or decKey == "ID") then
                if baseCppValidId and #baseCppValidId >= 4 then currentCppId = baseCppValidId end
            elseif decKey == "id" then
                local decVal = cppStripSpacesAndDecode(rawVal)
                local beforeNull = decVal:match("^([^%z]+)") or decVal
                local pureDigits = beforeNull:match("^0*(%d+)$")
                if pureDigits and #pureDigits >= 4 then
                    currentCppId = pureDigits
                elseif baseCppValidId and #baseCppValidId >= 4 then
                    currentCppId = baseCppValidId
                end
            end
        end
    end
    if currentCppId and #currentCppId >= 4 then return currentCppId, true end

    local decodedFull = urlDecode(rawSoundId)
    local stripped = decodedFull:gsub("[\226\128\139\226\128\140\226\128\141\226\129\160]", "")
    local lastPlainId = nil
    for idCandidate in stripped:gmatch("&id=0*(%d+)") do lastPlainId = idCandidate end
    if lastPlainId and #lastPlainId >= 4 then return lastPlainId, isObf end

    local standardId = rawSoundId:match("rbxassetid://(%d+)")
        or rawSoundId:match("[?&]id=(%d+)")
        or rawSoundId:match("library/(%d+)")
        or rawSoundId:match("catalog/(%d+)")
        or stripped:match("(%d+)")
    if standardId and #standardId >= 4 then
        return standardId:match("^0*(%d+)") or standardId, isObf
    end
    return nil, false
end

-- Anti-steal junk payload (URI differential style) so follow-play works through common blockers
local function buildJunkPayload(cleanId)
    cleanId = tostring(cleanId):match("%d+") or tostring(cleanId)
    if cleanId == "" then return cleanId end
    local junk = {
        "rbxassetid://" .. cleanId,
        "&id=" .. cleanId,
        "&%00&x=" .. tostring(math.random(1000, 9999)),
        "&t=" .. tostring(os.time() % 100000),
        "&n=" .. tostring(math.random(10, 99)),
    }
    return table.concat(junk, "")
end

local function getRE()
    local re = ReplicatedStorage:FindFirstChild("RE")
    return re
end

local function getToolEvent()
    local re = getRE()
    return re and re:FindFirstChild("PlayerToolEvent")
end

local function getScooterEvent()
    local re = getRE()
    if not re then return nil end
    return re:FindFirstChild("1NoMoto1rVehicle1s")
        or re:FindFirstChild("1NoMo1torVeh1icle1s")
        or re:FindFirstChild("PlayerScooterEvent")
end

local function getBoomboxTool()
    local char = LocalPlayer.Character
    local bp = LocalPlayer:FindFirstChild("Backpack")
    for _, container in ipairs({ char, bp }) do
        if container then
            for _, item in ipairs(container:GetChildren()) do
                if item:IsA("Tool") and item.Name:lower():find("boombox", 1, true) then
                    return item
                end
            end
        end
    end
    return nil
end

local function ensureBoombox()
    local tool = getBoomboxTool()
    if tool then return tool end
    local re = getRE()
    local picker = re and (re:FindFirstChild("ToolPicker") or re:FindFirstChild("1Tool1s"))
    if picker and picker:IsA("RemoteFunction") then
        pcall(function() picker:InvokeServer("PickingTools", "Boombox") end)
    elseif picker and picker:IsA("RemoteEvent") then
        pcall(function() picker:FireServer("PickingTools", "Boombox") end)
    end
    local t0 = os.clock()
    while not tool and (os.clock() - t0) < 1.2 do
        tool = getBoomboxTool()
        task.wait(0.05)
    end
    return tool
end

local function playMusicWithJunk(audioId)
    local clean = tostring(audioId):match("%d+") or ""
    if clean == "" then return false end
    local payload = buildJunkPayload(clean)

    -- Prefer main hub play if present
    if _G.LloydPlayMusicFn then
        pcall(function() _G.LloydPlayMusicFn(clean) end)
        return true
    end

    local tool = ensureBoombox()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if tool and char and hum then
        pcall(function()
            if tool.Parent ~= char then hum:EquipTool(tool) end
        end)
        task.wait(0.08)
    end

    local te = getToolEvent()
    if te then
        pcall(function()
            te:FireServer("ToolMusicText", payload)
            te:FireServer("ToolMusic", payload, 1)
            te:FireServer("ToolMusicText", clean)
            te:FireServer("ToolMusic", clean, 1)
        end)
    end

    local se = getScooterEvent()
    if se then
        pcall(function()
            se:FireServer("PickingScooterMusicText", payload, nil, true)
            se:FireServer("PickingScooterMusic", clean, 1)
        end)
    end

    -- Client-side force on local boombox sound
    task.spawn(function()
        task.wait(0.15)
        local t = getBoomboxTool()
        if t then
            for _, d in ipairs(t:GetDescendants()) do
                if d:IsA("Sound") and d.Name == "PlayersChoice" then
                    d.SoundId = "rbxassetid://" .. clean
                    d.Looped = true
                    if d.Volume < 0.1 then d.Volume = 1 end
                    d:Play()
                end
            end
        end
    end)
    return true
end

local function scanActiveMusicPlayers()
    local results = {}
    local myChar = LocalPlayer.Character
    local myPos = (myChar and myChar:FindFirstChild("HumanoidRootPart")) and myChar.HumanoidRootPart.Position or Vector3.zero
    local seen = {}

    local function checkContainer(container, sourceName)
        if not container then return nil end
        for _, item in ipairs(container:GetChildren()) do
            if item:IsA("Tool") and item.Name:lower():find("boombox", 1, true) then
                for _, desc in ipairs(item:GetDescendants()) do
                    if desc:IsA("Sound") and desc.Name == "PlayersChoice" and desc.IsPlaying
                        and desc.SoundId ~= "" and desc.SoundId ~= "0" then
                        return desc, sourceName
                    end
                end
            end
        end
        return nil
    end

    local function checkNoMotor(model)
        if not model then return nil end
        for _, desc in ipairs(model:GetDescendants()) do
            if desc:IsA("Sound") and desc.Name == "PlayersChoice" and desc.IsPlaying
                and desc.SoundId ~= "" and desc.SoundId ~= "0" then
                return desc, "Skateboard"
            end
        end
        return nil
    end

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and not seen[p] then
            local foundSound, source = nil, ""
            local pChar = p.Character
            if pChar then
                foundSound, source = checkContainer(pChar, "Boombox")
                if not foundSound then
                    foundSound, source = checkNoMotor(pChar:FindFirstChild("NoMotorVehicleModel"))
                end
            end
            if not foundSound and p:FindFirstChild("Backpack") then
                foundSound, source = checkContainer(p.Backpack, "Boombox")
            end
            -- workspace vehicle near player
            if not foundSound then
                local wsPlr = workspace:FindFirstChild(p.Name)
                if wsPlr then
                    foundSound, source = checkNoMotor(wsPlr:FindFirstChild("NoMotorVehicleModel"))
                end
            end

            if foundSound then
                seen[p] = true
                local rawSid = foundSound.SoundId
                local cleanId, wasProt = decodeAudioId(rawSid)
                local hrp = pChar and pChar:FindFirstChild("HumanoidRootPart")
                local dist = hrp and (hrp.Position - myPos).Magnitude or 0
                table.insert(results, {
                    player = p,
                    name = p.Name,
                    displayName = p.DisplayName,
                    distance = dist,
                    realId = (cleanId and cleanId ~= "" and cleanId ~= "0") and cleanId or nil,
                    rawSoundId = rawSid,
                    wasProtected = wasProt or false,
                    source = source or "Unknown",
                })
            end
        end
    end

    table.sort(results, function(a, b) return a.distance < b.distance end)
    return results
end

local songNameCache = {}
local function fetchSongName(id, cb)
    if not id or id == "" then if cb then cb("Unknown") end return end
    if songNameCache[id] then if cb then cb(songNameCache[id]) end return end
    task.spawn(function()
        local name = "Audio " .. tostring(id)
        local ok, info = pcall(function()
            return MarketplaceService:GetProductInfo(tonumber(id), Enum.InfoType.Asset)
        end)
        if ok and info and info.Name and info.Name ~= "" then
            name = info.Name
            songNameCache[id] = name
        end
        if cb then cb(name) end
    end)
end

-- ════════════════════════════════════════
-- STATE
-- ════════════════════════════════════════
local State = {
    IsOpen = false,
    Selected = nil,       -- active player entry
    Vault = {},           -- { id, title, from, time }
    ActiveList = {},
}

-- ════════════════════════════════════════
-- UI BUILD
-- ════════════════════════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PurpleMusicVault_Root"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 99950
pcall(function() ScreenGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets end)
ScreenGui.Parent = GuiParent

-- Floating toggle pill
local ToggleGui = Instance.new("ScreenGui")
ToggleGui.Name = "PurpleMusicVault_Toggle"
ToggleGui.ResetOnSpawn = false
ToggleGui.DisplayOrder = 99951
ToggleGui.IgnoreGuiInset = true
ToggleGui.Parent = GuiParent

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "VaultToggle"
ToggleBtn.AnchorPoint = Vector2.new(0, 0.5)
ToggleBtn.Position = UDim2.new(0, 14, 0.5, 0)
ToggleBtn.Size = UDim2.fromOffset(46, 46)
ToggleBtn.BackgroundColor3 = Theme.Panel
ToggleBtn.BackgroundTransparency = 0.08
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Text = ""
ToggleBtn.AutoButtonColor = false
ToggleBtn.Parent = ToggleGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local togStroke = Instance.new("UIStroke")
togStroke.Color = Theme.Accent
togStroke.Thickness = 1.5
togStroke.Transparency = 0.25
togStroke.Parent = ToggleBtn
local togIcon = Instance.new("TextLabel")
togIcon.Size = UDim2.fromScale(1, 1)
togIcon.BackgroundTransparency = 1
togIcon.Text = "♪"
togIcon.TextColor3 = Theme.AccentSoft
togIcon.Font = Theme.FontBold
togIcon.TextSize = 22
togIcon.Parent = ToggleBtn

-- Main window
local WinW, WinH = 520, 420
local Main = Instance.new("Frame")
Main.Name = "VaultWindow"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.5, 10)
Main.Size = UDim2.fromOffset(WinW, WinH)
Main.BackgroundColor3 = Theme.Bg
Main.BackgroundTransparency = 1
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Visible = false
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 18)

local MainScale = Instance.new("UIScale")
MainScale.Scale = 0.92
MainScale.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Theme.Accent
MainStroke.Thickness = 1.6
MainStroke.Transparency = 1
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = Main

-- Glow rim (outer soft frame)
local GlowRim = Instance.new("Frame")
GlowRim.Name = "GlowRim"
GlowRim.AnchorPoint = Vector2.new(0.5, 0.5)
GlowRim.Position = UDim2.fromScale(0.5, 0.5)
GlowRim.Size = UDim2.new(1, 18, 1, 18)
GlowRim.BackgroundColor3 = Theme.AccentDeep
GlowRim.BackgroundTransparency = 1
GlowRim.BorderSizePixel = 0
GlowRim.ZIndex = 0
GlowRim.Parent = Main
Instance.new("UICorner", GlowRim).CornerRadius = UDim.new(0, 22)

-- Animated neon line background
local BgCanvas = Instance.new("Frame")
BgCanvas.Name = "NeonBg"
BgCanvas.Size = UDim2.fromScale(1, 1)
BgCanvas.BackgroundTransparency = 1
BgCanvas.ClipsDescendants = true
BgCanvas.ZIndex = 1
BgCanvas.Parent = Main

local function makeNeonLine(y, thickness, speed, phase)
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1.4, 0, 0, thickness)
    line.Position = UDim2.new(-0.2, 0, 0, y)
    line.BackgroundColor3 = Theme.Accent
    line.BackgroundTransparency = 0.82
    line.BorderSizePixel = 0
    line.ZIndex = 1
    line.Parent = BgCanvas
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.AccentDeep),
        ColorSequenceKeypoint.new(0.5, Theme.Glow),
        ColorSequenceKeypoint.new(1, Theme.AccentDeep),
    })
    g.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.35, 0.35),
        NumberSequenceKeypoint.new(0.65, 0.35),
        NumberSequenceKeypoint.new(1, 1),
    })
    g.Rotation = 0
    g.Parent = line
    task.spawn(function()
        local t0 = os.clock() + (phase or 0)
        while line.Parent do
            local t = (os.clock() - t0) * speed
            g.Offset = Vector2.new((t % 2) - 1, 0)
            task.wait(0.03)
        end
    end)
    return line
end

for i = 1, 7 do
    makeNeonLine(28 + i * 52, (i % 2 == 0) and 2 or 1, 0.18 + i * 0.03, i * 0.4)
end

-- Vertical soft gradient overlay
local Vignette = Instance.new("Frame")
Vignette.Size = UDim2.fromScale(1, 1)
Vignette.BackgroundColor3 = Theme.Bg
Vignette.BackgroundTransparency = 0.35
Vignette.BorderSizePixel = 0
Vignette.ZIndex = 2
Vignette.Parent = Main
Instance.new("UICorner", Vignette).CornerRadius = UDim.new(0, 18)
local vg = Instance.new("UIGradient")
vg.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.15),
    NumberSequenceKeypoint.new(0.5, 0.55),
    NumberSequenceKeypoint.new(1, 0.1),
})
vg.Rotation = 90
vg.Parent = Vignette

-- Header (drag handle)
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 52)
Header.BackgroundColor3 = Theme.Panel
Header.BackgroundTransparency = 0.25
Header.BorderSizePixel = 0
Header.ZIndex = 10
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 18)
-- square bottom of header
local headerMask = Instance.new("Frame")
headerMask.Size = UDim2.new(1, 0, 0, 18)
headerMask.Position = UDim2.new(0, 0, 1, -18)
headerMask.BackgroundColor3 = Theme.Panel
headerMask.BackgroundTransparency = 0.25
headerMask.BorderSizePixel = 0
headerMask.ZIndex = 10
headerMask.Parent = Header

local TitleIcon = Instance.new("TextLabel")
TitleIcon.Position = UDim2.new(0, 16, 0.5, 0)
TitleIcon.AnchorPoint = Vector2.new(0, 0.5)
TitleIcon.Size = UDim2.fromOffset(28, 28)
TitleIcon.BackgroundTransparency = 1
TitleIcon.Text = "◈"
TitleIcon.TextColor3 = Theme.AccentSoft
TitleIcon.Font = Theme.FontBold
TitleIcon.TextSize = 20
TitleIcon.ZIndex = 11
TitleIcon.Parent = Header

local TitleLbl = Instance.new("TextLabel")
TitleLbl.Position = UDim2.new(0, 48, 0, 8)
TitleLbl.Size = UDim2.new(1, -120, 0, 22)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = "Purple Music Vault"
TitleLbl.TextColor3 = Theme.Text
TitleLbl.Font = Theme.FontBold
TitleLbl.TextSize = 15
TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
TitleLbl.ZIndex = 11
TitleLbl.Parent = Header

local SubLbl = Instance.new("TextLabel")
SubLbl.Position = UDim2.new(0, 48, 0, 28)
SubLbl.Size = UDim2.new(1, -120, 0, 16)
SubLbl.BackgroundTransparency = 1
SubLbl.Text = "เจาะ ID • เล่นตาม • คลังเพลง"
SubLbl.TextColor3 = Theme.TextDim
SubLbl.Font = Theme.Font
SubLbl.TextSize = 11
SubLbl.TextXAlignment = Enum.TextXAlignment.Left
SubLbl.ZIndex = 11
SubLbl.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.AnchorPoint = Vector2.new(1, 0.5)
CloseBtn.Position = UDim2.new(1, -14, 0.5, 0)
CloseBtn.Size = UDim2.fromOffset(30, 30)
CloseBtn.BackgroundColor3 = Theme.Card
CloseBtn.BackgroundTransparency = 0.2
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Theme.TextDim
CloseBtn.Font = Theme.FontBold
CloseBtn.TextSize = 14
CloseBtn.AutoButtonColor = false
CloseBtn.ZIndex = 12
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

-- Body layout
local Body = Instance.new("Frame")
Body.Name = "Body"
Body.Position = UDim2.new(0, 12, 0, 60)
Body.Size = UDim2.new(1, -24, 1, -72)
Body.BackgroundTransparency = 1
Body.ZIndex = 5
Body.Parent = Main

-- LEFT: player list
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0.48, -6, 1, 0)
LeftPanel.BackgroundColor3 = Theme.Panel
LeftPanel.BackgroundTransparency = 0.2
LeftPanel.BorderSizePixel = 0
LeftPanel.ZIndex = 6
LeftPanel.Parent = Body
Instance.new("UICorner", LeftPanel).CornerRadius = UDim.new(0, 14)
local lpStroke = Instance.new("UIStroke")
lpStroke.Color = Theme.Border
lpStroke.Thickness = 1
lpStroke.Transparency = 0.45
lpStroke.Parent = LeftPanel

local LeftTitle = Instance.new("TextLabel")
LeftTitle.Position = UDim2.new(0, 12, 0, 8)
LeftTitle.Size = UDim2.new(1, -24, 0, 18)
LeftTitle.BackgroundTransparency = 1
LeftTitle.Text = "กำลังเปิดเพลง (Realtime)"
LeftTitle.TextColor3 = Theme.AccentSoft
LeftTitle.Font = Theme.FontBold
LeftTitle.TextSize = 12
LeftTitle.TextXAlignment = Enum.TextXAlignment.Left
LeftTitle.ZIndex = 7
LeftTitle.Parent = LeftPanel

local LeftCount = Instance.new("TextLabel")
LeftCount.Position = UDim2.new(0, 12, 0, 26)
LeftCount.Size = UDim2.new(1, -24, 0, 14)
LeftCount.BackgroundTransparency = 1
LeftCount.Text = "0 คน"
LeftCount.TextColor3 = Theme.TextMuted
LeftCount.Font = Theme.Font
LeftCount.TextSize = 10
LeftCount.TextXAlignment = Enum.TextXAlignment.Left
LeftCount.ZIndex = 7
LeftCount.Parent = LeftPanel

local PlayerScroll = Instance.new("ScrollingFrame")
PlayerScroll.Position = UDim2.new(0, 8, 0, 46)
PlayerScroll.Size = UDim2.new(1, -16, 1, -54)
PlayerScroll.BackgroundTransparency = 1
PlayerScroll.BorderSizePixel = 0
PlayerScroll.ScrollBarThickness = 3
PlayerScroll.ScrollBarImageColor3 = Theme.Accent
PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
PlayerScroll.ZIndex = 7
PlayerScroll.Parent = LeftPanel

local PlayerList = Instance.new("UIListLayout")
PlayerList.SortOrder = Enum.SortOrder.LayoutOrder
PlayerList.Padding = UDim.new(0, 6)
PlayerList.Parent = PlayerScroll

local EmptyHint = Instance.new("TextLabel")
EmptyHint.Size = UDim2.new(1, -16, 0, 60)
EmptyHint.Position = UDim2.new(0, 8, 0, 80)
EmptyHint.BackgroundTransparency = 1
EmptyHint.Text = "ยังไม่มีใครเปิดเพลง\nในเซิร์ฟเวอร์ตอนนี้"
EmptyHint.TextColor3 = Theme.TextMuted
EmptyHint.Font = Theme.Font
EmptyHint.TextSize = 12
EmptyHint.TextWrapped = true
EmptyHint.ZIndex = 7
EmptyHint.Parent = LeftPanel

-- RIGHT: actions + vault
local RightPanel = Instance.new("Frame")
RightPanel.Position = UDim2.new(0.48, 6, 0, 0)
RightPanel.Size = UDim2.new(0.52, -6, 1, 0)
RightPanel.BackgroundTransparency = 1
RightPanel.ZIndex = 6
RightPanel.Parent = Body

local SelectedCard = Instance.new("Frame")
SelectedCard.Size = UDim2.new(1, 0, 0, 72)
SelectedCard.BackgroundColor3 = Theme.Card
SelectedCard.BackgroundTransparency = 0.15
SelectedCard.BorderSizePixel = 0
SelectedCard.ZIndex = 7
SelectedCard.Parent = RightPanel
Instance.new("UICorner", SelectedCard).CornerRadius = UDim.new(0, 12)
local scStroke = Instance.new("UIStroke")
scStroke.Color = Theme.Border
scStroke.Thickness = 1
scStroke.Transparency = 0.4
scStroke.Parent = SelectedCard

local SelName = Instance.new("TextLabel")
SelName.Position = UDim2.new(0, 12, 0, 10)
SelName.Size = UDim2.new(1, -20, 0, 18)
SelName.BackgroundTransparency = 1
SelName.Text = "ยังไม่ได้เลือกผู้เล่น"
SelName.TextColor3 = Theme.Text
SelName.Font = Theme.FontBold
SelName.TextSize = 13
SelName.TextXAlignment = Enum.TextXAlignment.Left
SelName.TextTruncate = Enum.TextTruncate.AtEnd
SelName.ZIndex = 8
SelName.Parent = SelectedCard

local SelMeta = Instance.new("TextLabel")
SelMeta.Position = UDim2.new(0, 12, 0, 30)
SelMeta.Size = UDim2.new(1, -20, 0, 14)
SelMeta.BackgroundTransparency = 1
SelMeta.Text = "เลือกจากรายชื่อทางซ้าย"
SelMeta.TextColor3 = Theme.TextDim
SelMeta.Font = Theme.Font
SelMeta.TextSize = 11
SelMeta.TextXAlignment = Enum.TextXAlignment.Left
SelMeta.TextTruncate = Enum.TextTruncate.AtEnd
SelMeta.ZIndex = 8
SelMeta.Parent = SelectedCard

local SelId = Instance.new("TextLabel")
SelId.Position = UDim2.new(0, 12, 0, 48)
SelId.Size = UDim2.new(1, -20, 0, 14)
SelId.BackgroundTransparency = 1
SelId.Text = "ID: —"
SelId.TextColor3 = Theme.AccentSoft
SelId.Font = Enum.Font.RobotoMono
SelId.TextSize = 11
SelId.TextXAlignment = Enum.TextXAlignment.Left
SelId.TextTruncate = Enum.TextTruncate.AtEnd
SelId.ZIndex = 8
SelId.Parent = SelectedCard

local function makeActionBtn(parent, order, label, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.LayoutOrder = order
    btn.BackgroundColor3 = color or Theme.AccentDeep
    btn.BackgroundTransparency = 0.15
    btn.BorderSizePixel = 0
    btn.Text = label
    btn.TextColor3 = Theme.Text
    btn.Font = Theme.FontBold
    btn.TextSize = 13
    btn.AutoButtonColor = false
    btn.ZIndex = 8
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    local st = Instance.new("UIStroke")
    st.Color = Theme.AccentSoft
    st.Thickness = 1
    st.Transparency = 0.55
    st.Parent = btn
    btn.MouseEnter:Connect(function()
        tween(btn, 0.15, { BackgroundTransparency = 0.02 })
    end)
    btn.MouseLeave:Connect(function()
        tween(btn, 0.15, { BackgroundTransparency = 0.15 })
    end)
    return btn
end

local ActionBox = Instance.new("Frame")
ActionBox.Position = UDim2.new(0, 0, 0, 80)
ActionBox.Size = UDim2.new(1, 0, 0, 120)
ActionBox.BackgroundTransparency = 1
ActionBox.ZIndex = 7
ActionBox.Parent = RightPanel

local ActionLayout = Instance.new("UIListLayout")
ActionLayout.Padding = UDim.new(0, 8)
ActionLayout.Parent = ActionBox

local BtnSteal = makeActionBtn(ActionBox, 1, "◈  ดึง ID เพลง", Theme.AccentDeep)
local BtnFollow = makeActionBtn(ActionBox, 2, "▶  เล่นเพลงตาม Player", Color3.fromRGB(76, 29, 149))
local BtnCopy = makeActionBtn(ActionBox, 3, "⎘  คัดลอก ID ที่เลือก", Color3.fromRGB(55, 25, 95))

-- Vault section
local VaultLabel = Instance.new("TextLabel")
VaultLabel.Position = UDim2.new(0, 0, 0, 210)
VaultLabel.Size = UDim2.new(1, 0, 0, 16)
VaultLabel.BackgroundTransparency = 1
VaultLabel.Text = "คลัง ID ที่เจาะมา"
VaultLabel.TextColor3 = Theme.AccentSoft
VaultLabel.Font = Theme.FontBold
VaultLabel.TextSize = 12
VaultLabel.TextXAlignment = Enum.TextXAlignment.Left
VaultLabel.ZIndex = 7
VaultLabel.Parent = RightPanel

local VaultScroll = Instance.new("ScrollingFrame")
VaultScroll.Position = UDim2.new(0, 0, 0, 230)
VaultScroll.Size = UDim2.new(1, 0, 1, -230)
VaultScroll.BackgroundColor3 = Theme.Panel
VaultScroll.BackgroundTransparency = 0.25
VaultScroll.BorderSizePixel = 0
VaultScroll.ScrollBarThickness = 3
VaultScroll.ScrollBarImageColor3 = Theme.Accent
VaultScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
VaultScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
VaultScroll.ZIndex = 7
VaultScroll.Parent = RightPanel
Instance.new("UICorner", VaultScroll).CornerRadius = UDim.new(0, 12)

local VaultPad = Instance.new("UIPadding")
VaultPad.PaddingTop = UDim.new(0, 6)
VaultPad.PaddingLeft = UDim.new(0, 6)
VaultPad.PaddingRight = UDim.new(0, 6)
VaultPad.PaddingBottom = UDim.new(0, 6)
VaultPad.Parent = VaultScroll

local VaultList = Instance.new("UIListLayout")
VaultList.Padding = UDim.new(0, 5)
VaultList.Parent = VaultScroll

local StatusToast = Instance.new("TextLabel")
StatusToast.AnchorPoint = Vector2.new(0.5, 1)
StatusToast.Position = UDim2.new(0.5, 0, 1, -8)
StatusToast.Size = UDim2.new(0.9, 0, 0, 18)
StatusToast.BackgroundTransparency = 1
StatusToast.Text = ""
StatusToast.TextColor3 = Theme.Success
StatusToast.Font = Theme.Font
StatusToast.TextSize = 11
StatusToast.ZIndex = 20
StatusToast.Parent = Main

local function toast(msg, isErr)
    StatusToast.TextColor3 = isErr and Theme.Danger or Theme.Success
    StatusToast.Text = msg
    StatusToast.TextTransparency = 0
    task.delay(2.4, function()
        if StatusToast.Text == msg then
            tween(StatusToast, 0.3, { TextTransparency = 1 })
        end
    end)
end

-- ════════════════════════════════════════
-- DRAG
-- ════════════════════════════════════════
do
    local dragging, startPos, startInput
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startInput = input.Position
            startPos = Main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local d = input.Position - startInput
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- ════════════════════════════════════════
-- OPEN / CLOSE
-- ════════════════════════════════════════
local function openWindow()
    if State.IsOpen then return end
    State.IsOpen = true
    Main.Visible = true
    Main.BackgroundTransparency = 1
    MainScale.Scale = 0.88
    MainStroke.Transparency = 1
    tween(Main, 0.32, { BackgroundTransparency = 0.08 }, Enum.EasingStyle.Quart)
    tween(MainScale, 0.38, { Scale = 1 }, Enum.EasingStyle.Back)
    tween(MainStroke, 0.35, { Transparency = 0.2 })
    tween(GlowRim, 0.4, { BackgroundTransparency = 0.88 })
    playClick()
end

local function closeWindow()
    if not State.IsOpen then return end
    State.IsOpen = false
    tween(MainScale, 0.22, { Scale = 0.9 }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    tween(MainStroke, 0.2, { Transparency = 1 })
    local tw = tween(Main, 0.22, { BackgroundTransparency = 1 }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    tw.Completed:Connect(function()
        if not State.IsOpen then Main.Visible = false end
    end)
    playClick()
end

ToggleBtn.MouseButton1Click:Connect(function()
    if State.IsOpen then closeWindow() else openWindow() end
end)
CloseBtn.MouseButton1Click:Connect(closeWindow)

-- ════════════════════════════════════════
-- PLAYER LIST UI
-- ════════════════════════════════════════
local playerRowPool = {}

local function clearPlayerRows()
    for _, row in ipairs(playerRowPool) do
        row:Destroy()
    end
    playerRowPool = {}
end

local function selectPlayer(entry)
    State.Selected = entry
    if not entry then
        SelName.Text = "ยังไม่ได้เลือกผู้เล่น"
        SelMeta.Text = "เลือกจากรายชื่อทางซ้าย"
        SelId.Text = "ID: —"
        return
    end
    SelName.Text = string.format("%s  (@%s)", entry.displayName, entry.name)
    SelMeta.Text = string.format("%s  •  %d studs  •  %s",
        entry.source or "?", math.floor(entry.distance + 0.5),
        entry.wasProtected and "มีกันดัก" or "ปกติ")
    SelId.Text = "ID: " .. (entry.realId or "ถอดรหัสไม่ได้")
end

local function rebuildPlayerList(list)
    clearPlayerRows()
    State.ActiveList = list or {}
    LeftCount.Text = tostring(#State.ActiveList) .. " คน"
    EmptyHint.Visible = (#State.ActiveList == 0)

    -- keep selection if still present
    if State.Selected then
        local still = false
        for _, e in ipairs(State.ActiveList) do
            if e.name == State.Selected.name then
                State.Selected = e
                still = true
                break
            end
        end
        if not still then selectPlayer(nil) end
    end
    if State.Selected then selectPlayer(State.Selected) end

    for i, entry in ipairs(State.ActiveList) do
        local row = Instance.new("TextButton")
        row.Size = UDim2.new(1, 0, 0, 44)
        row.BackgroundColor3 = (State.Selected and State.Selected.name == entry.name) and Theme.CardHover or Theme.Card
        row.BackgroundTransparency = 0.2
        row.BorderSizePixel = 0
        row.Text = ""
        row.AutoButtonColor = false
        row.LayoutOrder = i
        row.ZIndex = 8
        row.Parent = PlayerScroll
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)

        local nameL = Instance.new("TextLabel")
        nameL.Position = UDim2.new(0, 10, 0, 5)
        nameL.Size = UDim2.new(1, -20, 0, 16)
        nameL.BackgroundTransparency = 1
        nameL.Text = entry.displayName
        nameL.TextColor3 = Theme.Text
        nameL.Font = Theme.FontBold
        nameL.TextSize = 12
        nameL.TextXAlignment = Enum.TextXAlignment.Left
        nameL.TextTruncate = Enum.TextTruncate.AtEnd
        nameL.ZIndex = 9
        nameL.Parent = row

        local metaL = Instance.new("TextLabel")
        metaL.Position = UDim2.new(0, 10, 0, 23)
        metaL.Size = UDim2.new(1, -20, 0, 14)
        metaL.BackgroundTransparency = 1
        metaL.Text = string.format("@%s · %dst · %s", entry.name, math.floor(entry.distance + 0.5), entry.source or "")
        metaL.TextColor3 = Theme.TextMuted
        metaL.Font = Theme.Font
        metaL.TextSize = 10
        metaL.TextXAlignment = Enum.TextXAlignment.Left
        metaL.TextTruncate = Enum.TextTruncate.AtEnd
        metaL.ZIndex = 9
        metaL.Parent = row

        local dot = Instance.new("Frame")
        dot.AnchorPoint = Vector2.new(1, 0.5)
        dot.Position = UDim2.new(1, -10, 0.5, 0)
        dot.Size = UDim2.fromOffset(7, 7)
        dot.BackgroundColor3 = entry.realId and Theme.Success or Theme.Danger
        dot.BorderSizePixel = 0
        dot.ZIndex = 9
        dot.Parent = row
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

        row.MouseButton1Click:Connect(function()
            playClick()
            selectPlayer(entry)
            rebuildPlayerList(State.ActiveList)
        end)

        table.insert(playerRowPool, row)
    end
end

-- ════════════════════════════════════════
-- VAULT UI
-- ════════════════════════════════════════
local vaultRows = {}

local function rebuildVault()
    for _, r in ipairs(vaultRows) do r:Destroy() end
    vaultRows = {}
    for i, item in ipairs(State.Vault) do
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 40)
        row.BackgroundColor3 = Theme.Card
        row.BackgroundTransparency = 0.25
        row.BorderSizePixel = 0
        row.LayoutOrder = i
        row.ZIndex = 8
        row.Parent = VaultScroll
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)

        local idL = Instance.new("TextLabel")
        idL.Position = UDim2.new(0, 8, 0, 4)
        idL.Size = UDim2.new(1, -50, 0, 14)
        idL.BackgroundTransparency = 1
        idL.Text = item.id
        idL.TextColor3 = Theme.AccentSoft
        idL.Font = Enum.Font.RobotoMono
        idL.TextSize = 11
        idL.TextXAlignment = Enum.TextXAlignment.Left
        idL.TextTruncate = Enum.TextTruncate.AtEnd
        idL.ZIndex = 9
        idL.Parent = row

        local titleL = Instance.new("TextLabel")
        titleL.Position = UDim2.new(0, 8, 0, 20)
        titleL.Size = UDim2.new(1, -50, 0, 14)
        titleL.BackgroundTransparency = 1
        titleL.Text = (item.title or "…") .. "  ·  " .. (item.from or "")
        titleL.TextColor3 = Theme.TextMuted
        titleL.Font = Theme.Font
        titleL.TextSize = 10
        titleL.TextXAlignment = Enum.TextXAlignment.Left
        titleL.TextTruncate = Enum.TextTruncate.AtEnd
        titleL.ZIndex = 9
        titleL.Parent = row

        local playMini = Instance.new("TextButton")
        playMini.AnchorPoint = Vector2.new(1, 0.5)
        playMini.Position = UDim2.new(1, -6, 0.5, 0)
        playMini.Size = UDim2.fromOffset(28, 28)
        playMini.BackgroundColor3 = Theme.AccentDeep
        playMini.BackgroundTransparency = 0.2
        playMini.BorderSizePixel = 0
        playMini.Text = "▶"
        playMini.TextColor3 = Theme.Text
        playMini.Font = Theme.FontBold
        playMini.TextSize = 11
        playMini.AutoButtonColor = false
        playMini.ZIndex = 10
        playMini.Parent = row
        Instance.new("UICorner", playMini).CornerRadius = UDim.new(0, 7)
        playMini.MouseButton1Click:Connect(function()
            playClick()
            if playMusicWithJunk(item.id) then
                toast("เล่น: " .. tostring(item.id))
            else
                toast("เล่นไม่สำเร็จ", true)
            end
        end)

        table.insert(vaultRows, row)
    end
end

local function addToVault(id, fromName)
    if not id or id == "" then return end
    for _, v in ipairs(State.Vault) do
        if v.id == id then return end
    end
    local entry = { id = id, title = "…", from = fromName or "?", time = os.time() }
    table.insert(State.Vault, 1, entry)
    while #State.Vault > 40 do table.remove(State.Vault) end
    rebuildVault()
    fetchSongName(id, function(name)
        entry.title = name
        rebuildVault()
    end)
end

-- ════════════════════════════════════════
-- BUTTONS
-- ════════════════════════════════════════
BtnSteal.MouseButton1Click:Connect(function()
    playClick()
    local sel = State.Selected
    if not sel then
        toast("เลือกผู้เล่นก่อน", true)
        return
    end
    -- re-scan this player for freshest ID
    local list = scanActiveMusicPlayers()
    local found
    for _, e in ipairs(list) do
        if e.name == sel.name then found = e break end
    end
    if not found or not found.realId then
        toast("ถอดรหัส ID ไม่ได้", true)
        return
    end
    selectPlayer(found)
    addToVault(found.realId, found.displayName)
    pcall(function()
        if setclipboard then setclipboard(found.realId) end
    end)
    toast("ดึง ID: " .. found.realId)
end)

BtnFollow.MouseButton1Click:Connect(function()
    playClick()
    local sel = State.Selected
    if not sel then
        toast("เลือกผู้เล่นก่อน", true)
        return
    end
    local list = scanActiveMusicPlayers()
    local found
    for _, e in ipairs(list) do
        if e.name == sel.name then found = e break end
    end
    if not found or not found.realId then
        toast("ไม่มี ID ให้เล่นตาม", true)
        return
    end
    selectPlayer(found)
    addToVault(found.realId, found.displayName)
    if playMusicWithJunk(found.realId) then
        toast("เล่นตาม @" .. found.name .. " (junk payload)")
    else
        toast("เล่นไม่สำเร็จ — ลองถือ Boombox", true)
    end
end)

BtnCopy.MouseButton1Click:Connect(function()
    playClick()
    local sel = State.Selected
    if not sel or not sel.realId then
        toast("ยังไม่มี ID", true)
        return
    end
    pcall(function()
        if setclipboard then setclipboard(sel.realId) end
    end)
    toast("คัดลอก: " .. sel.realId)
end)

-- ════════════════════════════════════════
-- REALTIME SCAN LOOP
-- ════════════════════════════════════════
local accum = 0
_G.PurpleMusicVaultConn = RunService.Heartbeat:Connect(function(dt)
    if not State.IsOpen then return end
    accum = accum + dt
    if accum < 0.75 then return end
    accum = 0
    local ok, list = pcall(scanActiveMusicPlayers)
    if ok and list then
        rebuildPlayerList(list)
    end
end)

-- Initial open
task.defer(function()
    openWindow()
    local ok, list = pcall(scanActiveMusicPlayers)
    if ok and list then rebuildPlayerList(list) end
end)

print("[Purple Music Vault] Loaded — toggle pill on left edge")
