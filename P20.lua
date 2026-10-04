--[[
    ===================================================
    🔥 SCRIPT GUI - HONKUKIXYZEIEI HUB (V2 ULTIMATE) 🔥
    Credit: HONKUKIXYZEIEI
    ===================================================
--]]

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")

local LocalPlayer = Players.LocalPlayer

-- Safely Fetch Remotes
local RE = ReplicatedStorage:WaitForChild("RE", 5)
local CarRemote = RE and RE:FindFirstChild("1Player1sCa1r")
local RPNameRemote = RE and RE:FindFirstChild("1RPNam1eColo1r")
local LagServerRemote = RE and RE:FindFirstChild("1NoMoto1rVehicle1s")

-- Variable States
local RainbowCarActive = false
local RainbowRPActive = false
local RainbowBioActive = false

local SelectedPlayer = nil
local LoopTPActive = false
local SpectateActive = false
local ESPActive = false

local AntiSitActive = false
local AntiFlingActive = false
local AntiLagActive = false
local SuperProtActive = false

local LagServerActive = false
local SkateAmount = 1000
local LagDelay = 1.0

local RainbowSpeed = 100

local function GetRainbowColor()
    local t = (tick() * (RainbowSpeed / 10)) % 1
    return Color3.fromHSV(math.abs(t), 1, 1)
end

--------------------------------------------------------------------------------
-- 1. ROOT GUI & BLUR
--------------------------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HONKUKIXYZ_GUI_V2"
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
BlurEffect.Name = "UIBlurEffect_V2"
BlurEffect.Size = 0
BlurEffect.Parent = Lighting

--------------------------------------------------------------------------------
-- 2. FLOATING TOGGLE BUTTON (CIRCLE BLACK THEME)
--------------------------------------------------------------------------------
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Position = UDim2.new(0.03, 0, 0.2, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 12, 22)
ToggleButton.TextColor3 = Color3.fromRGB(180, 120, 255)
ToggleButton.Text = "🔮"
ToggleButton.TextSize = 26
ToggleButton.Font = Enum.Font.Garamond
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Parent = ScreenGui

local UICornerBtn = Instance.new("UICorner", ToggleButton)
UICornerBtn.CornerRadius = UDim.new(1, 0)

local UIStrokeBtn = Instance.new("UIStroke", ToggleButton)
UIStrokeBtn.Color = Color3.fromRGB(110, 50, 180)
UIStrokeBtn.Thickness = 2.5

--------------------------------------------------------------------------------
-- 3. MAIN FRAME (RESPONSIVE & ROUNDED)
--------------------------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(16, 10, 26)
MainFrame.BackgroundTransparency = 0.1
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner", MainFrame)
UICornerMain.CornerRadius = UDim.new(0, 20)

local UIStrokeMain = Instance.new("UIStroke", MainFrame)
UIStrokeMain.Color = Color3.fromRGB(130, 60, 220)
UIStrokeMain.Thickness = 2

--------------------------------------------------------------------------------
-- 4. BACKGROUND SHOOTING STARS (PURPLE-WHITE GLOW)
--------------------------------------------------------------------------------
local StarCanvas = Instance.new("Frame")
StarCanvas.Name = "StarCanvas"
StarCanvas.Size = UDim2.new(1, 0, 1, 0)
StarCanvas.BackgroundTransparency = 1
StarCanvas.ClipsDescendants = true
StarCanvas.ZIndex = 1
StarCanvas.Parent = MainFrame

local function CreateShootingStar()
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, math.random(30, 70), 0, 2)
    star.Position = UDim2.new(math.random(-20, 100) / 100, 0, math.random(-20, 80) / 100, 0)
    star.Rotation = -35
    star.BackgroundColor3 = (math.random(1, 2) == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 140, 255)
    star.BackgroundTransparency = 0.2
    star.ZIndex = 1
    star.Parent = StarCanvas

    local corner = Instance.new("UICorner", star)
    corner.CornerRadius = UDim.new(1, 0)

    local targetPos = UDim2.new(star.Position.X.Scale + 0.4, 0, star.Position.Y.Scale + 0.4, 0)
    local duration = math.random(12, 22) / 10

    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local tweenPos = TweenService:Create(star, tweenInfo, {Position = targetPos, BackgroundTransparency = 1})
    
    tweenPos:Play()
    tweenPos.Completed:Connect(function()
        star:Destroy()
    end)
end

task.spawn(function()
    while true do
        task.wait(0.35)
        if MainFrame.Visible then
            CreateShootingStar()
        end
    end
end)

--------------------------------------------------------------------------------
-- 5. HEADER (CREDIT & DYNAMIC MAP INFO)
--------------------------------------------------------------------------------
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 55)
Header.BackgroundColor3 = Color3.fromRGB(24, 14, 38)
Header.BackgroundTransparency = 0.2
Header.ZIndex = 2
Header.Parent = MainFrame

local UICornerHeader = Instance.new("UICorner", Header)
UICornerHeader.CornerRadius = UDim.new(0, 20)

-- Credit Title Left
local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0, 180, 1, 0)
TitleText.Position = UDim2.new(0, 16, 0, 0)
TitleText.Text = "HONKUKIXYZEIEI HUB"
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 14
TitleText.TextColor3 = Color3.fromRGB(220, 180, 255)
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.BackgroundTransparency = 1
TitleText.ZIndex = 3
TitleText.Parent = Header

-- Map Info Container (Center)
local MapContainer = Instance.new("Frame")
MapContainer.Size = UDim2.new(0, 190, 0, 36)
MapContainer.Position = UDim2.new(0.5, -95, 0.5, -18)
MapContainer.BackgroundColor3 = Color3.fromRGB(14, 8, 22)
MapContainer.BackgroundTransparency = 0.3
MapContainer.ZIndex = 3
MapContainer.Parent = Header

local MapCorner = Instance.new("UICorner", MapContainer)
MapCorner.CornerRadius = UDim.new(0, 12)

local MapStroke = Instance.new("UIStroke", MapContainer)
MapStroke.Color = Color3.fromRGB(90, 45, 140)
MapStroke.Thickness = 1

local MapImage = Instance.new("ImageLabel")
MapImage.Size = UDim2.new(0, 26, 0, 26)
MapImage.Position = UDim2.new(0, 5, 0.5, -13)
MapImage.BackgroundTransparency = 1
MapImage.ZIndex = 4
MapImage.Parent = MapContainer
Instance.new("UICorner", MapImage).CornerRadius = UDim.new(0, 6)

local MapNameLabel = Instance.new("TextLabel")
MapNameLabel.Size = UDim2.new(1, -38, 1, 0)
MapNameLabel.Position = UDim2.new(0, 35, 0, 0)
MapNameLabel.Text = "Loading Map..."
MapNameLabel.Font = Enum.Font.GothamMedium
MapNameLabel.TextSize = 10
MapNameLabel.TextColor3 = Color3.fromRGB(230, 220, 255)
MapNameLabel.TextXAlignment = Enum.TextXAlignment.Left
MapNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
MapNameLabel.BackgroundTransparency = 1
MapNameLabel.ZIndex = 4
MapNameLabel.Parent = MapContainer

-- Fetch Map Data
task.spawn(function()
    local placeId = game.PlaceId
    local success, info = pcall(function()
        return MarketplaceService:GetProductInfo(placeId)
    end)
    if success and info then
        MapNameLabel.Text = info.Name
        MapImage.Image = "rbxassetid://" .. info.IconImageAssetId
    else
        MapNameLabel.Text = "Map ID: " .. tostring(placeId)
        MapImage.Image = "rbxassetid://0"
    end
end)

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -42, 0, 11)
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 120)
CloseBtn.BackgroundTransparency = 1
CloseBtn.ZIndex = 3
CloseBtn.Parent = Header

--------------------------------------------------------------------------------
-- 6. SIDEBAR NAVIGATION (LEFT CATEGORIES)
--------------------------------------------------------------------------------
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, -65)
Sidebar.Position = UDim2.new(0, 10, 0, 60)
Sidebar.BackgroundColor3 = Color3.fromRGB(22, 13, 35)
Sidebar.BackgroundTransparency = 0.3
Sidebar.ZIndex = 2
Sidebar.Parent = MainFrame

local UICornerSidebar = Instance.new("UICorner", Sidebar)
UICornerSidebar.CornerRadius = UDim.new(0, 14)

local SidebarLayout = Instance.new("UIListLayout", Sidebar)
SidebarLayout.Padding = UDim.new(0, 6)
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder

local SidebarPadding = Instance.new("UIPadding", Sidebar)
SidebarPadding.PaddingTop = UDim.new(0, 8)

-- Tab Buttons
local function CreateTabBtn(text, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 114, 0, 38)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.TextColor3 = (order == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(170, 160, 190)
    btn.BackgroundColor3 = (order == 1) and Color3.fromRGB(120, 50, 200) or Color3.fromRGB(32, 18, 50)
    btn.LayoutOrder = order
    btn.ZIndex = 3
    btn.Parent = Sidebar
    
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    return btn
end

local Tab1Btn = CreateTabBtn("🚗 Vehicle", 1)
local Tab2Btn = CreateTabBtn("👤 Player", 2)
local Tab3Btn = CreateTabBtn("🛡️ Protect", 3)
local Tab4Btn = CreateTabBtn("⚡ Lag Server", 4)

--------------------------------------------------------------------------------
-- 7. PAGES CONTAINER (RIGHT CONTENT)
--------------------------------------------------------------------------------
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -160, 1, -65)
ContentArea.Position = UDim2.new(0, 150, 0, 60)
ContentArea.BackgroundTransparency = 1
ContentArea.ZIndex = 2
ContentArea.Parent = MainFrame

local function CreatePage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(150, 70, 230)
    page.ZIndex = 3
    page.Parent = ContentArea
    
    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    
    return page
end

local Page1 = CreatePage()
local Page2 = CreatePage()
local Page3 = CreatePage()
local Page4 = CreatePage()

Page2.Visible = false
Page3.Visible = false
Page4.Visible = false

--------------------------------------------------------------------------------
-- 8. HELPER UI CREATORS (MODERNIZED)
--------------------------------------------------------------------------------
local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -8, 0, 38)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 22, 65)
    Btn.Text = text
    Btn.Font = Enum.Font.GothamMedium
    Btn.TextSize = 12
    Btn.TextColor3 = Color3.fromRGB(240, 230, 255)
    Btn.ZIndex = 4
    Btn.Parent = parent

    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 10)
    local UIStroke = Instance.new("UIStroke", Btn)
    UIStroke.Color = Color3.fromRGB(90, 45, 150)
    UIStroke.Thickness = 1

    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

local function CreateToggle(parent, text, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -8, 0, 38)
    Frame.BackgroundColor3 = Color3.fromRGB(40, 22, 65)
    Frame.ZIndex = 4
    Frame.Parent = parent

    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = text
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 11
    Label.TextColor3 = Color3.fromRGB(240, 230, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.ZIndex = 5
    Label.Parent = Frame

    local SwitchBg = Instance.new("Frame")
    SwitchBg.Size = UDim2.new(0, 40, 0, 20)
    SwitchBg.Position = UDim2.new(1, -48, 0.5, -10)
    SwitchBg.BackgroundColor3 = Color3.fromRGB(25, 15, 35)
    SwitchBg.ZIndex = 5
    SwitchBg.Parent = Frame

    Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(1, 0)

    local SwitchKnob = Instance.new("Frame")
    SwitchKnob.Size = UDim2.new(0, 16, 0, 16)
    SwitchKnob.Position = UDim2.new(0, 2, 0.5, -8)
    SwitchKnob.BackgroundColor3 = Color3.fromRGB(170, 170, 190)
    SwitchKnob.ZIndex = 6
    SwitchKnob.Parent = SwitchBg

    Instance.new("UICorner", SwitchKnob).CornerRadius = UDim.new(1, 0)

    local ClickBtn = Instance.new("TextButton")
    ClickBtn.Size = UDim2.new(1, 0, 1, 0)
    ClickBtn.BackgroundTransparency = 1
    ClickBtn.Text = ""
    ClickBtn.ZIndex = 7
    ClickBtn.Parent = Frame

    local toggled = false
    ClickBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            TweenService:Create(SwitchKnob, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8), BackgroundColor3 = Color3.fromRGB(200, 100, 255)}):Play()
            TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 45, 160)}):Play()
        else
            TweenService:Create(SwitchKnob, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = Color3.fromRGB(170, 170, 190)}):Play()
            TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 15, 35)}):Play()
        end
        callback(toggled)
    end)
    return Frame
end

local function CreateSlider(parent, titleText, minVal, maxVal, defaultVal, isFloat, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, -8, 0, 52)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 22, 65)
    SliderFrame.ZIndex = 4
    SliderFrame.Parent = parent
    Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 10)

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -20, 0, 20)
    TitleLabel.Position = UDim2.new(0, 10, 0, 4)
    TitleLabel.Font = Enum.Font.GothamMedium
    TitleLabel.TextSize = 11
    TitleLabel.TextColor3 = Color3.fromRGB(240, 230, 255)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.ZIndex = 5
    TitleLabel.Parent = SliderFrame

    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(1, -20, 0, 8)
    SliderBg.Position = UDim2.new(0, 10, 0, 30)
    SliderBg.BackgroundColor3 = Color3.fromRGB(22, 12, 32)
    SliderBg.ZIndex = 5
    SliderBg.Parent = SliderFrame
    Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(1, 0)

    local SliderFill = Instance.new("Frame")
    local startPos = math.clamp((defaultVal - minVal) / (maxVal - minVal), 0, 1)
    SliderFill.Size = UDim2.new(startPos, 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(170, 70, 255)
    SliderFill.ZIndex = 6
    SliderFill.Parent = SliderBg
    Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)

    local function UpdateText(val)
        if isFloat then
            TitleLabel.Text = string.format("%s: %.1f", titleText, val)
        else
            TitleLabel.Text = string.format("%s: %d", titleText, math.floor(val))
        end
    end
    UpdateText(defaultVal)

    local dragging = false
    local function ProcessInput(input)
        local pos = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(pos, 0, 1, 0)
        local currentVal = minVal + (pos * (maxVal - minVal))
        if not isFloat then currentVal = math.floor(currentVal) end
        UpdateText(currentVal)
        callback(currentVal)
    end

    SliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            ProcessInput(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            ProcessInput(input)
        end
    end)

    return SliderFrame
end

--------------------------------------------------------------------------------
-- 9. SMOOTH UI TOGGLE & TAB SWITCHING
--------------------------------------------------------------------------------
local isOpen = true
local originalSize = UDim2.new(0, 520, 0, 360)

local function ToggleGUI()
    isOpen = not isOpen
    if isOpen then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = originalSize}):Play()
        TweenService:Create(BlurEffect, TweenInfo.new(0.4), {Size = 15}):Play()
    else
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 520, 0, 0)})
        tween:Play()
        TweenService:Create(BlurEffect, TweenInfo.new(0.3), {Size = 0}):Play()
        tween.Completed:Connect(function()
            if not isOpen then MainFrame.Visible = false end
        end)
    end
end

ToggleButton.MouseButton1Click:Connect(ToggleGUI)
CloseBtn.MouseButton1Click:Connect(ToggleGUI)

local function SwitchTab(activeTab)
    Page1.Visible = (activeTab == 1)
    Page2.Visible = (activeTab == 2)
    Page3.Visible = (activeTab == 3)
    Page4.Visible = (activeTab == 4)

    local tabs = {Tab1Btn, Tab2Btn, Tab3Btn, Tab4Btn}
    for i, tab in ipairs(tabs) do
        if i == activeTab then
            tab.BackgroundColor3 = Color3.fromRGB(120, 50, 200)
            tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            tab.BackgroundColor3 = Color3.fromRGB(32, 18, 50)
            tab.TextColor3 = Color3.fromRGB(170, 160, 190)
        end
    end
end

Tab1Btn.MouseButton1Click:Connect(function() SwitchTab(1) end)
Tab2Btn.MouseButton1Click:Connect(function() SwitchTab(2) end)
Tab3Btn.MouseButton1Click:Connect(function() SwitchTab(3) end)
Tab4Btn.MouseButton1Click:Connect(function() SwitchTab(4) end)

--------------------------------------------------------------------------------
-- 10. CATEGORY 1: VEHICLE & BIO
--------------------------------------------------------------------------------
CreateToggle(Page1, "🏎 สีรถเรนโบว์ (Speed 100)", function(state) RainbowCarActive = state end)
CreateToggle(Page1, "🏷️ เปลี่ยนสีชื่อ RP เรนโบว์", function(state) RainbowRPActive = state end)
CreateToggle(Page1, "📝 เปลี่ยนสีชื่อ Bio เรนโบว์", function(state) RainbowBioActive = state end)

task.spawn(function()
    while true do
        task.wait(0.01)
        local color = GetRainbowColor()
        if RainbowCarActive and CarRemote then pcall(function() CarRemote:FireServer("NoMotorColor", color) end) end
        if RainbowRPActive and RPNameRemote then pcall(function() RPNameRemote:FireServer("PickingRPNameColor", color) end) end
        if RainbowBioActive and RPNameRemote then pcall(function() RPNameRemote:FireServer("PickingRPBioColor", color) end) end
    end
end)

--------------------------------------------------------------------------------
-- 11. CATEGORY 2: PLAYER FEATURES
--------------------------------------------------------------------------------
CreateSlider(Page2, "⚡ ความเร็วผู้เล่น", 16, 1000, 16, false, function(val)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

local SelectFrame = Instance.new("Frame")
SelectFrame.Size = UDim2.new(1, -8, 0, 45)
SelectFrame.BackgroundColor3 = Color3.fromRGB(40, 22, 65)
SelectFrame.ZIndex = 4
SelectFrame.Parent = Page2
Instance.new("UICorner", SelectFrame).CornerRadius = UDim.new(0, 10)

local SelectedText = Instance.new("TextLabel")
SelectedText.Size = UDim2.new(1, -110, 1, 0)
SelectedText.Position = UDim2.new(0, 10, 0, 0)
SelectedText.Text = "เลือก: -"
SelectedText.Font = Enum.Font.GothamMedium
SelectedText.TextSize = 11
SelectedText.TextColor3 = Color3.fromRGB(220, 220, 240)
SelectedText.TextXAlignment = Enum.TextXAlignment.Left
SelectedText.BackgroundTransparency = 1
SelectedText.ZIndex = 5
SelectedText.Parent = SelectFrame

local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Size = UDim2.new(0, 90, 0, 28)
RefreshBtn.Position = UDim2.new(1, -95, 0.5, -14)
RefreshBtn.BackgroundColor3 = Color3.fromRGB(90, 40, 150)
RefreshBtn.Text = "🔄 Refresh"
RefreshBtn.Font = Enum.Font.GothamBold
RefreshBtn.TextSize = 10
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.ZIndex = 5
RefreshBtn.Parent = SelectFrame
Instance.new("UICorner", RefreshBtn).CornerRadius = UDim.new(0, 8)

local PlayerListFrame = Instance.new("ScrollingFrame")
PlayerListFrame.Size = UDim2.new(0, 220, 0, 160)
PlayerListFrame.Position = UDim2.new(0.5, -110, 0.5, -80)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(20, 12, 32)
PlayerListFrame.Visible = false
PlayerListFrame.ZIndex = 20
PlayerListFrame.Parent = ScreenGui
Instance.new("UICorner", PlayerListFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIListLayout", PlayerListFrame).Padding = UDim.new(0, 4)

local function UpdatePlayerList()
    for _, v in pairs(PlayerListFrame:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    
    for _, plr in pairs(Players:GetPlayers()) do
        local pBtn = Instance.new("TextButton")
        pBtn.Size = UDim2.new(1, -8, 0, 28)
        pBtn.BackgroundColor3 = Color3.fromRGB(40, 22, 65)
        
        local labelText = plr.DisplayName .. " (@" .. plr.Name .. ")"
        if plr.Name == LocalPlayer.Name then labelText = "⭐ [คุณ] " .. labelText end
        pBtn.Text = labelText
        pBtn.Font = Enum.Font.GothamMedium
        pBtn.TextSize = 10
        pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        pBtn.ZIndex = 21
        pBtn.Parent = PlayerListFrame

        pBtn.MouseButton1Click:Connect(function()
            SelectedPlayer = plr
            SelectedText.Text = "เลือก: " .. plr.DisplayName
            PlayerListFrame.Visible = false
        end)
    end
end

RefreshBtn.MouseButton1Click:Connect(function()
    UpdatePlayerList()
    PlayerListFrame.Visible = not PlayerListFrame.Visible
end)

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
                    lbl.TextSize = 11
                    lbl.TextColor3 = Color3.fromRGB(200, 120, 255)
                    lbl.TextStrokeTransparency = 0.2
                    lbl.Parent = bgGui
                end
            end
        end
    end
end)

--------------------------------------------------------------------------------
-- 12. CATEGORY 3: PROTECTION & ANTI-LAG
--------------------------------------------------------------------------------
CreateToggle(Page3, "🪑 ป้องกันการนั่ง (Anti-Sit)", function(state) AntiSitActive = state end)

RunService.Heartbeat:Connect(function()
    if AntiSitActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    end
end)

CreateToggle(Page3, "🌀 ป้องกันแรงเหวี่ยง (Anti-Fling)", function(state) AntiFlingActive = state end)

RunService.Heartbeat:Connect(function()
    if AntiFlingActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local root = LocalPlayer.Character.HumanoidRootPart
        if root.AssemblyLinearVelocity.Magnitude > 100 then
            root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end
end)

CreateToggle(Page3, "🧹 ป้องกันแลก (Anti-Lag Cache)", function(state) AntiLagActive = state end)

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
                gcinfo()
            end)
        end
    end
end)

CreateToggle(Page3, "🛡️ Super Protection (ULTIMATE)", function(state) SuperProtActive = state end)

RunService.Stepped:Connect(function()
    if SuperProtActive and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

--------------------------------------------------------------------------------
-- 13. CATEGORY 4: REAL-TIME SERVER LAG
--------------------------------------------------------------------------------
CreateSlider(Page4, "🛹 จำนวนเสกสเก็ตบอร์ด", 1, 100000000, 1000, false, function(val) SkateAmount = val end)
CreateSlider(Page4, "⏱️ เวลาหน่วง (วินาที)", 0.00000000001, 3.0, 1.0, true, function(val) LagDelay = val end)

CreateToggle(Page4, "💥 เปิดสวิตช์ Lag Server (Real-Time)", function(state) LagServerActive = state end)

task.spawn(function()
    while true do
        if LagServerActive and LagServerRemote then
            local currentAmount = SkateAmount
            for i = 1, currentAmount do
                if not LagServerActive then break end
                pcall(function()
                    LagServerRemote:FireServer("SkateBoard", nil, nil)
                end)
            end
            task.wait(LagDelay)
        else
            task.wait(0.1)
        end
    end
end)

print("HONKUKIXYZEIEI HUB V2 - Loaded Successfully!")
