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
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

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

-- Category 3 States (Protections)
local AntiSitActive = false
local AntiFlingActive = false
local AntiLagActive = false
local SuperProtActive = false

-- Color HSV Speed Variable
local RainbowSpeed = 100 -- ค่าความไวเปลี่ยนสี

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

if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Name = "UIBlurEffect"
BlurEffect.Size = 0
BlurEffect.Parent = Lighting

-- Toggle Floating Button
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

-- Main Frame (Mobile Responsive)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 340, 0, 380)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -190)
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
TitleText.TextSize = 15
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

-- Tab Navigation Buttons (3 Tabs now)
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 35)
TabContainer.Position = UDim2.new(0, 10, 0, 50)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local Tab1Btn = Instance.new("TextButton")
Tab1Btn.Size = UDim2.new(0.32, 0, 1, 0)
Tab1Btn.Position = UDim2.new(0, 0, 0, 0)
Tab1Btn.Text = "🚗 Vehicle"
Tab1Btn.Font = Enum.Font.GothamBold
Tab1Btn.TextSize = 11
Tab1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab1Btn.BackgroundColor3 = Color3.fromRGB(120, 50, 200)
Tab1Btn.Parent = TabContainer
Instance.new("UICorner", Tab1Btn).CornerRadius = UDim.new(0, 8)

local Tab2Btn = Instance.new("TextButton")
Tab2Btn.Size = UDim2.new(0.32, 0, 1, 0)
Tab2Btn.Position = UDim2.new(0.34, 0, 0, 0)
Tab2Btn.Text = "👤 Player"
Tab2Btn.Font = Enum.Font.GothamBold
Tab2Btn.TextSize = 11
Tab2Btn.TextColor3 = Color3.fromRGB(180, 180, 200)
Tab2Btn.BackgroundColor3 = Color3.fromRGB(40, 25, 60)
Tab2Btn.Parent = TabContainer
Instance.new("UICorner", Tab2Btn).CornerRadius = UDim.new(0, 8)

local Tab3Btn = Instance.new("TextButton")
Tab3Btn.Size = UDim2.new(0.32, 0, 1, 0)
Tab3Btn.Position = UDim2.new(0.68, 0, 0, 0)
Tab3Btn.Text = "🛡️ Protection"
Tab3Btn.Font = Enum.Font.GothamBold
Tab3Btn.TextSize = 11
Tab3Btn.TextColor3 = Color3.fromRGB(180, 180, 200)
Tab3Btn.BackgroundColor3 = Color3.fromRGB(40, 25, 60)
Tab3Btn.Parent = TabContainer
Instance.new("UICorner", Tab3Btn).CornerRadius = UDim.new(0, 8)

-- Pages Container
local Page1 = Instance.new("ScrollingFrame")
Page1.Size = UDim2.new(1, -20, 1, -100)
Page1.Position = UDim2.new(0, 10, 0, 95)
Page1.BackgroundTransparency = 1
Page1.ScrollBarThickness = 4
Page1.ScrollBarImageColor3 = Color3.fromRGB(140, 60, 230)
Page1.Parent = MainFrame

local Page2 = Instance.new("ScrollingFrame")
Page2.Size = UDim2.new(1, -20, 1, -100)
Page2.Position = UDim2.new(0, 10, 0, 95)
Page2.BackgroundTransparency = 1
Page2.ScrollBarThickness = 4
Page2.ScrollBarImageColor3 = Color3.fromRGB(140, 60, 230)
Page2.Visible = false
Page2.Parent = MainFrame

local Page3 = Instance.new("ScrollingFrame")
Page3.Size = UDim2.new(1, -20, 1, -100)
Page3.Position = UDim2.new(0, 10, 0, 95)
Page3.BackgroundTransparency = 1
Page3.ScrollBarThickness = 4
Page3.ScrollBarImageColor3 = Color3.fromRGB(140, 60, 230)
Page3.Visible = false
Page3.Parent = MainFrame

Instance.new("UIListLayout", Page1).Padding = UDim.new(0, 8)
Instance.new("UIListLayout", Page2).Padding = UDim.new(0, 8)
Instance.new("UIListLayout", Page3).Padding = UDim.new(0, 8)

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

    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
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

    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = text
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 12
    Label.TextColor3 = Color3.fromRGB(240, 230, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Frame

    local SwitchBg = Instance.new("Frame")
    SwitchBg.Size = UDim2.new(0, 42, 0, 22)
    SwitchBg.Position = UDim2.new(1, -50, 0.5, -11)
    SwitchBg.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
    SwitchBg.Parent = Frame

    Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(1, 0)

    local SwitchKnob = Instance.new("Frame")
    SwitchKnob.Size = UDim2.new(0, 18, 0, 18)
    SwitchKnob.Position = UDim2.new(0, 2, 0.5, -9)
    SwitchKnob.BackgroundColor3 = Color3.fromRGB(180, 180, 200)
    SwitchKnob.Parent = SwitchBg

    Instance.new("UICorner", SwitchKnob).CornerRadius = UDim.new(1, 0)

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
local originalSize = UDim2.new(0, 340, 0, 380)

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
            if not isOpen then MainFrame.Visible = false end
        end)
    end
end

ToggleButton.MouseButton1Click:Connect(ToggleGUI)
CloseBtn.MouseButton1Click:Connect(ToggleGUI)

Tab1Btn.MouseButton1Click:Connect(function()
    Page1.Visible = true; Page2.Visible = false; Page3.Visible = false
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(120, 50, 200); Tab1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab2Btn.BackgroundColor3 = Color3.fromRGB(40, 25, 60); Tab2Btn.TextColor3 = Color3.fromRGB(180, 180, 200)
    Tab3Btn.BackgroundColor3 = Color3.fromRGB(40, 25, 60); Tab3Btn.TextColor3 = Color3.fromRGB(180, 180, 200)
end)

Tab2Btn.MouseButton1Click:Connect(function()
    Page1.Visible = false; Page2.Visible = true; Page3.Visible = false
    Tab2Btn.BackgroundColor3 = Color3.fromRGB(120, 50, 200); Tab2Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(40, 25, 60); Tab1Btn.TextColor3 = Color3.fromRGB(180, 180, 200)
    Tab3Btn.BackgroundColor3 = Color3.fromRGB(40, 25, 60); Tab3Btn.TextColor3 = Color3.fromRGB(180, 180, 200)
end)

Tab3Btn.MouseButton1Click:Connect(function()
    Page1.Visible = false; Page2.Visible = false; Page3.Visible = true
    Tab3Btn.BackgroundColor3 = Color3.fromRGB(120, 50, 200); Tab3Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(40, 25, 60); Tab1Btn.TextColor3 = Color3.fromRGB(180, 180, 200)
    Tab2Btn.BackgroundColor3 = Color3.fromRGB(40, 25, 60); Tab2Btn.TextColor3 = Color3.fromRGB(180, 180, 200)
end)

--------------------------------------------------------------------------------
-- 4. CATEGORY 1: VEHICLE & BIO
--------------------------------------------------------------------------------
CreateToggle(Page1, "🏎️ สีรถเรนโบว์ (Speed 100)", function(state) RainbowCarActive = state end)
CreateToggle(Page1, "🏷️ เปลี่ยนสีชื่อ RP เรนโบว์", function(state) RainbowRPActive = state end)
CreateToggle(Page1, "📝 เปลี่ยนสีชื่อ Bio เรนโบว์", function(state) RainbowBioActive = state end)

task.spawn(function()
    while true do
        task.wait(0.01)
        local color = GetRainbowColor()
        if RainbowCarActive then pcall(function() CarRemote:FireServer("NoMotorColor", color) end) end
        if RainbowRPActive then pcall(function() RPNameRemote:FireServer("PickingRPNameColor", color) end) end
        if RainbowBioActive then pcall(function() RPNameRemote:FireServer("PickingRPBioColor", color) end) end
    end
end)

--------------------------------------------------------------------------------
-- 5. CATEGORY 2: PLAYER FEATURES (Fixed Centered Layout)
--------------------------------------------------------------------------------
-- Speed Slider
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(1, -5, 0, 55)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(45, 25, 70)
SpeedFrame.Parent = Page2
Instance.new("UICorner", SpeedFrame).CornerRadius = UDim.new(0, 8)

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
Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(1, 0)

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(160, 60, 255)
SliderFill.Parent = SliderBg
Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)

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
        isDragging = true; UpdateSpeed(input)
    end
end)
game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isDragging = false end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then UpdateSpeed(input) end
end)

-- Player Selector & Refresh Area (Centered Text & Split Buttons)
local SelectFrame = Instance.new("Frame")
SelectFrame.Size = UDim2.new(1, -5, 0, 50)
SelectFrame.BackgroundColor3 = Color3.fromRGB(45, 25, 70)
SelectFrame.Parent = Page2
Instance.new("UICorner", SelectFrame).CornerRadius = UDim.new(0, 8)

-- Text อยู่ตรงกลางช่องพอดี
local SelectedText = Instance.new("TextLabel")
SelectedText.Size = UDim2.new(1, -110, 1, 0)
SelectedText.Position = UDim2.new(0, 10, 0, 0)
SelectedText.Text = "เลือก: -"
SelectedText.Font = Enum.Font.GothamMedium
SelectedText.TextSize = 12
SelectedText.TextColor3 = Color3.fromRGB(220, 220, 240)
SelectedText.TextXAlignment = Enum.TextXAlignment.Center
SelectedText.BackgroundTransparency = 1
SelectedText.Parent = SelectFrame

-- ปุ่ม Refresh แยกส่วนด้านขวา
local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Size = UDim2.new(0, 90, 0, 32)
RefreshBtn.Position = UDim2.new(1, -98, 0.5, -16)
RefreshBtn.BackgroundColor3 = Color3.fromRGB(90, 40, 150)
RefreshBtn.Text = "🔄 Refresh"
RefreshBtn.Font = Enum.Font.GothamBold
RefreshBtn.TextSize = 11
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.Parent = SelectFrame
Instance.new("UICorner", RefreshBtn).CornerRadius = UDim.new(0, 6)

-- Player List Menu (Real-time update showing Honkukixyzeiei + LocalPlayer + All Players)
local PlayerListFrame = Instance.new("ScrollingFrame")
PlayerListFrame.Size = UDim2.new(0, 200, 0, 160)
PlayerListFrame.Position = UDim2.new(0.5, -100, 0.5, -80)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(25, 15, 40)
PlayerListFrame.Visible = false
PlayerListFrame.ZIndex = 10
PlayerListFrame.Parent = ScreenGui
Instance.new("UICorner", PlayerListFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIListLayout", PlayerListFrame).Padding = UDim.new(0, 4)

local function UpdatePlayerList()
    for _, v in pairs(PlayerListFrame:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    
    -- แสดงเครดิตผู้สร้างและตัวเราในลิสต์ด้วยตามขอ
    for _, plr in pairs(Players:GetPlayers()) do
        local pBtn = Instance.new("TextButton")
        pBtn.Size = UDim2.new(1, -8, 0, 30)
        pBtn.BackgroundColor3 = Color3.fromRGB(45, 25, 70)
        
        local labelText = plr.DisplayName .. " (@" .. plr.Name .. ")"
        if plr.Name == LocalPlayer.Name then
            labelText = "⭐ [คุณ] " .. labelText
        end
        pBtn.Text = labelText
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

RefreshBtn.MouseButton1Click:Connect(function()
    UpdatePlayerList() -- กดปุ่มรีเฟรชดึงรายชื่อแบบ Real-time ทันที
    PlayerListFrame.Visible = not PlayerListFrame.Visible
end)

-- Teleport Buttons
CreateButton(Page2, "🚀 วาร์ปไปหาผู้เล่น (TP)", function()
    if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = SelectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
        end
    end
end)

CreateToggle(Page2, "🧲 วาร์ปติดตัวตลอดเวลา (Loop TP)", function(state) LoopTPActive = state end)

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

local ESPFolder = Instance.new("Folder", ScreenGui)
ESPFolder.Name = "ESPFolder"

CreateToggle(Page2, "👁️‍🗨️ เปิด ESP แสดงชื่อผู้เล่นทุกคน", function(state)
    ESPActive = state
    if not state then ESPFolder:ClearAllChildren() end
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

--------------------------------------------------------------------------------
-- 6. CATEGORY 3: PROTECTION & ANTI-LAG (All Switches)
--------------------------------------------------------------------------------
-- Switch 1: Anti-Sit (กันนั่ง)
CreateToggle(Page3, "🪑 ป้องกันการนั่ง (Anti-Sit)", function(state)
    AntiSitActive = state
end)

RunService.Heartbeat:Connect(function()
    if AntiSitActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    end
end)

-- Switch 2: Anti-Fling (กันแรงเหวี่ยง)
CreateToggle(Page3, "🌀 ป้องกันแรงเหวี่ยง (Anti-Fling)", function(state)
    AntiFlingActive = state
end)

RunService.Heartbeat:Connect(function()
    if AntiFlingActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local root = LocalPlayer.Character.HumanoidRootPart
        if root.AssemblyLinearVelocity.Magnitude > 100 then
            root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end
end)

-- Switch 3: Anti-Lag (ลบแคชทุก 30 วิ)
CreateToggle(Page3, "🧹 ป้องกันแลก (Anti-Lag Cache)", function(state)
    AntiLagActive = state
end)

task.spawn(function()
    while true do
        task.wait(30)
        if AntiLagActive then
            pcall(function()
                for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                    if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") then
                        v.Enabled = false
                    end
                end
                gcinfo() -- Clear cache
            end)
        end
    end
end)

-- Switch 4: Super Protection (กันทุกอย่าง ดีดตกแมพ/ทะลุแต่ยังเดินได้ปกติ)
CreateToggle(Page3, "🛡️ Super Protection (ULTIMATE)", function(state)
    SuperProtActive = state
end)

RunService.Stepped:Connect(function()
    if SuperProtActive and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false -- ทะลุสิ่งกีดขวาง/ป้องกันโดนอัดกระแทกแต่ยังเดินขยับควบคุมได้ปกติ
            end
        end
    end
end)

print("HONKUKIXYZEIEI HUB Updated Successfully!")
