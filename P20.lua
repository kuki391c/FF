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

-- Lag Server Vehicles Active States
local LagSkateActive = false
local LagHoverboardActive = false
local LagWheelChairActive = false

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
-- 2. FLOATING TOGGLE BUTTON (3D GLOW THEME)
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
UIStrokeBtn.Color = Color3.fromRGB(160, 80, 255)
UIStrokeBtn.Thickness = 3

--------------------------------------------------------------------------------
-- 3. MAIN FRAME (3D SHADOW & BORDER)
--------------------------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(16, 10, 26)
MainFrame.BackgroundTransparency = 0.05
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner", MainFrame)
UICornerMain.CornerRadius = UDim.new(0, 20)

local UIStrokeMain = Instance.new("UIStroke", MainFrame)
UIStrokeMain.Color = Color3.fromRGB(150, 70, 255)
UIStrokeMain.Thickness = 2.5

local MainShadow = Instance.new("UIStroke", MainFrame)
MainShadow.Color = Color3.fromRGB(80, 20, 140)
MainShadow.Thickness = 5
MainShadow.Transparency = 0.5

--------------------------------------------------------------------------------
-- 4. BACKGROUND SHOOTING STARS
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

    Instance.new("UICorner", star).CornerRadius = UDim.new(1, 0)

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
        task.wait(0.5)
        if MainFrame.Visible then
            CreateShootingStar()
        end
    end
end)

--------------------------------------------------------------------------------
-- 5. HEADER
--------------------------------------------------------------------------------
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 55)
Header.BackgroundColor3 = Color3.fromRGB(24, 14, 38)
Header.BackgroundTransparency = 0.1
Header.ZIndex = 2
Header.Parent = MainFrame

Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 20)

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

local MapContainer = Instance.new("Frame")
MapContainer.Size = UDim2.new(0, 190, 0, 36)
MapContainer.Position = UDim2.new(0.5, -95, 0.5, -18)
MapContainer.BackgroundColor3 = Color3.fromRGB(14, 8, 22)
MapContainer.BackgroundTransparency = 0.3
MapContainer.ZIndex = 3
MapContainer.Parent = Header

Instance.new("UICorner", MapContainer).CornerRadius = UDim.new(0, 12)
local MapStroke = Instance.new("UIStroke", MapContainer)
MapStroke.Color = Color3.fromRGB(110, 50, 170)
MapStroke.Thickness = 1.5

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
-- 6. SIDEBAR NAVIGATION
--------------------------------------------------------------------------------
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, -65)
Sidebar.Position = UDim2.new(0, 10, 0, 60)
Sidebar.BackgroundColor3 = Color3.fromRGB(22, 13, 35)
Sidebar.BackgroundTransparency = 0.3
Sidebar.ZIndex = 2
Sidebar.Parent = MainFrame

Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 14)

local SidebarLayout = Instance.new("UIListLayout", Sidebar)
SidebarLayout.Padding = UDim.new(0, 6)
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder

local SidebarPadding = Instance.new("UIPadding", Sidebar)
SidebarPadding.PaddingTop = UDim.new(0, 8)

local function CreateTabBtn(text, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 114, 0, 38)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.TextColor3 = (order == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(170, 160, 190)
    btn.BackgroundColor3 = (order == 1) and Color3.fromRGB(130, 50, 220) or Color3.fromRGB(32, 18, 50)
    btn.LayoutOrder = order
    btn.ZIndex = 3
    btn.Parent = Sidebar
    
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(170, 90, 255)
    stroke.Thickness = (order == 1) and 1.5 or 0.8
    return btn
end

local Tab1Btn = CreateTabBtn("🚗 Vehicle", 1)
local Tab2Btn = CreateTabBtn("👤 Player", 2)
local Tab3Btn = CreateTabBtn("🛡 Protect", 3)
local Tab4Btn = CreateTabBtn("⚡ Lag Server", 4)

--------------------------------------------------------------------------------
-- 7. PAGES CONTAINER
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
    page.ScrollBarImageColor3 = Color3.fromRGB(170, 80, 255)
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
-- 8. 3D UI CREATORS (GLOW & MODERN)
--------------------------------------------------------------------------------
local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -8, 0, 38)
    Btn.BackgroundColor3 = Color3.fromRGB(45, 24, 75)
    Btn.Text = text
    Btn.Font = Enum.Font.GothamMedium
    Btn.TextSize = 12
    Btn.TextColor3 = Color3.fromRGB(240, 230, 255)
    Btn.ZIndex = 4
    Btn.Parent = parent

    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 10)
    local UIStroke = Instance.new("UIStroke", Btn)
    UIStroke.Color = Color3.fromRGB(150, 70, 240)
    UIStroke.Thickness = 1.5

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
    local Stroke = Instance.new("UIStroke", Frame)
    Stroke.Color = Color3.fromRGB(110, 50, 190)
    Stroke.Thickness = 1

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
            TweenService:Create(SwitchKnob, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8), BackgroundColor3 = Color3.fromRGB(220, 120, 255)}):Play()
            TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(130, 50, 210)}):Play()
        else
            TweenService:Create(SwitchKnob, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = Color3.fromRGB(170, 170, 190)}):Play()
            TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 15, 35)}):Play()
        end
        callback(toggled)
    end)
    return Frame
end

local function CreateTextBoxInput(parent, titleText, defaultVal, callback)
    local BoxFrame = Instance.new("Frame")
    BoxFrame.Size = UDim2.new(1, -8, 0, 42)
    BoxFrame.BackgroundColor3 = Color3.fromRGB(42, 22, 68)
    BoxFrame.ZIndex = 4
    BoxFrame.Parent = parent
    
    Instance.new("UICorner", BoxFrame).CornerRadius = UDim.new(0, 10)
    local Stroke = Instance.new("UIStroke", BoxFrame)
    Stroke.Color = Color3.fromRGB(150, 70, 240)
    Stroke.Thickness = 1.2

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0.6, 0, 1, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.Font = Enum.Font.GothamMedium
    TitleLabel.TextSize = 11
    TitleLabel.TextColor3 = Color3.fromRGB(240, 230, 255)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.ZIndex = 5
    TitleLabel.Text = titleText
    TitleLabel.Parent = BoxFrame

    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(0, 90, 0, 26)
    TextBox.Position = UDim2.new(1, -98, 0.5, -13)
    TextBox.BackgroundColor3 = Color3.fromRGB(20, 10, 32)
    TextBox.Text = tostring(defaultVal)
    TextBox.Font = Enum.Font.GothamBold
    TextBox.TextSize = 11
    TextBox.TextColor3 = Color3.fromRGB(255, 180, 255)
    TextBox.ClearTextOnFocus = false
    TextBox.ZIndex = 5
    TextBox.Parent = BoxFrame

    Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)
    local BoxStroke = Instance.new("UIStroke", TextBox)
    BoxStroke.Color = Color3.fromRGB(180, 90, 255)
    BoxStroke.Thickness = 1.5

    TextBox.FocusLost:Connect(function(enterPressed)
        local num = tonumber(TextBox.Text)
        if num then
            callback(num)
        else
            TextBox.Text = tostring(defaultVal)
        end
    end)

    return BoxFrame
end

--------------------------------------------------------------------------------
-- 9. UI TOGGLE & TAB SWITCHING LOGIC
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
        local stroke = tab:FindFirstChildOfClass("UIStroke")
        if i == activeTab then
            tab.BackgroundColor3 = Color3.fromRGB(130, 50, 220)
            tab.TextColor3 = Color3.fromRGB(255, 255, 255)
            if stroke then stroke.Thickness = 1.5 end
        else
            tab.BackgroundColor3 = Color3.fromRGB(32, 18, 50)
            tab.TextColor3 = Color3.fromRGB(170, 160, 190)
            if stroke then stroke.Thickness = 0.8 end
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
        task.wait(0.05)
        local color = GetRainbowColor()
        if RainbowCarActive and CarRemote then pcall(function() CarRemote:FireServer("NoMotorColor", color) end) end
        if RainbowRPActive and RPNameRemote then pcall(function() RPNameRemote:FireServer("PickingRPNameColor", color) end) end
        if RainbowBioActive and RPNameRemote then pcall(function() RPNameRemote:FireServer("PickingRPBioColor", color) end) end
    end
end)

--------------------------------------------------------------------------------
-- 11. CATEGORY 2: PLAYER FEATURES
--------------------------------------------------------------------------------
CreateTextBoxInput(Page2, "⚡ ความเร็วผู้เล่น (WalkSpeed)", 16, function(val)
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
Instance.new("UIStroke", SelectFrame).Color = Color3.fromRGB(120, 50, 200)

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

local SelectPlayerBtn = Instance.new("TextButton")
SelectPlayerBtn.Size = UDim2.new(0, 55, 0, 28)
SelectPlayerBtn.Position = UDim2.new(1, -100, 0.5, -14)
SelectPlayerBtn.BackgroundColor3 = Color3.fromRGB(100, 45, 170)
SelectPlayerBtn.Text = "👤 เลือก"
SelectPlayerBtn.Font = Enum.Font.GothamBold
SelectPlayerBtn.TextSize = 10
SelectPlayerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectPlayerBtn.ZIndex = 5
SelectPlayerBtn.Parent = SelectFrame
Instance.new("UICorner", SelectPlayerBtn).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", SelectPlayerBtn).Color = Color3.fromRGB(180, 100, 255)

local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Size = UDim2.new(0, 36, 0, 28)
RefreshBtn.Position = UDim2.new(1, -41, 0.5, -14)
RefreshBtn.BackgroundColor3 = Color3.fromRGB(60, 30, 100)
RefreshBtn.Text = "🔄"
RefreshBtn.Font = Enum.Font.GothamBold
RefreshBtn.TextSize = 12
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.ZIndex = 5
RefreshBtn.Parent = SelectFrame
Instance.new("UICorner", RefreshBtn).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", RefreshBtn).Color = Color3.fromRGB(150, 80, 220)

local PlayerListFrame = Instance.new("ScrollingFrame")
PlayerListFrame.Size = UDim2.new(0, 240, 0, 180)
PlayerListFrame.Position = UDim2.new(0.5, -120, 0.5, -90)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(18, 10, 30)
PlayerListFrame.BorderSizePixel = 0
PlayerListFrame.Visible = false
PlayerListFrame.ZIndex = 50
PlayerListFrame.ScrollBarThickness = 4
PlayerListFrame.ScrollBarImageColor3 = Color3.fromRGB(180, 100, 255)
PlayerListFrame.Parent = ScreenGui

Instance.new("UICorner", PlayerListFrame).CornerRadius = UDim.new(0, 12)
local ListStroke = Instance.new("UIStroke", PlayerListFrame)
ListStroke.Color = Color3.fromRGB(170, 80, 255)
ListStroke.Thickness = 2

local ListLayout = Instance.new("UIListLayout", PlayerListFrame)
ListLayout.Padding = UDim.new(0, 5)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local ListPadding = Instance.new("UIPadding", PlayerListFrame)
ListPadding.PaddingTop = UDim.new(0, 6)
ListPadding.PaddingBottom = UDim.new(0, 6)

local function UpdatePlayerList()
    for _, v in pairs(PlayerListFrame:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    
    for _, plr in pairs(Players:GetPlayers()) do
        local pBtn = Instance.new("TextButton")
        pBtn.Size = UDim2.new(1, -12, 0, 32)
        pBtn.BackgroundColor3 = Color3.fromRGB(35, 18, 55)
        
        local labelText = plr.DisplayName .. " (@" .. plr.Name .. ")"
        if plr.Name == LocalPlayer.Name then labelText = "⭐ [คุณ] " .. labelText end
        pBtn.Text = labelText
        pBtn.Font = Enum.Font.GothamMedium
        pBtn.TextSize = 10
        pBtn.TextColor3 = Color3.fromRGB(240, 230, 255)
        pBtn.ZIndex = 51
        pBtn.Parent = PlayerListFrame

        Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 8)

        pBtn.MouseButton1Click:Connect(function()
            SelectedPlayer = plr
            SelectedText.Text = "เลือก: " .. plr.DisplayName
            PlayerListFrame.Visible = false
        end)
    end
end

SelectPlayerBtn.MouseButton1Click:Connect(function()
    UpdatePlayerList()
    PlayerListFrame.Visible = not PlayerListFrame.Visible
end)

RefreshBtn.MouseButton1Click:Connect(function()
    UpdatePlayerList()
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
        task.wait(0.15)
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
-- 12. CATEGORY 3: PROTECTION & ANTI-LAG (ULTIMATE ANTI-FLING & ANTI-SIT)
--------------------------------------------------------------------------------

-- 1. ป้องกันการนั่งแบบเด็ดขาด (บังคับลุกทันทีและบล็อกสถานะ Seated)
CreateToggle(Page3, "🪑 ป้องกันการนั่ง (Anti-Sit 100%)", function(state) 
    AntiSitActive = state 
end)

RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local humanoid = LocalPlayer.Character.Humanoid
        if AntiSitActive then
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            if humanoid:GetState() == Enum.HumanoidStateType.Seated then
                humanoid.Sit = false
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
        else
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        end
    end
end)

-- 2. ป้องกันแรงเหวี่ยงมหาศาลขั้นเทพ (กันประตู, เรือ, รถ, หรือทุกวัตถุกระเด็นใส่ 100%)
CreateToggle(Page3, "🌀 ป้องกันแรงเหวี่ยงทุกสิ่ง (Anti-Fling God)", function(state) 
    AntiFlingActive = state 
end)

RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character then
        local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if root then
            if AntiFlingActive then
                -- ล็อกความเร็วไม่ให้พุ่งปลิว
                if root.AssemblyLinearVelocity.Magnitude > 50 or root.AssemblyAngularVelocity.Magnitude > 50 then
                    root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                end
                -- ปิดการชนกับวัตถุรอบตัว (ประตู, ยานพาหนะ, วัตถุของคนอื่น) เพื่อไม่ให้โดนอัดกระแทก
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = false
                    end
                end
                -- ป้องกันไม่ให้โดนจับนั่งหรือโดนฟลิงค์ผ่านเครื่องมือ
                if humanoid then
                    humanoid.PlatformStand = false
                end
            end
        end
    end
end)

CreateToggle(Page3, "🧹 ป้องกันแลก (Anti-Lag Cache)", function(state) AntiLagActive = state end)

--------------------------------------------------------------------------------
-- 3. ปุ่มกดรันสคริปต์ FREEZE MOBILE (เพิ่มในหมวดหมู่ที่ 3)
--------------------------------------------------------------------------------
CreateButton(Page3, "🧊 รันสคริปต์ Freeze (ปุ่มลอยจอ)", function()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")

    -- ลบ GUI เก่าทิ้งก่อน (ถ้ามี เพื่อไม่ให้ซ้อนกันเวลารันซ้ำ)
    if playerGui:FindFirstChild("FreezeGuiMobile") then
        playerGui.FreezeGuiMobile:Destroy()
    end

    -- สร้าง ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FreezeGuiMobile"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    -- สร้างปุ่มวงกลมหลัก
    local freezeBtn = Instance.new("TextButton")
    freezeBtn.Size = UDim2.new(0, 70, 0, 70)
    freezeBtn.Position = UDim2.new(0.1, 0, 0.5, -35)
    freezeBtn.Text = "FREEZE"
    freezeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    freezeBtn.TextScaled = true
    freezeBtn.Font = Enum.Font.GothamBold
    freezeBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    freezeBtn.BorderSizePixel = 0
    freezeBtn.Parent = screenGui

    -- ทำให้ปุ่มเป็นวงกลม
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = freezeBtn

    -- เพิ่มเงาให้ปุ่มดูสวยงาม (Stroke)
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 3
    uiStroke.Color = Color3.fromRGB(255, 255, 255)
    uiStroke.Parent = freezeBtn

    -- ระบบทำให้ปุ่มลากเลื่อนได้อิสระ (รองรับทั้งมือถือและเมาส์)
    local dragging, dragInput, dragStart, startPos

    freezeBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = freezeBtn.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    freezeBtn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            freezeBtn.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- ระบบเปิด-ปิดการแช่แข็งตัวละคร
    local isFrozen = false

    freezeBtn.MouseButton1Click:Connect(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        
        if not humanoid or not rootPart then return end
        
        isFrozen = not isFrozen
        
        if isFrozen then
            -- แช่แข็ง
            rootPart.Anchored = true
            humanoid.WalkSpeed = 0
            humanoid.JumpPower = 0
            humanoid.JumpHeight = 0
            
            freezeBtn.Text = "UN"
            freezeBtn.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
            uiStroke.Color = Color3.fromRGB(200, 0, 0)
        else
            -- คืนค่าปกติ
            rootPart.Anchored = false
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
            humanoid.JumpHeight = 7.2
            
            freezeBtn.Text = "FREEZE"
            freezeBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            uiStroke.Color = Color3.fromRGB(255, 255, 255)
        end
    end)
end)

--------------------------------------------------------------------------------
-- 13. CATEGORY 4: REAL-TIME SERVER LAG (3 VEHICLES + REALTIME INPUTS)
--------------------------------------------------------------------------------
CreateToggle(Page4, "🛹 เสก Skateboard (Real-Time)", function(state)
    LagSkateActive = state
end)

CreateToggle(Page4, "🛹 เสก Hoverboard (Real-Time)", function(state)
    LagHoverboardActive = state
end)

CreateToggle(Page4, "♿ เสก WheelChair (Real-Time)", function(state)
    LagWheelChairActive = state
end)

CreateTextBoxInput(Page4, "💥 จำนวนครั้งยิงเซิฟแลค", 1000, function(val)
    SkateAmount = val
end)

CreateTextBoxInput(Page4, "⏱️ เวลาหน่วง (วินาที)", 1.0, function(val)
    LagDelay = val
end)

-- Loop ยิง Skateboard
task.spawn(function()
    while true do
        if LagSkateActive and LagServerRemote then
            local currentAmount = SkateAmount
            for i = 1, currentAmount do
                if not LagSkateActive then break end
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

-- Loop ยิง Hoverboard
task.spawn(function()
    while true do
        if LagHoverboardActive and LagServerRemote then
            local currentAmount = SkateAmount
            for i = 1, currentAmount do
                if not LagHoverboardActive then break end
                pcall(function()
                    LagServerRemote:FireServer("SegwaySmall", nil, nil)
                end)
            end
            task.wait(LagDelay)
        else
            task.wait(0.1)
        end
    end
end)

-- Loop ยิง WheelChair
task.spawn(function()
    while true do
        if LagWheelChairActive and LagServerRemote then
            local currentAmount = SkateAmount
            for i = 1, currentAmount do
                if not LagWheelChairActive then break end
                pcall(function()
                    LagServerRemote:FireServer("WheelChair", nil, nil)
                end)
            end
            task.wait(LagDelay)
        else
            task.wait(0.1)
        end
    end
end)

print("HONKUKIXYZEIEI HUB V2 ULTIMATE - Loaded Successfully!")
