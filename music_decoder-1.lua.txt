-- ====================================================================
-- ROBLOX MUSIC DECODER & RADAR (ระบบเจาะเพลงและเรดาร์สแกนเพลงในเซิร์ฟเวอร์) BY Lloyd 
-- Standalone Educational Edition (ถอดรหัส SoundId + สแกนผู้เล่นสด + ศึกษาต่อยอด) BY Lloyd 
-- Source Code นี้ถูกเขียนโดยลอยด์ หรือคนที่ส่งไฟล์นี้มาเองครับ ขอบคุณครับ
-- ====================================================================

-- ทำความสะอาด UI เก่าหากเคยเปิดอยู่
if _G.MusicDecoderInstance and typeof(_G.MusicDecoderInstance) == "Instance" then
    pcall(function() _G.MusicDecoderInstance:Destroy() end)
    _G.MusicDecoderInstance = nil
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local LocalPlayer = Players.LocalPlayer

-- --------------------------------------------------------------------
-- 1. Helper Functions: GUI Parent & Clipboard
-- --------------------------------------------------------------------
local function getSafeGuiParent()
    local success, result = pcall(function()
        if gethui then return gethui() end
        if syn and syn.protect_gui then
            local g = Instance.new("ScreenGui")
            syn.protect_gui(g)
            g.Parent = game:GetService("CoreGui")
            return g
        end
        return game:GetService("CoreGui")
    end)
    if success and result then return result end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local function copyToClipboard(text)
    if setclipboard then
        setclipboard(text)
        return true
    elseif toclipboard then
        toclipboard(text)
        return true
    end
    return false
end

local function makeDraggable(dragHandle, frameToMove)
    local dragging = false
    local dragInput, dragStart, startPos
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frameToMove.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frameToMove.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- --------------------------------------------------------------------
-- 2. Brookhaven Remote Events Helper
-- --------------------------------------------------------------------
local RE = ReplicatedStorage:FindFirstChild("RE") or ReplicatedStorage:WaitForChild("RE", 5)
local ToolEvent = RE and RE:FindFirstChild("PlayerToolEvent")
local ScooterEvent = RE and (RE:FindFirstChild("1NoMoto1rVehicle1s") or RE:FindFirstChild("1NoMo1torVeh1icle1s") or RE:FindFirstChild("PlayerScooterEvent"))
local ToolPicker = RE and RE:FindFirstChild("1Too1l")

local function getBoomboxTool()
    local char = LocalPlayer.Character
    if char then
        for _, child in ipairs(char:GetChildren()) do
            if child:IsA("Tool") and string.lower(child.Name):find("boombox", 1, true) then
                return child
            end
        end
    end
    local bp = LocalPlayer:FindFirstChildOfClass("Backpack")
    if bp then
        for _, child in ipairs(bp:GetChildren()) do
            if child:IsA("Tool") and string.lower(child.Name):find("boombox", 1, true) then
                return child
            end
        end
    end
    return nil
end

local function equipBoombox()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local tool = getBoomboxTool()
    if not tool and ToolPicker then
        pcall(function() ToolPicker:InvokeServer("PickingTools", "Boombox") end)
        local start = os.clock()
        while os.clock() - start < 1.5 do
            tool = getBoomboxTool()
            if tool then break end
            task.wait(0.05)
        end
    end
    if tool and char and tool.Parent ~= char then
        if hum then hum:EquipTool(tool) else tool.Parent = char end
        task.wait(0.1)
    end
    return tool
end

local function spawnSkateboard()
    local scEv = ScooterEvent or (RE and (RE:FindFirstChild("1NoMoto1rVehicle1s") or RE:FindFirstChild("1NoMo1torVeh1icle1s") or RE:FindFirstChild("PlayerScooterEvent")))
    if scEv then
        pcall(function() scEv:FireServer("SkateBoard") end)
    end
end

local function playBoombox(assetId)
    local tool = equipBoombox()
    if not tool then return false, "ไม่สามารถเรียกใช้งาน Boombox ได้" end
    if ToolEvent then
        ToolEvent:FireServer("ToolMusicText", tostring(assetId))
        return true, "เปิดเพลงบน Boombox สำเร็จ: " .. tostring(assetId)
    end
    return false, "ไม่พบ RemoteEvent ของ Boombox ใน ReplicatedStorage"
end

local function playSkateboard(assetId)
    spawnSkateboard()
    task.wait(0.2)
    local scEv = ScooterEvent or (RE and (RE:FindFirstChild("1NoMoto1rVehicle1s") or RE:FindFirstChild("1NoMo1torVeh1icle1s") or RE:FindFirstChild("PlayerScooterEvent")))
    if scEv then
        scEv:FireServer("PickingScooterMusicText", tostring(assetId))
        return true, "เปิดเพลงบน สเก็ตบอร์ด สำเร็จ: " .. tostring(assetId)
    end
    return false, "ไม่พบ RemoteEvent ของ สเก็ตบอร์ด ใน ReplicatedStorage"
end

local function stopAllMusic()
    local tool = getBoomboxTool()
    if tool then
        for _, desc in ipairs(tool:GetDescendants()) do
            if desc:IsA("Sound") then desc:Stop(); desc.SoundId = "" end
        end
    end
    if ToolEvent then
        ToolEvent:FireServer("ToolMusicText", "")
        ToolEvent:FireServer("ToolMusicStop", "", nil)
    end
    local char = LocalPlayer.Character
    if char then
        local nmModel = char:FindFirstChild("NoMotorVehicleModel")
        if nmModel then
            for _, desc in ipairs(nmModel:GetDescendants()) do
                if desc:IsA("Sound") then desc:Stop(); desc.SoundId = "" end
            end
        end
    end
    local scEv = ScooterEvent or (RE and (RE:FindFirstChild("1NoMoto1rVehicle1s") or RE:FindFirstChild("1NoMo1torVeh1icle1s") or RE:FindFirstChild("PlayerScooterEvent")))
    if scEv then
        scEv:FireServer("PickingScooterMusicText", "")
        scEv:FireServer("PickingScooterMusicStop", "", nil)
    end
end

-- --------------------------------------------------------------------
-- 3. Audio Decoder Engine (จำลอง C++ URI Parser & Digit-Split)
-- --------------------------------------------------------------------
local function urlDecode(str)
    if type(str) ~= "string" then return "" end
    return (str:gsub("%%(%x%x)", function(hex)
        local n = tonumber(hex, 16)
        return n and string.char(n) or hex
    end))
end

local function cppStripSpacesAndDecode(str)
    if type(str) ~= "string" then return "" end
    -- C++ Sound Engine ลบเฉพาะ ASCII Space (0x20) ก่อนถอดรหัส %XX (ไม่ลบ \t, \r, \n)
    local noSpace = str:gsub(" ", "")
    return urlDecode(noSpace)
end

local function decodeAudioId(rawSoundId)
    if type(rawSoundId) ~= "string" or rawSoundId == "" then
        return nil, "EMPTY", false
    end

    local isObfuscated = (#rawSoundId > 60) or (rawSoundId:find("%%") ~= nil) or (rawSoundId:find("&") ~= nil)

    -- Layer 0: Digit-Split Payload Check (::[digit]::)
    if rawSoundId:find("::%[%d%]") then
        local extracted = rawSoundId:gsub("%D", "")
        if extracted and #extracted >= 4 then
            return extracted, "DIGIT_SPLIT", true
        end
    end

    -- Layer 1: True C++ URI Query & Base-Reset Simulator (Chameleon Parser)
    local bodyAfterScheme = rawSoundId:gsub("^rbxassetid://", "")
    local rawBasePart = bodyAfterScheme:match("^([^&]+)") or ""
    local decBasePart = cppStripSpacesAndDecode(rawBasePart)
    local baseCppValidId = decBasePart:match("^0*(%d+)$")

    local currentCppId = nil
    for param in bodyAfterScheme:gmatch("&([^&]+)") do
        local rawKey, rawVal = param:match("^([^=]+)=(.+)$")
        if rawKey and rawVal then
            local decKey = cppStripSpacesAndDecode(rawKey)
            -- หากไม่มี Null byte คั่นในคีย์ และคีย์เป็น Id / iD / ID จะทำให้ C++ รีเซ็ตกลับไปใช้ Base ID!
            if not decKey:find("%z") and (decKey == "Id" or decKey == "iD" or decKey == "ID") then
                if baseCppValidId and #baseCppValidId >= 4 then
                    currentCppId = baseCppValidId
                end
            elseif decKey == "id" then
                local decVal = cppStripSpacesAndDecode(rawVal)
                -- ตัดส่วนหลัง Null byte (%00)
                local beforeNull = decVal:match("^([^%z]+)") or decVal
                local pureDigits = beforeNull:match("^0*(%d+)$")
                if pureDigits and #pureDigits >= 4 then
                    currentCppId = pureDigits
                else
                    if baseCppValidId and #baseCppValidId >= 4 then
                        currentCppId = baseCppValidId
                    end
                end
            end
        end
    end
    if currentCppId and #currentCppId >= 4 then
        return currentCppId, "URI_CHAMELEON", true
    end

    -- Layer 2: Stripped URL Decode (&id=) Fallback
    local decodedFull = urlDecode(rawSoundId)
    local stripped = decodedFull:gsub("[\226\128\139\226\128\140\226\128\141\226\129\160]", "")
    local lastPlainId = nil
    for idCandidate in stripped:gmatch("&id=0*(%d+)") do
        lastPlainId = idCandidate
    end
    if lastPlainId and #lastPlainId >= 4 then
        return lastPlainId, "URI_FALLBACK", true
    end

    -- Layer 3: Standard Roblox SoundId Patterns
    local standardId = rawSoundId:match("rbxassetid://(%d+)")
        or rawSoundId:match("[?&]id=(%d+)")
        or rawSoundId:match("library/(%d+)")
        or rawSoundId:match("catalog/(%d+)")
        or stripped:match("(%d+)")
    if standardId and #standardId >= 4 then
        local pure = standardId:match("^0*(%d+)") or standardId
        return pure, isObfuscated and "DETECTED_PLAIN" or "PLAIN_AUDIO", isObfuscated
    end

    return nil, "FAILED", false
end

local songInfoCache = {}
local function getSongInfoAsync(assetIdStr, callback)
    if not assetIdStr or assetIdStr == "" or assetIdStr == "0" then
        if callback then callback("Unknown Track", "Roblox") end
        return
    end
    if songInfoCache[assetIdStr] then
        if callback then callback(songInfoCache[assetIdStr].name, songInfoCache[assetIdStr].creator) end
        return
    end

    task.spawn(function()
        local name = "Roblox Audio " .. tostring(assetIdStr)
        local creator = "Roblox"
        local ok, info = pcall(function()
            return MarketplaceService:GetProductInfo(tonumber(assetIdStr), Enum.InfoType.Asset)
        end)
        if ok and info and info.Name and info.Name ~= "" then
            name = info.Name
            creator = info.Creator and info.Creator.Name or "Roblox"
            songInfoCache[assetIdStr] = { name = name, creator = creator }
        end
        if callback then callback(name, creator) end
    end)
end

-- --------------------------------------------------------------------
-- 4. Server Music Radar Scanner
-- --------------------------------------------------------------------
local function scanActiveMusicPlayers()
    local myChar = LocalPlayer.Character
    local myPos = (myChar and myChar:FindFirstChild("HumanoidRootPart")) and myChar.HumanoidRootPart.Position or Vector3.zero

    local results = {}
    local seenPlayers = {}

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and not seenPlayers[p] then
            local foundSound = nil
            local foundSource = ""
            local pChar = p.Character

            -- ตรวจสอบ Boombox ใน Character และ Backpack
            local function checkBoomboxTools(container)
                if not container then return false end
                for _, item in ipairs(container:GetChildren()) do
                    if item:IsA("Tool") and item.Name:lower():find("boombox", 1, true) then
                        for _, desc in ipairs(item:GetDescendants()) do
                            if desc:IsA("Sound") and desc.IsPlaying and desc.SoundId ~= "" and desc.SoundId ~= "0" then
                                foundSound = desc
                                foundSource = "Boombox"
                                return true
                            end
                        end
                    end
                end
                return false
            end

            -- ตรวจสอบ NoMotorVehicleModel ใน Character
            local function checkNoMotorInChar(char)
                if not char then return false end
                local model = char:FindFirstChild("NoMotorVehicleModel")
                if model then
                    for _, desc in ipairs(model:GetDescendants()) do
                        if desc:IsA("Sound") and desc.IsPlaying and desc.SoundId ~= "" and desc.SoundId ~= "0" then
                            foundSound = desc
                            foundSource = "สเก็ตบอร์ด"
                            return true
                        end
                    end
                end
                return false
            end

            if pChar then
                checkBoomboxTools(pChar)
                if not foundSound then checkNoMotorInChar(pChar) end
            end
            if not foundSound and p:FindFirstChild("Backpack") then
                checkBoomboxTools(p.Backpack)
            end

            -- ตรวจสอบ NoMotorVehicleModel ใน Workspace ที่ผู้เล่นกำลังนั่ง
            if not foundSound and pChar then
                for _, model in ipairs(workspace:GetChildren()) do
                    if model.Name == "NoMotorVehicleModel" then
                        local hum = pChar:FindFirstChildOfClass("Humanoid")
                        local seat = hum and hum.SeatPart
                        if seat and seat:IsDescendantOf(model) then
                            for _, desc in ipairs(model:GetDescendants()) do
                                if desc:IsA("Sound") and desc.IsPlaying and desc.SoundId ~= "" and desc.SoundId ~= "0" then
                                    foundSound = desc
                                    foundSource = "สเก็ตบอร์ด"
                                    break
                                end
                            end
                        end
                    end
                    if foundSound then break end
                end
            end

            if foundSound then
                seenPlayers[p] = true
                local rawSid = foundSound.SoundId
                local targetPos = (pChar and pChar:FindFirstChild("HumanoidRootPart")) and pChar.HumanoidRootPart.Position
                    or (foundSound.Parent and foundSound.Parent:IsA("BasePart") and foundSound.Parent.Position)
                    or myPos
                local dist = math.floor(((targetPos - myPos).Magnitude) * 10) / 10

                local cleanId, engineType, wasObfuscated = decodeAudioId(rawSid)
                table.insert(results, {
                    player = p,
                    name = p.Name,
                    displayName = p.DisplayName,
                    distance = dist,
                    realId = cleanId or "ถอดรหัสไม่ได้",
                    rawSoundId = rawSid,
                    wasProtected = wasObfuscated,
                    engine = engineType,
                    source = foundSource
                })
            end
        end
    end

    table.sort(results, function(a, b) return a.distance < b.distance end)
    return results
end

-- --------------------------------------------------------------------
-- 5. Modern GUI Construction
-- --------------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MusicDecoderUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = getSafeGuiParent()
_G.MusicDecoderInstance = ScreenGui

-- Main Container Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 580, 0, 460)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -230)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.2
MainStroke.Color = Color3.fromRGB(110, 90, 240)
MainStroke.Transparency = 0.5
MainStroke.Parent = MainFrame

-- Topbar
local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.Size = UDim2.new(1, 0, 0, 48)
Topbar.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
Topbar.BorderSizePixel = 0
Topbar.Parent = MainFrame

local TopbarCorner = Instance.new("UICorner")
TopbarCorner.CornerRadius = UDim.new(0, 10)
TopbarCorner.Parent = Topbar

local TopbarLineFix = Instance.new("Frame")
TopbarLineFix.Size = UDim2.new(1, 0, 0, 10)
TopbarLineFix.Position = UDim2.new(0, 0, 1, -10)
TopbarLineFix.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
TopbarLineFix.BorderSizePixel = 0
TopbarLineFix.Parent = Topbar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 360, 0, 24)
TitleLabel.Position = UDim2.new(0, 14, 0, 4)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "🔍 Roblox Music Decoder & Radar | เจาะเพลง"
TitleLabel.TextColor3 = Color3.fromRGB(245, 245, 250)
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Topbar

local SubTitleLabel = Instance.new("TextLabel")
SubTitleLabel.Size = UDim2.new(0, 380, 0, 16)
SubTitleLabel.Position = UDim2.new(0, 14, 0, 26)
SubTitleLabel.BackgroundTransparency = 1
SubTitleLabel.Font = Enum.Font.Gotham
SubTitleLabel.Text = "ถอดรหัสพรางตัว C++ URI และสแกนเพลงสดในเซิร์ฟเวอร์"
SubTitleLabel.TextColor3 = Color3.fromRGB(150, 160, 195)
SubTitleLabel.TextSize = 11
SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubTitleLabel.Parent = Topbar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -38, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = Topbar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -72, 0, 10)
MinBtn.BackgroundColor3 = Color3.fromRGB(45, 52, 70)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(220, 225, 235)
MinBtn.TextSize = 13
MinBtn.BorderSizePixel = 0
MinBtn.Parent = Topbar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

makeDraggable(Topbar, MainFrame)

local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 580, 0, 48), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
    else
        MainFrame:TweenSize(UDim2.new(0, 580, 0, 460), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    _G.MusicDecoderInstance = nil
end)

-- Tab Switcher Bar
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Size = UDim2.new(1, -28, 0, 36)
TabBar.Position = UDim2.new(0, 14, 0, 56)
TabBar.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local TabBarCorner = Instance.new("UICorner")
TabBarCorner.CornerRadius = UDim.new(0, 8)
TabBarCorner.Parent = TabBar

local TabBtnDec = Instance.new("TextButton")
TabBtnDec.Size = UDim2.new(0.333, -4, 1, -6)
TabBtnDec.Position = UDim2.new(0, 3, 0, 3)
TabBtnDec.BackgroundColor3 = Color3.fromRGB(110, 80, 235)
TabBtnDec.Font = Enum.Font.GothamBold
TabBtnDec.Text = "🔓 ถอดรหัส (Decoder)"
TabBtnDec.TextColor3 = Color3.fromRGB(255, 255, 255)
TabBtnDec.TextSize = 11
TabBtnDec.BorderSizePixel = 0
TabBtnDec.Parent = TabBar

local TabBtnDecCorner = Instance.new("UICorner")
TabBtnDecCorner.CornerRadius = UDim.new(0, 6)
TabBtnDecCorner.Parent = TabBtnDec

local TabBtnRadar = Instance.new("TextButton")
TabBtnRadar.Size = UDim2.new(0.333, -4, 1, -6)
TabBtnRadar.Position = UDim2.new(0.333, 2, 0, 3)
TabBtnRadar.BackgroundColor3 = Color3.fromRGB(33, 38, 52)
TabBtnRadar.Font = Enum.Font.GothamBold
TabBtnRadar.Text = "📡 เรดาร์สแกนเพลง (Radar)"
TabBtnRadar.TextColor3 = Color3.fromRGB(170, 180, 205)
TabBtnRadar.TextSize = 11
TabBtnRadar.BorderSizePixel = 0
TabBtnRadar.Parent = TabBar

local TabBtnRadarCorner = Instance.new("UICorner")
TabBtnRadarCorner.CornerRadius = UDim.new(0, 6)
TabBtnRadarCorner.Parent = TabBtnRadar

local TabBtnTheory = Instance.new("TextButton")
TabBtnTheory.Size = UDim2.new(0.333, -4, 1, -6)
TabBtnTheory.Position = UDim2.new(0.666, 1, 0, 3)
TabBtnTheory.BackgroundColor3 = Color3.fromRGB(33, 38, 52)
TabBtnTheory.Font = Enum.Font.GothamBold
TabBtnTheory.Text = "📖 วิธีเจาะ (Theory)"
TabBtnTheory.TextColor3 = Color3.fromRGB(170, 180, 205)
TabBtnTheory.TextSize = 11
TabBtnTheory.BorderSizePixel = 0
TabBtnTheory.Parent = TabBar

local TabBtnTheoryCorner = Instance.new("UICorner")
TabBtnTheoryCorner.CornerRadius = UDim.new(0, 6)
TabBtnTheoryCorner.Parent = TabBtnTheory

-- Page Container
local PageContainer = Instance.new("Frame")
PageContainer.Name = "PageContainer"
PageContainer.Size = UDim2.new(1, -28, 1, -104)
PageContainer.Position = UDim2.new(0, 14, 0, 98)
PageContainer.BackgroundTransparency = 1
PageContainer.Parent = MainFrame

-- Toast Notification Helper
local Toast = Instance.new("Frame")
Toast.Size = UDim2.new(1, -28, 0, 32)
Toast.Position = UDim2.new(0, 14, 1, 40)
Toast.BackgroundColor3 = Color3.fromRGB(110, 80, 235)
Toast.BorderSizePixel = 0
Toast.ZIndex = 20
Toast.Parent = MainFrame

local ToastCorner = Instance.new("UICorner")
ToastCorner.CornerRadius = UDim.new(0, 6)
ToastCorner.Parent = Toast

local ToastLabel = Instance.new("TextLabel")
ToastLabel.Size = UDim2.new(1, 0, 1, 0)
ToastLabel.BackgroundTransparency = 1
ToastLabel.Font = Enum.Font.GothamBold
ToastLabel.Text = "แจ้งเตือนสถานะ"
ToastLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ToastLabel.TextSize = 12
ToastLabel.ZIndex = 21
ToastLabel.Parent = Toast

local function showToast(message, isError)
    Toast.BackgroundColor3 = isError and Color3.fromRGB(220, 50, 50) or Color3.fromRGB(110, 80, 235)
    ToastLabel.Text = message
    Toast:TweenPosition(UDim2.new(0, 14, 1, -40), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
    task.delay(2.2, function()
        if Toast and Toast.Parent then
            Toast:TweenPosition(UDim2.new(0, 14, 1, 40), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.25, true)
        end
    end)
end

-- ====================================================================
-- 6. TAB 1: DECODER PAGE
-- ====================================================================
local DecPage = Instance.new("Frame")
DecPage.Name = "DecPage"
DecPage.Size = UDim2.new(1, 0, 1, 0)
DecPage.BackgroundTransparency = 1
DecPage.Parent = PageContainer

local InputScroll = Instance.new("ScrollingFrame")
InputScroll.Size = UDim2.new(1, 0, 0, 110)
InputScroll.Position = UDim2.new(0, 0, 0, 0)
InputScroll.BackgroundColor3 = Color3.fromRGB(27, 32, 45)
InputScroll.BorderSizePixel = 0
InputScroll.ScrollBarThickness = 5
InputScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
InputScroll.Parent = DecPage

local InputScrollCorner = Instance.new("UICorner")
InputScrollCorner.CornerRadius = UDim.new(0, 6)
InputScrollCorner.Parent = InputScroll

local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1, -12, 1, 0)
InputBox.Position = UDim2.new(0, 6, 0, 0)
InputBox.BackgroundTransparency = 1
InputBox.Font = Enum.Font.Code
InputBox.PlaceholderText = "วาง SoundId หรือสตริงกันดักที่ต้องการเจาะที่นี่ (รองรับความยาวนับหมื่นตัวอักษร)..."
InputBox.PlaceholderColor3 = Color3.fromRGB(120, 130, 155)
InputBox.Text = ""
InputBox.TextColor3 = Color3.fromRGB(240, 245, 255)
InputBox.TextSize = 11
InputBox.TextXAlignment = Enum.TextXAlignment.Left
InputBox.TextYAlignment = Enum.TextYAlignment.Top
InputBox.ClearTextOnFocus = false
InputBox.MultiLine = true
InputBox.Parent = InputScroll

InputBox:GetPropertyChangedSignal("Text"):Connect(function()
    InputScroll.CanvasSize = UDim2.new(0, 0, 0, math.max(110, #InputBox.Text / 10))
end)

-- Decode & Clear Action Row
local DecActionRow = Instance.new("Frame")
DecActionRow.Size = UDim2.new(1, 0, 0, 36)
DecActionRow.Position = UDim2.new(0, 0, 0, 118)
DecActionRow.BackgroundTransparency = 1
DecActionRow.Parent = DecPage

local DecodeBtn = Instance.new("TextButton")
DecodeBtn.Size = UDim2.new(0.75, -4, 1, 0)
DecodeBtn.Position = UDim2.new(0, 0, 0, 0)
DecodeBtn.BackgroundColor3 = Color3.fromRGB(110, 80, 235)
DecodeBtn.Font = Enum.Font.GothamBold
DecodeBtn.Text = "⚡ ถอดรหัสทันที (Decode SoundId)"
DecodeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DecodeBtn.TextSize = 13
DecodeBtn.BorderSizePixel = 0
DecodeBtn.Parent = DecActionRow

local DecodeBtnCorner = Instance.new("UICorner")
DecodeBtnCorner.CornerRadius = UDim.new(0, 6)
DecodeBtnCorner.Parent = DecodeBtn

local ClearBtn = Instance.new("TextButton")
ClearBtn.Size = UDim2.new(0.25, -4, 1, 0)
ClearBtn.Position = UDim2.new(0.75, 4, 0, 0)
ClearBtn.BackgroundColor3 = Color3.fromRGB(45, 52, 70)
ClearBtn.Font = Enum.Font.GothamBold
ClearBtn.Text = "🗑️ ล้างข้อความ"
ClearBtn.TextColor3 = Color3.fromRGB(210, 215, 230)
ClearBtn.TextSize = 12
ClearBtn.BorderSizePixel = 0
ClearBtn.Parent = DecActionRow

local ClearBtnCorner = Instance.new("UICorner")
ClearBtnCorner.CornerRadius = UDim.new(0, 6)
ClearBtnCorner.Parent = ClearBtn

-- Result Card Frame
local ResultCard = Instance.new("Frame")
ResultCard.Size = UDim2.new(1, 0, 0, 120)
ResultCard.Position = UDim2.new(0, 0, 0, 162)
ResultCard.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
ResultCard.BorderSizePixel = 0
ResultCard.Parent = DecPage

local ResultCardCorner = Instance.new("UICorner")
ResultCardCorner.CornerRadius = UDim.new(0, 8)
ResultCardCorner.Parent = ResultCard

local ResultCardStroke = Instance.new("UIStroke")
ResultCardStroke.Color = Color3.fromRGB(110, 80, 235)
ResultCardStroke.Transparency = 0.6
ResultCardStroke.Thickness = 1
ResultCardStroke.Parent = ResultCard

local StatusBadge = Instance.new("TextLabel")
StatusBadge.Size = UDim2.new(1, -24, 0, 20)
StatusBadge.Position = UDim2.new(0, 12, 0, 10)
StatusBadge.BackgroundTransparency = 1
StatusBadge.Font = Enum.Font.GothamBold
StatusBadge.Text = "สถานะ: รอการถอดรหัส"
StatusBadge.TextColor3 = Color3.fromRGB(160, 170, 195)
StatusBadge.TextSize = 11
StatusBadge.TextXAlignment = Enum.TextXAlignment.Left
StatusBadge.Parent = ResultCard

local IdLabel = Instance.new("TextLabel")
IdLabel.Size = UDim2.new(1, -24, 0, 32)
IdLabel.Position = UDim2.new(0, 12, 0, 30)
IdLabel.BackgroundTransparency = 1
IdLabel.Font = Enum.Font.GothamBold
IdLabel.Text = "ASSET ID: —"
IdLabel.TextColor3 = Color3.fromRGB(0, 230, 160)
IdLabel.TextSize = 20
IdLabel.TextXAlignment = Enum.TextXAlignment.Left
IdLabel.Parent = ResultCard

local SongTitleLabel = Instance.new("TextLabel")
SongTitleLabel.Size = UDim2.new(1, -24, 0, 20)
SongTitleLabel.Position = UDim2.new(0, 12, 0, 66)
SongTitleLabel.BackgroundTransparency = 1
SongTitleLabel.Font = Enum.Font.Gotham
SongTitleLabel.Text = "ชื่อเพลง: —"
SongTitleLabel.TextColor3 = Color3.fromRGB(230, 235, 245)
SongTitleLabel.TextSize = 12
SongTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SongTitleLabel.Parent = ResultCard

local MetaLabel = Instance.new("TextLabel")
MetaLabel.Size = UDim2.new(1, -24, 0, 18)
MetaLabel.Position = UDim2.new(0, 12, 0, 90)
MetaLabel.BackgroundTransparency = 1
MetaLabel.Font = Enum.Font.Gotham
MetaLabel.Text = "ผู้สร้าง: — | ความยาวข้อความเดิม: 0 ตัวอักษร"
MetaLabel.TextColor3 = Color3.fromRGB(140, 150, 175)
MetaLabel.TextSize = 10
MetaLabel.TextXAlignment = Enum.TextXAlignment.Left
MetaLabel.Parent = ResultCard

-- Action Controls Row (Copy, Roblox Link, Play Bb, Play Sk, Stop)
local ActionRow = Instance.new("Frame")
ActionRow.Size = UDim2.new(1, 0, 0, 36)
ActionRow.Position = UDim2.new(0, 0, 0, 290)
ActionRow.BackgroundTransparency = 1
ActionRow.Parent = DecPage

local CopyIdBtn = Instance.new("TextButton")
CopyIdBtn.Size = UDim2.new(0.2, -4, 1, 0)
CopyIdBtn.Position = UDim2.new(0, 0, 0, 0)
CopyIdBtn.BackgroundColor3 = Color3.fromRGB(40, 50, 70)
CopyIdBtn.Font = Enum.Font.GothamBold
CopyIdBtn.Text = "📋 คัดลอก ID"
CopyIdBtn.TextColor3 = Color3.fromRGB(240, 245, 255)
CopyIdBtn.TextSize = 11
CopyIdBtn.BorderSizePixel = 0
CopyIdBtn.Parent = ActionRow

local CopyIdCorner = Instance.new("UICorner")
CopyIdCorner.CornerRadius = UDim.new(0, 6)
CopyIdCorner.Parent = CopyIdBtn

local CopyLinkBtn = Instance.new("TextButton")
CopyLinkBtn.Size = UDim2.new(0.2, -4, 1, 0)
CopyLinkBtn.Position = UDim2.new(0.2, 2, 0, 0)
CopyLinkBtn.BackgroundColor3 = Color3.fromRGB(40, 50, 70)
CopyLinkBtn.Font = Enum.Font.GothamBold
CopyLinkBtn.Text = "🔗 ลิงก์เว็บ"
CopyLinkBtn.TextColor3 = Color3.fromRGB(240, 245, 255)
CopyLinkBtn.TextSize = 11
CopyLinkBtn.BorderSizePixel = 0
CopyLinkBtn.Parent = ActionRow

local CopyLinkCorner = Instance.new("UICorner")
CopyLinkCorner.CornerRadius = UDim.new(0, 6)
CopyLinkCorner.Parent = CopyLinkBtn

local PlayBbBtn = Instance.new("TextButton")
PlayBbBtn.Size = UDim2.new(0.2, -4, 1, 0)
PlayBbBtn.Position = UDim2.new(0.4, 4, 0, 0)
PlayBbBtn.BackgroundColor3 = Color3.fromRGB(46, 134, 193)
PlayBbBtn.Font = Enum.Font.GothamBold
PlayBbBtn.Text = "📻 Boombox"
PlayBbBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayBbBtn.TextSize = 11
PlayBbBtn.BorderSizePixel = 0
PlayBbBtn.Parent = ActionRow

local PlayBbCorner = Instance.new("UICorner")
PlayBbCorner.CornerRadius = UDim.new(0, 6)
PlayBbCorner.Parent = PlayBbBtn

local PlaySkBtn = Instance.new("TextButton")
PlaySkBtn.Size = UDim2.new(0.2, -4, 1, 0)
PlaySkBtn.Position = UDim2.new(0.6, 6, 0, 0)
PlaySkBtn.BackgroundColor3 = Color3.fromRGB(142, 68, 173)
PlaySkBtn.Font = Enum.Font.GothamBold
PlaySkBtn.Text = "🛹 สเก็ตบอร์ด"
PlaySkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PlaySkBtn.TextSize = 11
PlaySkBtn.BorderSizePixel = 0
PlaySkBtn.Parent = ActionRow

local PlaySkCorner = Instance.new("UICorner")
PlaySkCorner.CornerRadius = UDim.new(0, 6)
PlaySkCorner.Parent = PlaySkBtn

local StopBtn = Instance.new("TextButton")
StopBtn.Size = UDim2.new(0.2, -4, 1, 0)
StopBtn.Position = UDim2.new(0.8, 8, 0, 0)
StopBtn.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
StopBtn.Font = Enum.Font.GothamBold
StopBtn.Text = "⏹️ หยุด"
StopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StopBtn.TextSize = 11
StopBtn.BorderSizePixel = 0
StopBtn.Parent = ActionRow

local StopCorner = Instance.new("UICorner")
StopCorner.CornerRadius = UDim.new(0, 6)
StopCorner.Parent = StopBtn

-- Event Handlers for Tab 1
local lastCleanId = ""

local function doDecode()
    local text = InputBox.Text:gsub("^%s+", ""):gsub("%s+$", "")
    if text == "" then
        showToast("กรุณาวางข้อความ SoundId ที่ต้องการถอดรหัส", true)
        return
    end

    local cleanId, engineType, wasObf = decodeAudioId(text)
    if cleanId and #cleanId >= 4 then
        lastCleanId = cleanId
        IdLabel.Text = "ASSET ID: " .. cleanId
        if wasObf then
            StatusBadge.Text = "🛡️ ตรวจพบการพรางตัว (" .. engineType .. ") — ถอดรหัสสำเร็จ 100%"
            StatusBadge.TextColor3 = Color3.fromRGB(0, 230, 160)
        else
            StatusBadge.Text = "🔓 เพลงปกติทั่วไป (" .. engineType .. ")"
            StatusBadge.TextColor3 = Color3.fromRGB(100, 180, 255)
        end
        MetaLabel.Text = string.format("ตรวจจับ: %s | ความยาวเดิม: %d ตัวอักษร -> ถอดเหลือ %d หลัก", engineType, #text, #cleanId)

        SongTitleLabel.Text = "ชื่อเพลง: กำลังค้นหาข้อมูลจากระบบ Roblox..."
        getSongInfoAsync(cleanId, function(name, creator)
            SongTitleLabel.Text = "ชื่อเพลง: " .. name
            MetaLabel.Text = string.format("ผู้สร้าง: %s | ความยาวเดิม: %d ตัวอักษร -> ถอดเหลือ %d หลัก", creator, #text, #cleanId)
        end)
        showToast("ถอดรหัสเพลงสำเร็จ!", false)
    else
        lastCleanId = ""
        IdLabel.Text = "ASSET ID: ไม่พบ ID เพลง"
        StatusBadge.Text = "❌ ถอดรหัสล้มเหลว (ไม่พบ Asset ID ที่ใช้งานได้)"
        StatusBadge.TextColor3 = Color3.fromRGB(231, 76, 60)
        SongTitleLabel.Text = "ชื่อเพลง: —"
        showToast("ไม่สามารถถอดรหัส Asset ID ได้", true)
    end
end

DecodeBtn.MouseButton1Click:Connect(doDecode)
ClearBtn.MouseButton1Click:Connect(function()
    InputBox.Text = ""
    lastCleanId = ""
    IdLabel.Text = "ASSET ID: —"
    StatusBadge.Text = "สถานะ: รอการถอดรหัส"
    StatusBadge.TextColor3 = Color3.fromRGB(160, 170, 195)
    SongTitleLabel.Text = "ชื่อเพลง: —"
    MetaLabel.Text = "ผู้สร้าง: — | ความยาวข้อความเดิม: 0 ตัวอักษร"
end)

CopyIdBtn.MouseButton1Click:Connect(function()
    if lastCleanId == "" then
        showToast("ไม่มี Asset ID ให้คัดลอก", true)
        return
    end
    if copyToClipboard(lastCleanId) then
        showToast("คัดลอก Asset ID: " .. lastCleanId .. " แล้ว!", false)
    end
end)

CopyLinkBtn.MouseButton1Click:Connect(function()
    if lastCleanId == "" then
        showToast("ไม่มี Asset ID ให้สร้างลิงก์", true)
        return
    end
    local link = "https://www.roblox.com/library/" .. lastCleanId
    if copyToClipboard(link) then
        showToast("คัดลอกลิงก์ Roblox Library แล้ว!", false)
    end
end)

PlayBbBtn.MouseButton1Click:Connect(function()
    if lastCleanId == "" then
        doDecode()
    end
    if lastCleanId ~= "" then
        local ok, msg = playBoombox(lastCleanId)
        showToast(msg, not ok)
    end
end)

PlaySkBtn.MouseButton1Click:Connect(function()
    if lastCleanId == "" then
        doDecode()
    end
    if lastCleanId ~= "" then
        local ok, msg = playSkateboard(lastCleanId)
        showToast(msg, not ok)
    end
end)

StopBtn.MouseButton1Click:Connect(function()
    stopAllMusic()
    showToast("ส่งคำสั่งหยุดเพลงทั้งหมดแล้ว", false)
end)

-- ====================================================================
-- 7. TAB 2: SERVER RADAR PAGE (สแกนเพลงรอบตัว)
-- ====================================================================
local RadarPage = Instance.new("Frame")
RadarPage.Name = "RadarPage"
RadarPage.Size = UDim2.new(1, 0, 1, 0)
RadarPage.BackgroundTransparency = 1
RadarPage.Visible = false
RadarPage.Parent = PageContainer

local RadarHeader = Instance.new("Frame")
RadarHeader.Size = UDim2.new(1, 0, 0, 36)
RadarHeader.Position = UDim2.new(0, 0, 0, 0)
RadarHeader.BackgroundTransparency = 1
RadarHeader.Parent = RadarPage

local ScanBtn = Instance.new("TextButton")
ScanBtn.Size = UDim2.new(0, 160, 1, 0)
ScanBtn.Position = UDim2.new(0, 0, 0, 0)
ScanBtn.BackgroundColor3 = Color3.fromRGB(110, 80, 235)
ScanBtn.Font = Enum.Font.GothamBold
ScanBtn.Text = "🔄 สแกนเดี๋ยวนี้ (Refresh)"
ScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanBtn.TextSize = 12
ScanBtn.BorderSizePixel = 0
ScanBtn.Parent = RadarHeader

local ScanBtnCorner = Instance.new("UICorner")
ScanBtnCorner.CornerRadius = UDim.new(0, 6)
ScanBtnCorner.Parent = ScanBtn

local AutoScanBtn = Instance.new("TextButton")
AutoScanBtn.Size = UDim2.new(0, 150, 1, 0)
AutoScanBtn.Position = UDim2.new(0, 168, 0, 0)
AutoScanBtn.BackgroundColor3 = Color3.fromRGB(33, 38, 52)
AutoScanBtn.Font = Enum.Font.Gotham
AutoScanBtn.Text = "⚪ สแกนอัตโนมัติ (ปิด)"
AutoScanBtn.TextColor3 = Color3.fromRGB(170, 180, 205)
AutoScanBtn.TextSize = 11
AutoScanBtn.BorderSizePixel = 0
AutoScanBtn.Parent = RadarHeader

local AutoScanBtnCorner = Instance.new("UICorner")
AutoScanBtnCorner.CornerRadius = UDim.new(0, 6)
AutoScanBtnCorner.Parent = AutoScanBtn

local RadarCountLabel = Instance.new("TextLabel")
RadarCountLabel.Size = UDim2.new(1, -330, 1, 0)
RadarCountLabel.Position = UDim2.new(0, 326, 0, 0)
RadarCountLabel.BackgroundTransparency = 1
RadarCountLabel.Font = Enum.Font.GothamBold
RadarCountLabel.Text = "ตรวจพบ: 0 คน"
RadarCountLabel.TextColor3 = Color3.fromRGB(0, 220, 160)
RadarCountLabel.TextSize = 12
RadarCountLabel.TextXAlignment = Enum.TextXAlignment.Right
RadarCountLabel.Parent = RadarHeader

local RadarScroll = Instance.new("ScrollingFrame")
RadarScroll.Size = UDim2.new(1, 0, 1, -44)
RadarScroll.Position = UDim2.new(0, 0, 0, 44)
RadarScroll.BackgroundColor3 = Color3.fromRGB(14, 16, 22)
RadarScroll.BorderSizePixel = 0
RadarScroll.ScrollBarThickness = 5
RadarScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
RadarScroll.Parent = RadarPage

local RadarScrollCorner = Instance.new("UICorner")
RadarScrollCorner.CornerRadius = UDim.new(0, 8)
RadarScrollCorner.Parent = RadarScroll

local RadarLayout = Instance.new("UIListLayout")
RadarLayout.SortOrder = Enum.SortOrder.LayoutOrder
RadarLayout.Padding = UDim.new(0, 8)
RadarLayout.Parent = RadarScroll

local RadarPad = Instance.new("UIPadding")
RadarPad.PaddingTop = UDim.new(0, 8)
RadarPad.PaddingBottom = UDim.new(0, 8)
RadarPad.PaddingLeft = UDim.new(0, 8)
RadarPad.PaddingRight = UDim.new(0, 8)
RadarPad.Parent = RadarScroll

RadarLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    RadarScroll.CanvasSize = UDim2.new(0, 0, 0, RadarLayout.AbsoluteContentSize.Y + 20)
end)

local function refreshRadar()
    for _, child in ipairs(RadarScroll:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end

    local list = scanActiveMusicPlayers()
    RadarCountLabel.Text = "ตรวจพบ: " .. tostring(#list) .. " คนที่เปิดเพลง"

    if #list == 0 then
        local emptyLabel = Instance.new("TextLabel")
        emptyLabel.Size = UDim2.new(1, 0, 0, 80)
        emptyLabel.BackgroundTransparency = 1
        emptyLabel.Font = Enum.Font.Gotham
        emptyLabel.Text = "ไม่พบผู้เล่นที่เปิดเพลงในเซิร์ฟเวอร์ขณะนี้ (Boombox หรือ สเก็ตบอร์ด)"
        emptyLabel.TextColor3 = Color3.fromRGB(140, 150, 175)
        emptyLabel.TextSize = 12
        emptyLabel.Parent = RadarScroll
        return
    end

    for idx, item in ipairs(list) do
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, 0, 0, 72)
        card.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
        card.BorderSizePixel = 0
        card.LayoutOrder = idx
        card.Parent = RadarScroll

        local cardCorner = Instance.new("UICorner")
        cardCorner.CornerRadius = UDim.new(0, 6)
        cardCorner.Parent = card

        local cardStroke = Instance.new("UIStroke")
        cardStroke.Color = item.wasProtected and Color3.fromRGB(230, 126, 34) or Color3.fromRGB(46, 204, 113)
        cardStroke.Transparency = 0.6
        cardStroke.Thickness = 1
        cardStroke.Parent = card

        local pNameLabel = Instance.new("TextLabel")
        pNameLabel.Size = UDim2.new(0.65, -8, 0, 18)
        pNameLabel.Position = UDim2.new(0, 10, 0, 6)
        pNameLabel.BackgroundTransparency = 1
        pNameLabel.Font = Enum.Font.GothamBold
        pNameLabel.Text = string.format("%s (@%s) • %s • %.1f studs", item.displayName, item.name, item.source, item.distance)
        pNameLabel.TextColor3 = Color3.fromRGB(245, 245, 250)
        pNameLabel.TextSize = 11
        pNameLabel.TextXAlignment = Enum.TextXAlignment.Left
        pNameLabel.Parent = card

        local pSongLabel = Instance.new("TextLabel")
        pSongLabel.Size = UDim2.new(0.65, -8, 0, 18)
        pSongLabel.Position = UDim2.new(0, 10, 0, 26)
        pSongLabel.BackgroundTransparency = 1
        pSongLabel.Font = Enum.Font.Gotham
        pSongLabel.Text = "ID: " .. item.realId .. " | กำลังดึงชื่อเพลง..."
        pSongLabel.TextColor3 = Color3.fromRGB(0, 220, 160)
        pSongLabel.TextSize = 11
        pSongLabel.TextXAlignment = Enum.TextXAlignment.Left
        pSongLabel.Parent = card

        getSongInfoAsync(item.realId, function(songName)
            if pSongLabel and pSongLabel.Parent then
                pSongLabel.Text = "ID: " .. item.realId .. " | " .. songName
            end
        end)

        local pStatusBadge = Instance.new("TextLabel")
        pStatusBadge.Size = UDim2.new(0.65, -8, 0, 16)
        pStatusBadge.Position = UDim2.new(0, 10, 0, 46)
        pStatusBadge.BackgroundTransparency = 1
        pStatusBadge.Font = Enum.Font.Gotham
        pStatusBadge.Text = item.wasProtected and ("🛡️ มีการพรางตัว (" .. item.engine .. ")") or "🔓 เพลงปกติทั่วไป"
        pStatusBadge.TextColor3 = item.wasProtected and Color3.fromRGB(240, 160, 50) or Color3.fromRGB(100, 200, 255)
        pStatusBadge.TextSize = 10
        pStatusBadge.TextXAlignment = Enum.TextXAlignment.Left
        pStatusBadge.Parent = card

        -- Card Actions (Copy ID, Play along)
        local btnCopy = Instance.new("TextButton")
        btnCopy.Size = UDim2.new(0.16, -4, 0, 28)
        btnCopy.Position = UDim2.new(0.67, 0, 0, 22)
        btnCopy.BackgroundColor3 = Color3.fromRGB(45, 52, 70)
        btnCopy.Font = Enum.Font.GothamBold
        btnCopy.Text = "📋 คัดลอก"
        btnCopy.TextColor3 = Color3.fromRGB(240, 245, 255)
        btnCopy.TextSize = 10
        btnCopy.BorderSizePixel = 0
        btnCopy.Parent = card

        local btnCopyCorner = Instance.new("UICorner")
        btnCopyCorner.CornerRadius = UDim.new(0, 4)
        btnCopyCorner.Parent = btnCopy

        btnCopy.MouseButton1Click:Connect(function()
            if copyToClipboard(item.realId) then
                showToast("คัดลอก ID: " .. item.realId .. " แล้ว!", false)
            end
        end)

        local btnPlay = Instance.new("TextButton")
        btnPlay.Size = UDim2.new(0.16, -4, 0, 28)
        btnPlay.Position = UDim2.new(0.835, 2, 0, 22)
        btnPlay.BackgroundColor3 = Color3.fromRGB(110, 80, 235)
        btnPlay.Font = Enum.Font.GothamBold
        btnPlay.Text = "▶️ เล่นตาม"
        btnPlay.TextColor3 = Color3.fromRGB(255, 255, 255)
        btnPlay.TextSize = 10
        btnPlay.BorderSizePixel = 0
        btnPlay.Parent = card

        local btnPlayCorner = Instance.new("UICorner")
        btnPlayCorner.CornerRadius = UDim.new(0, 4)
        btnPlayCorner.Parent = btnPlay

        btnPlay.MouseButton1Click:Connect(function()
            local ok, msg = playBoombox(item.realId)
            showToast(msg, not ok)
        end)
    end
end

ScanBtn.MouseButton1Click:Connect(function()
    refreshRadar()
    showToast("สแกนเรดาร์เสร็จสิ้น", false)
end)

local autoScanActive = false
AutoScanBtn.MouseButton1Click:Connect(function()
    autoScanActive = not autoScanActive
    if autoScanActive then
        AutoScanBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 130)
        AutoScanBtn.Text = "🔘 สแกนอัตโนมัติ (เปิด)"
        AutoScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        task.spawn(function()
            while autoScanActive and ScreenGui.Parent do
                if RadarPage.Visible then
                    refreshRadar()
                end
                task.wait(3)
            end
        end)
    else
        AutoScanBtn.BackgroundColor3 = Color3.fromRGB(33, 38, 52)
        AutoScanBtn.Text = "⚪ สแกนอัตโนมัติ (ปิด)"
        AutoScanBtn.TextColor3 = Color3.fromRGB(170, 180, 205)
    end
end)

-- ====================================================================
-- 8. TAB 3: DECODER THEORY PAGE (หลักการเจาะและวิธีทำงาน)
-- ====================================================================
local TheoryPage = Instance.new("ScrollingFrame")
TheoryPage.Name = "TheoryPage"
TheoryPage.Size = UDim2.new(1, 0, 1, 0)
TheoryPage.BackgroundTransparency = 1
TheoryPage.BorderSizePixel = 0
TheoryPage.ScrollBarThickness = 5
TheoryPage.Visible = false
TheoryPage.Parent = PageContainer

local TheoryLayout = Instance.new("UIListLayout")
TheoryLayout.SortOrder = Enum.SortOrder.LayoutOrder
TheoryLayout.Padding = UDim.new(0, 10)
TheoryLayout.Parent = TheoryPage

TheoryLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    TheoryPage.CanvasSize = UDim2.new(0, 0, 0, TheoryLayout.AbsoluteContentSize.Y + 20)
end)

local function createTheoryCard(title, bodyText, accentColor, layoutOrder)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -6, 0, 0)
    card.AutomaticSize = Enum.AutomaticSize.Y
    card.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
    card.BorderSizePixel = 0
    card.LayoutOrder = layoutOrder
    card.Parent = TheoryPage

    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 8)
    cardCorner.Parent = card

    local cardStroke = Instance.new("UIStroke")
    cardStroke.Color = accentColor or Color3.fromRGB(110, 80, 235)
    cardStroke.Transparency = 0.6
    cardStroke.Thickness = 1
    cardStroke.Parent = card

    local cardPad = Instance.new("UIPadding")
    cardPad.PaddingTop = UDim.new(0, 10)
    cardPad.PaddingBottom = UDim.new(0, 12)
    cardPad.PaddingLeft = UDim.new(0, 12)
    cardPad.PaddingRight = UDim.new(0, 12)
    cardPad.Parent = card

    local cardTitle = Instance.new("TextLabel")
    cardTitle.Size = UDim2.new(1, 0, 0, 20)
    cardTitle.BackgroundTransparency = 1
    cardTitle.Font = Enum.Font.GothamBold
    cardTitle.Text = title
    cardTitle.TextColor3 = accentColor or Color3.fromRGB(130, 100, 255)
    cardTitle.TextSize = 13
    cardTitle.TextXAlignment = Enum.TextXAlignment.Left
    cardTitle.Parent = card

    local cardBody = Instance.new("TextLabel")
    cardBody.Size = UDim2.new(1, 0, 0, 0)
    cardBody.Position = UDim2.new(0, 0, 0, 24)
    cardBody.AutomaticSize = Enum.AutomaticSize.Y
    cardBody.BackgroundTransparency = 1
    cardBody.Font = Enum.Font.Gotham
    cardBody.Text = bodyText
    cardBody.TextColor3 = Color3.fromRGB(215, 225, 240)
    cardBody.TextSize = 11
    cardBody.TextWrapped = true
    cardBody.TextXAlignment = Enum.TextXAlignment.Left
    cardBody.TextYAlignment = Enum.TextYAlignment.Top
    cardBody.Parent = card

    return card
end

-- Theory Content Cards
createTheoryCard(
    "1. สคริปต์นี้เจาะโค้ดกันดักได้อย่างไร? (Decoder Engine)",
    "สคริปต์นี้สร้างขึ้นโดยจำลองพฤติกรรมของ C++ Sound Engine ของ Roblox แบบ 1:1:\n\n● Layer 0: ตรวจจับโหมด Digit-Split\nดึงตัวเลขจากแพทเทิร์น ::[%d]:: โดยไม่สนข้อความขยะที่คั่นอยู่\n\n● Layer 1: C++ Whitespace Stripping & Query Parser\n- สคริปต์ทั่วไปมักใช้ gsub('%s+', '') ซึ่งจะไปลบ \\t, \\r, \\n แล้วตกหลุมพรางคีย์ยาพิษ\n- แต่สคริปต์นี้ใช้ str:gsub(' ', '') ซึ่งลบเฉพาะ ASCII 0x20 เท่านั้นตามที่เอนจิน C++ ทำ!\n- จากนั้นถอด URL decode และแยกพารามิเตอร์ '&' ทีละตัว\n- ตรวจหาเฉพาะคีย์ที่ถอดออกมาเป็น 'id' แท้จริง และตัดขยะหลัง Null Byte (%00) ทันที\n- หากเจอคีย์ 'Id' หรือ 'iD' หรือ 'ID' โดยไม่มี byte คั่น จะรู้ว่าเอนจินถูกรีเซ็ตกลับไปใช้ Base ID",
    Color3.fromRGB(110, 80, 235),
    1
)

createTheoryCard(
    "2. ทำไมสคริปต์ดักเพลงทั่วไปถึงอ่านไม่ออกหรือติดเพลงปลอม?",
    "● ติดกับดัก Lead Bait (120232514292241):\nสคริปต์ดักเพลงทั่วไปที่เขียนด้วย regex มักง่าย เช่น str:match('%d+') จะคว้าตัวเลขแรกสุดทันที ซึ่งผู้สร้างกันดักจะใส่เลข 120232514292241 (กันดักลอยด์ 4 argon) ไว้หน้าสุด\n\n● ติดกับดัก Poisoned Keys:\nผู้สร้างกันดักจะใส่คีย์ที่มี Tab หรือ Control Characters เช่น '& \\t % 6 9 % 6 4 = 99999999' หากสคริปต์ดักลบช่องว่างแบบเหมารวม จะทำให้คีย์ยาพิษนี้กลายเป็น '&id=99999999' และได้เพลงปลอมไป\n\n● ติดตัวเลขแฝด (Near-Clone Decoys):\nผู้สร้างกันดักจะสุ่มปล่อยตัวเลขปลอมที่มีความยาวเท่ากัน เช่น 1848354999 ทำให้นักพัฒนาที่เขียนสคริปต์ไม่เข้าใจระบบ C++ แยกไม่ออก",
    Color3.fromRGB(230, 126, 34),
    2
)

createTheoryCard(
    "3. วิธีเจาะขั้นสูงสุด: Client Memory Reflection",
    "ใน Executor ระดับสูง คุณสามารถข้ามการถอดรหัสสตริงทั้งหมดได้โดยการเข้าถึงหน่วยความจำของเอนจินเสียงโดยตรง:\n\n- ตัวอย่าง: หากอ่านค่าจาก internal AudioContent หรือ Sound.PlaybackRegions / AudioPlayer ในตัวเอนจิน จะได้ตัวเลข Asset ID แท้จริงเสมอ เพราะไม่ว่าสตริงภายนอกจะพรางอย่างไร ตอนที่เกมจะดาวน์โหลดไฟล์เสียงจากเซิร์ฟเวอร์ Roblox เอนจินต้องถอดรหัสออกมาเป็นตัวเลขเดียวเพื่อส่ง HTTP Request ไปที่ assetdelivery.roblox.com",
    Color3.fromRGB(46, 204, 113),
    3
)

-- Tab Switcher Logic
local function switchTab(activeTab)
    DecPage.Visible = (activeTab == "DEC")
    RadarPage.Visible = (activeTab == "RADAR")
    TheoryPage.Visible = (activeTab == "THEORY")

    TabBtnDec.BackgroundColor3 = (activeTab == "DEC") and Color3.fromRGB(110, 80, 235) or Color3.fromRGB(33, 38, 52)
    TabBtnDec.TextColor3 = (activeTab == "DEC") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(170, 180, 205)

    TabBtnRadar.BackgroundColor3 = (activeTab == "RADAR") and Color3.fromRGB(110, 80, 235) or Color3.fromRGB(33, 38, 52)
    TabBtnRadar.TextColor3 = (activeTab == "RADAR") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(170, 180, 205)

    TabBtnTheory.BackgroundColor3 = (activeTab == "THEORY") and Color3.fromRGB(110, 80, 235) or Color3.fromRGB(33, 38, 52)
    TabBtnTheory.TextColor3 = (activeTab == "THEORY") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(170, 180, 205)

    if activeTab == "RADAR" then
        refreshRadar()
    end
end

TabBtnDec.MouseButton1Click:Connect(function() switchTab("DEC") end)
TabBtnRadar.MouseButton1Click:Connect(function() switchTab("RADAR") end)
TabBtnTheory.MouseButton1Click:Connect(function() switchTab("THEORY") end)

showToast("🔍 ระบบเจาะเพลงและเรดาร์ โหลดเสร็จสมบูรณ์!", false)
