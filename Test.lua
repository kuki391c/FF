--[[
    ===================================================
    🔥 SCRIPT GUI - HONKUKIXYZEIEI HUB 🔥
    Credit: HONKUKIXYZEIEI
    ===================================================
--]]

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Remote References
local CarRemote = ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Player1sCa1r")
local RPNameRemote = ReplicatedStorage:WaitForChild("RE"):WaitForChild("1RPNam1eColo1r")

-- Variable States
local RainbowCarActive = false
local RainbowRPActive = false
local RainbowBioActive = false

local SelectedPlayer = nil
local LoopTPActive = false
local SpectateActive = false
local ESPActive = false

-- Color HSV Speed Variable
local RainbowSpeed = 100 -- ค่าความไวเปลี่ยนสี

-- Helper Function for Rainbow Color Generation
local function GetRainbowColor()
    local t = tick() * (RainbowSpeed / 10)
    return Color3.fromHSV(t % 1, 1, 1)
end

--------------------------------------------------------------------------------
-- 1. BUILD GUI & BLUR BACKGROUND
--------------------------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HONKUKIXYZ_GUI"
ScreenGui.ResetOnSpawn = false

-- Anti-duplicate Protection
if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Blur Effect Background
local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Name = "UIBlurEffect"
BlurEffect.Size = 0
BlurEffect.Parent = Lighting

-- Open / Close Toggle Button (Floating Button)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0.05, 0, 0.15, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(35, 15, 60)
ToggleButton.TextColor3 = Color3.fromRGB(220, 180, 255)
ToggleButton.Text = "🔮"
ToggleButton.TextSize = 24
ToggleButton.Font = Enum.Font.Garamond
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Parent = ScreenGui

local UICornerBtn = Instance.new("UICorner", ToggleButton)
UICornerBtn.CornerRadius = UDim.new(0.5, 0)

local UIStrokeBtn = Instance.new("UIStroke", ToggleButton)
UIStrokeBtn.Color = Color3.fromRGB(160, 80, 255)
UIStrokeBtn.Thickness = 2

-- Main Frame (Slightly responsive square style for Mobile)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 340, 0, 360)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 12, 30)
MainFrame.BackgroundTransparency = 0.15
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner", MainFrame)
UICornerMain.CornerRadius = UDim.new(0, 16)

local UIStrokeMain = Instance.new("UIStroke", MainFrame)
UIStrokeMain.Color = Color3.fromRGB(140, 60, 230)
UIStrokeMain.Thickness = 2

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Color3.fromRGB(30, 18, 48)
Header.Parent = MainFrame

local UICornerHeader = Instance.new("UICorner", Header)
UICornerHeader.CornerRadius = UDim.new(0, 16)

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.Text = "HONKUKIXYZEIEI HUB"
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 16
TitleText.TextColor3 = Color3.fromRGB(220, 180, 255)
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.BackgroundTransparency = 1
TitleText.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -38, 0, 7)
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Parent = Header

-- Tab Navigation Buttons
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 35)
TabContainer.Position = UDim2.new(0, 10, 0, 50)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local Tab1Btn = Instance.new("TextButton")
Tab1Btn.Size = UDim2.new(0.48, 0, 1, 0)
Tab1Btn.Position = UDim2.new(0, 0, 0, 0)
Tab1Btn.Text = "🚗 Vehicle & Bio"
Tab1Btn.Font = Enum.Font.GothamBold
Tab1Btn.TextSize = 12
Tab1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab1Btn.BackgroundColor3 = Color3.fromRGB(120, 50, 200)
Tab1Btn.Parent = TabContainer

local UICornerTab1 = Instance.new("UICorner", Tab1Btn)
UICornerTab1.CornerRadius = UDim.new(0, 8)

local Tab2Btn = Instance.new("TextButton")
Tab2Btn.Size = UDim2.new(0.48, 0, 1, 0)
Tab2Btn.Position = UDim2.new(0.52, 0, 0, 0)
Tab2Btn.Text = "👤 Player"
Tab2Btn.Font = Enum.Font.GothamBold
Tab2Btn.TextSize = 12
Tab2Btn.TextColor3 = Color3.fromRGB(180, 180, 200)
Tab2Btn.BackgroundColor3 = Color3.fromRGB(40, 25, 60)
Tab2Btn.Parent = TabContainer

local UICornerTab2 = Instance.new("UICorner", Tab2Btn)
UICornerTab2.CornerRadius = UDim.new(0, 8)

-- Pages Container
local Page1 = Instance.new("ScrollingFrame")
Page1.Size = UDim2.new(1, -20, 1, -100)
Page1.Position = UDim2.new(0, 10, 0, 90)
Page1.BackgroundTransparency = 1
Page1.ScrollBarThickness = 4
Page1.ScrollBarImageColor3 = Color3.fromRGB(140, 60, 230)
Page1.Parent = MainFrame

local Page2 = Instance.new("ScrollingFrame")
Page2.Size = UDim2.new(1, -20, 1, -100)
Page2.Position = UDim2.new(0, 10, 0, 90)
Page2.BackgroundTransparency = 1
Page2.ScrollBarThickness = 4
Page2.ScrollBarImageColor3 = Color3.fromRGB(140, 60, 230)
Page2.Visible = false
Page2.Parent = MainFrame

local UIList1 = Instance.new("UIListLayout", Page1)
UIList1.Padding = UDim.new(0, 8)
UIList1.SortOrder = Enum.SortOrder.LayoutOrder

local UIList2 = Instance.new("UIListLayout", Page2)
UIList2.Padding = UDim.new(0, 8)
UIList2.SortOrder = Enum.SortOrder.LayoutOrder

--------------------------------------------------------------------------------
-- 2. HELPER UI CREATOR
--------------------------------------------------------------------------------
local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -5, 0, 38)
    Btn.BackgroundColor3 = Color3.fromRGB(45, 25, 70)
    Btn.Text = text
    Btn.Font = Enum.Font.GothamMedium
    Btn.TextSize = 13
    Btn.TextColor3 = Color3.fromRGB(240, 230, 255)
    Btn.Parent = parent

    local UICorner = Instance.new("UICorner", Btn)
    UICorner.CornerRadius = UDim.new(0, 8)

    local UIStroke = Instance.new("UIStroke", Btn)
    UIStroke.Color = Color3.fromRGB(100, 50, 160)
    UIStroke.Thickness = 1

    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

local function CreateToggle(parent, text, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -5, 0, 38)
    Frame.BackgroundColor3 = Color3.fromRGB(45, 25, 70)
    Frame.Parent = parent

    local UICorner = Instance.new("UICorner", Frame)
    UICorner.CornerRadius = UDim.new(0, 8)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = text
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 13
    Label.TextColor3 = Color3.fromRGB(240, 230, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Frame

    local SwitchBg = Instance.new("Frame")
    SwitchBg.Size = UDim2.new(0, 42, 0, 22)
    SwitchBg.Position = UDim2.new(1, -50, 0.5, -11)
    SwitchBg.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
    SwitchBg.Parent = Frame

    local SwitchCorner = Instance.new("UICorner", SwitchBg)
    SwitchCorner.CornerRadius = UDim.new(1, 0)

    local SwitchKnob = Instance.new("Frame")
    SwitchKnob.Size = UDim2.new(0, 18, 0, 18)
    SwitchKnob.Position = UDim2.new(0, 2, 0.5, -9)
    SwitchKnob.BackgroundColor3 = Color3.fromRGB(180, 180, 200)
    SwitchKnob.Parent = SwitchBg

    local KnobCorner = Instance.new("UICorner", SwitchKnob)
    KnobCorner.CornerRadius = UDim.new(1, 0)

    local ClickBtn = Instance.new("TextButton")
    ClickBtn.Size = UDim2.new(1, 0, 1, 0)
    ClickBtn.BackgroundTransparency = 1
    ClickBtn.Text = ""
    ClickBtn.Parent = Frame

    local toggled = false
    ClickBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            TweenService:Create(SwitchKnob, TweenInfo.new(0.2), {Position = UDim2.new(1, -20, 0.5, -9), BackgroundColor3 = Color3.fromRGB(180, 80, 255)}):Play()
            TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(90, 40, 140)}):Play()
        else
            TweenService:Create(SwitchKnob, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -9), BackgroundColor3 = Color3.fromRGB(180, 180, 200)}):Play()
            TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 20, 40)}):Play()
        end
        callback(toggled)
    end)
    return Frame
end

--------------------------------------------------------------------------------
-- 3. SMOOTH UI ANIMATIONS & TABS
--------------------------------------------------------------------------------
local isOpen = true
local originalSize = UDim2.new(0, 340, 0, 360)

local function ToggleGUI()
    isOpen = not isOpen
    if isOpen then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = originalSize}):Play()
        TweenService:Create(BlurEffect, TweenInfo.new(0.4), {Size = 15}):Play()
    else
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 340, 0, 0)})
        tween:Play()
        TweenService:Create(BlurEffect, TweenInfo.new(0.3), {Size = 0}):Play()
        tween.Completed:Connect(function()
            if not isOpen then
                MainFrame.Visible = false
            end
        end)
    end
end

ToggleButton.MouseButton1Click:Connect(ToggleGUI)
CloseBtn.MouseButton1Click:Connect(ToggleGUI)

Tab1Btn.MouseButton1Click:Connect(function()
    Page1.Visible = true
    Page2.Visible = false
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(120, 50, 200)
    Tab1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab2Btn.BackgroundColor3 = Color3.fromRGB(40, 25, 60)
    Tab2Btn.TextColor3 = Color3.fromRGB(180, 180, 200)
end)

Tab2Btn.MouseButton1Click:Connect(function()
    Page1.Visible = false
    Page2.Visible = true
    Tab2Btn.BackgroundColor3 = Color3.fromRGB(120, 50, 200)
    Tab2Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(40, 25, 60)
    Tab1Btn.TextColor3 = Color3.fromRGB(180, 180, 200)
end)

--------------------------------------------------------------------------------
-- 4. CATEGORY 1: VEHICLE & BIO (REMOTE RAINBOWS)
--------------------------------------------------------------------------------
CreateToggle(Page1, "🏎️ สีรถเรนโบว์ (Speed 100)", function(state)
    RainbowCarActive = state
end)

CreateToggle(Page1, "🏷️ เปลี่ยนสีชื่อ RP เรนโบว์", function(state)
    RainbowRPActive = state
end)

CreateToggle(Page1, "📝 เปลี่ยนสีชื่อ Bio เรนโบว์", function(state)
    RainbowBioActive = state
end)

-- Loop สำหรับยิง Remote เรนโบว์แบบไวๆ
task.spawn(function()
    while true do
        task.wait(0.01) -- ความเร็วระดับ 100
        local color = GetRainbowColor()

        if RainbowCarActive then
            pcall(function()
                CarRemote:FireServer("NoMotorColor", color)
            end)
        end

        if RainbowRPActive then
            pcall(function()
                RPNameRemote:FireServer("PickingRPNameColor", color)
            end)
        end

        if RainbowBioActive then
            pcall(function()
                RPNameRemote:FireServer("PickingRPBioColor", color)
            end)
        end
    end
end)

--------------------------------------------------------------------------------
-- 5. CATEGORY 2: PLAYER FEATURES
--------------------------------------------------------------------------------
-- [Button 1]: Player Speed Slider
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(1, -5, 0, 55)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(45, 25, 70)
SpeedFrame.Parent = Page2

local UICornerSpd = Instance.new("UICorner", SpeedFrame)
UICornerSpd.CornerRadius = UDim.new(0, 8)

local SpeedTitle = Instance.new("TextLabel")
SpeedTitle.Size = UDim2.new(1, -20, 0, 20)
SpeedTitle.Position = UDim2.new(0, 10, 0, 5)
SpeedTitle.Text = "⚡ ความเร็วผู้เล่น: 16"
SpeedTitle.Font = Enum.Font.GothamMedium
SpeedTitle.TextSize = 12
SpeedTitle.TextColor3 = Color3.fromRGB(240, 230, 255)
SpeedTitle.TextXAlignment = Enum.TextXAlignment.Left
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.Parent = SpeedFrame

local SliderBg = Instance.new("Frame")
SliderBg.Size = UDim2.new(1, -20, 0, 10)
SliderBg.Position = UDim2.new(0, 10, 0, 32)
SliderBg.BackgroundColor3 = Color3.fromRGB(25, 15, 35)
SliderBg.Parent = SpeedFrame

local UICornerSbg = Instance.new("UICorner", SliderBg)
UICornerSbg.CornerRadius = UDim.new(1, 0)

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new((16-16)/(1000-16), 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(160, 60, 255)
SliderFill.Parent = SliderBg

local UICornerSfl = Instance.new("UICorner", SliderFill)
UICornerSfl.CornerRadius = UDim.new(1, 0)

local isDragging = false
local function UpdateSpeed(input)
    local pos = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
    SliderFill.Size = UDim2.new(pos, 0, 1, 0)
    local speedValue = math.floor(16 + (pos * (1000 - 16)))
    SpeedTitle.Text = "⚡ ความเร็วผู้เล่น: " .. tostring(speedValue)
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = speedValue
    end
end

SliderBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = true
        UpdateSpeed(input)
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        UpdateSpeed(input)
    end
end)

-- [Button 2]: Player Dropdown / Select & Refresh Button
local SelectFrame = Instance.new("Frame")
SelectFrame.Size = UDim2.new(1, -5, 0, 60)
SelectFrame.BackgroundColor3 = Color3.fromRGB(45, 25, 70)
SelectFrame.Parent = Page2

local UICornerSel = Instance.new("UICorner", SelectFrame)
UICornerSel.CornerRadius = UDim.new(0, 8)

local SelectedText = Instance.new("TextLabel")
SelectedText.Size = UDim2.new(0.65, 0, 1, 0)
SelectedText.Position = UDim2.new(0, 10, 0, 0)
SelectedText.Text = "เลือกผู้เล่น: -"
SelectedText.Font = Enum.Font.GothamMedium
SelectedText.TextSize = 12
SelectedText.TextColor3 = Color3.fromRGB(220, 220, 240)
SelectedText.TextXAlignment = Enum.TextXAlignment.Left
SelectedText.BackgroundTransparency = 1
SelectedText.Parent = SelectFrame

local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Size = UDim2.new(0.3, -10, 0, 32)
RefreshBtn.Position = UDim2.new(0.7, 0, 0.5, -16)
RefreshBtn.BackgroundColor3 = Color3.fromRGB(90, 40, 150)
RefreshBtn.Text = "🔄 Refresh"
RefreshBtn.Font = Enum.Font.GothamBold
RefreshBtn.TextSize = 11
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.Parent = SelectFrame

local UICornerRef = Instance.new("UICorner", RefreshBtn)
UICornerRef.CornerRadius = UDim.new(0, 6)

-- Player List Menu Overlay
local PlayerListFrame = Instance.new("ScrollingFrame")
PlayerListFrame.Size = UDim2.new(0, 180, 0, 150)
PlayerListFrame.Position = UDim2.new(0.5, -90, 0.5, -75)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(25, 15, 40)
PlayerListFrame.Visible = false
PlayerListFrame.ZIndex = 10
PlayerListFrame.Parent = ScreenGui

local UICornerPlr = Instance.new("UICorner", PlayerListFrame)
UICornerPlr.CornerRadius = UDim.new(0, 8)

local ListLayout = Instance.new("UIListLayout", PlayerListFrame)
ListLayout.Padding = UDim.new(0, 4)

local function UpdatePlayerList()
    for _, v in pairs(PlayerListFrame:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local pBtn = Instance.new("TextButton")
            pBtn.Size = UDim2.new(1, -8, 0, 28)
            pBtn.BackgroundColor3 = Color3.fromRGB(45, 25, 70)
            pBtn.Text = plr.DisplayName .. " (@" .. plr.Name .. ")"
            pBtn.Font = Enum.Font.GothamMedium
            pBtn.TextSize = 11
            pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            pBtn.ZIndex = 11
            pBtn.Parent = PlayerListFrame

            pBtn.MouseButton1Click:Connect(function()
                SelectedPlayer = plr
                SelectedText.Text = "เลือก: " .. plr.DisplayName
                PlayerListFrame.Visible = false
            end)
        end
    end
end

RefreshBtn.MouseButton1Click:Connect(function()
    UpdatePlayerList()
    PlayerListFrame.Visible = not PlayerListFrame.Visible
end)

-- [Button 3]: Teleport Choice (TP / Loop TP)
CreateButton(Page2, "🚀 วาร์ปไปหาผู้เล่น (TP)", function()
    if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = SelectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
        end
    end
end)

CreateToggle(Page2, "🧲 วาร์ปติดตัวตลอดเวลา (Loop TP)", function(state)
    LoopTPActive = state
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if LoopTPActive and SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = SelectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
            end
        end
    end
end)

-- [Button 4]: Spectate Player
CreateToggle(Page2, "👁️ ดูมุมกล้อง Player ที่เลือก", function(state)
    SpectateActive = state
    local Camera = workspace.CurrentCamera
    if SpectateActive and SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("Humanoid") then
        Camera.CameraSubject = SelectedPlayer.Character.Humanoid
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            Camera.CameraSubject = LocalPlayer.Character.Humanoid
        end
    end
end)

-- [Button 5]: ESP Player (Real-time No Lag)
local ESPFolder = Instance.new("Folder", ScreenGui)
ESPFolder.Name = "ESPFolder"

CreateToggle(Page2, "👁️‍🗨️ เปิด ESP แสดงชื่อผู้เล่นทุกคน", function(state)
    ESPActive = state
    if not state then
        ESPFolder:ClearAllChildren()
    end
end)

RunService.RenderStepped:Connect(function()
    if ESPActive then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                local head = plr.Character.Head
                local espName = ESPFolder:FindFirstChild(plr.Name)
                
                if not espName then
                    local bgGui = Instance.new("BillboardGui")
                    bgGui.Name = plr.Name
                    bgGui.Adornee = head
                    bgGui.Size = UDim2.new(0, 150, 0, 40)
                    bgGui.StudsOffset = Vector3.new(0, 2.5, 0)
                    bgGui.AlwaysOnTop = true
                    bgGui.Parent = ESPFolder

                    local lbl = Instance.new("TextLabel")
                    lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.Text = plr.DisplayName .. "\n(@" .. plr.Name .. ")"
                    lbl.Font = Enum.Font.GothamBold
                    lbl.TextSize = 12
                    lbl.TextColor3 = Color3.fromRGB(200, 120, 255)
                    lbl.TextStrokeTransparency = 0.2
                    lbl.Parent = bgGui
                end
            end
        end
    end
end)

print("HONKUKIXYZEIEI HUB Loaded Successfully!")
