--[[
    ===================================================
    🔥 LAG SERVER GUI (KEY SYSTEM PROTECTED) 🔥
    Credit: HONKUKIXYZEIEI / kfc_punyai
    ===================================================
--]]

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer

-- Safely Fetch Remotes
local RE = ReplicatedStorage:WaitForChild("RE", 5)
local LagServerRemote = RE and RE:FindFirstChild("1NoMoto1rVehicle1s")

--------------------------------------------------------------------------------
-- 1. KEY SYSTEM GUI (หน้าต่างใส่คีย์)
--------------------------------------------------------------------------------
local KeyScreenGui = Instance.new("ScreenGui")
KeyScreenGui.Name = "HonKukiKeySystem"
KeyScreenGui.ResetOnSpawn = false
if gethui then KeyScreenGui.Parent = gethui() else KeyScreenGui.Parent = CoreGui end

local Blur = Instance.new("BlurEffect", Lighting)
Blur.Size = 15

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 420, 0, 260)
KeyFrame.Position = UDim2.new(0.5, -210, 0.5, -130)
KeyFrame.BackgroundColor3 = Color3.fromRGB(16, 10, 26)
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = KeyScreenGui

Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 16)
local KeyStroke = Instance.new("UIStroke", KeyFrame)
KeyStroke.Color = Color3.fromRGB(160, 80, 255)
KeyStroke.Thickness = 2

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "🔐 ENTER KEY - HONKUKI HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = Color3.fromRGB(220, 180, 255)
Title.BackgroundTransparency = 1
Title.Parent = KeyFrame

local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1, -40, 0, 42)
InputBox.Position = UDim2.new(0, 20, 0, 60)
InputBox.BackgroundColor3 = Color3.fromRGB(24, 14, 38)
InputBox.PlaceholderText = "กรอกคีย์ของคุณที่นี่ (HONKUKI-...)"
InputBox.Text = ""
InputBox.Font = Enum.Font.GothamMedium
InputBox.TextSize = 11
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.PlaceholderColor3 = Color3.fromRGB(130, 120, 150)
InputBox.Parent = KeyFrame
Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 8)

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(1, -40, 0, 38)
SubmitBtn.Position = UDim2.new(0, 20, 0, 115)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(130, 50, 220)
SubmitBtn.Text = "🚀 ตรวจสอบคีย์ & เข้าสู่สคริปต์"
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 12
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Parent = KeyFrame
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 8)

-- ปุ่มซื้อคีย์ / ติดต่อ Discord
local BuyKeyBtn = Instance.new("TextButton")
BuyKeyBtn.Size = UDim2.new(1, -40, 0, 38)
BuyKeyBtn.Position = UDim2.new(0, 20, 0, 165)
BuyKeyBtn.BackgroundColor3 = Color3.fromRGB(45, 25, 75)
BuyKeyBtn.Text = "🛒 ซื้อคีย์ / ติดต่อ Discord เจ้าของร้าน"
BuyKeyBtn.Font = Enum.Font.GothamBold
BuyKeyBtn.TextSize = 12
BuyKeyBtn.TextColor3 = Color3.fromRGB(120, 200, 255)
BuyKeyBtn.Parent = KeyFrame
Instance.new("UICorner", BuyKeyBtn).CornerRadius = UDim.new(0, 8)

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -40, 0, 25)
StatusText.Position = UDim2.new(0, 20, 0, 215)
StatusText.Text = "สถานะ: กรุณากรอกคีย์เพื่อใช้งาน (1 คีย์จำกัด 1 คน)"
StatusText.Font = Enum.Font.GothamMedium
StatusText.TextSize = 10
StatusText.TextColor3 = Color3.fromRGB(200, 150, 255)
StatusText.BackgroundTransparency = 1
StatusText.Parent = KeyFrame

-- ปุ่มกดเด้งไป Discord (ผ่าน User ID ของคุณ: 1261230159806332931)
BuyKeyBtn.MouseButton1Click:Connect(function()
    pcall(function()
        setclipboard("https://discord.com/users/1261230159806332931")
    end)
    StatusText.Text = "✅ คัดลอกลิงก์ Discord แล้ว! นำไปวางในเบราว์เซอร์เพื่อติดต่อได้เลย"
end)

--------------------------------------------------------------------------------
-- 2. ฟังก์ชันโหลดตัว Main Lag Server GUI หลัก (หลังจากผ่าน Key แล้ว)
--------------------------------------------------------------------------------
local function LoadMainLagGUI()
    KeyScreenGui:Destroy()
    if Blur then Blur:Destroy() end

    -- ตัวแปรสถานะหลักของ Lag Server
    local LagSkateActive = false
    local LagHoverboardActive = false
    local LagWheelChairActive = false
    local SkateAmount = 1000
    local LagDelay = 1.0

    local MainScreenGui = Instance.new("ScreenGui")
    MainScreenGui.Name = "HonKukiLagServerHub"
    MainScreenGui.ResetOnSpawn = false
    if gethui then MainScreenGui.Parent = gethui() else MainScreenGui.Parent = CoreGui end

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 480, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
    MainFrame.BackgroundColor3 = Color3.fromRGB(16, 10, 26)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = MainScreenGui

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Color3.fromRGB(170, 80, 255)
    MainStroke.Thickness = 2

    -- Header
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 50)
    Header.BackgroundColor3 = Color3.fromRGB(24, 14, 38)
    Header.Parent = MainFrame
    Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 16)

    local TitleText = Instance.new("TextLabel")
    TitleText.Size = UDim2.new(1, -20, 1, 0)
    TitleText.Position = UDim2.new(0, 15, 0, 0)
    TitleText.Text = "⚡ LAG SERVER ULTIMATE (KEY VERIFIED)"
    TitleText.Font = Enum.Font.GothamBold
    TitleText.TextSize = 13
    TitleText.TextColor3 = Color3.fromRGB(220, 180, 255)
    TitleText.BackgroundTransparency = 1
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Parent = Header

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -40, 0, 10)
    CloseBtn.Text = "✕"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 14
    CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 120)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Parent = Header

    CloseBtn.MouseButton1Click:Connect(function()
        MainScreenGui:Destroy()
    end)

    -- Container สำหรับปุ่มฟังก์ชัน
    local Content = Instance.new("ScrollingFrame")
    Content.Size = UDim2.new(1, -20, 1, -65)
    Content.Position = UDim2.new(0, 10, 0, 58)
    Content.BackgroundTransparency = 1
    Content.ScrollBarThickness = 3
    Content.Parent = MainFrame

    local UIList = Instance.new("UIListLayout", Content)
    UIList.Padding = UDim.new(0, 8)

    -- ฟังก์ชันสร้างปุ่ม Toggle ในหน้าหลัก
    local function CreateToggle(text, callback)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -6, 0, 38)
        Frame.BackgroundColor3 = Color3.fromRGB(40, 22, 65)
        Frame.Parent = Content
        Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(0.7, 0, 1, 0)
        Label.Position = UDim2.new(0, 10, 0, 0)
        Label.Text = text
        Label.Font = Enum.Font.GothamMedium
        Label.TextSize = 11
        Label.TextColor3 = Color3.fromRGB(240, 230, 255)
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.BackgroundTransparency = 1
        Label.Parent = Frame

        local SwitchBg = Instance.new("Frame")
        SwitchBg.Size = UDim2.new(0, 40, 0, 20)
        SwitchBg.Position = UDim2.new(1, -48, 0.5, -10)
        SwitchBg.BackgroundColor3 = Color3.fromRGB(25, 15, 35)
        SwitchBg.Parent = Frame
        Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(1, 0)

        local SwitchKnob = Instance.new("Frame")
        SwitchKnob.Size = UDim2.new(0, 16, 0, 16)
        SwitchKnob.Position = UDim2.new(0, 2, 0.5, -8)
        SwitchKnob.BackgroundColor3 = Color3.fromRGB(170, 170, 190)
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
                TweenService:Create(SwitchKnob, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8), BackgroundColor3 = Color3.fromRGB(220, 120, 255)}):Play()
                TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(130, 50, 210)}):Play()
            else
                TweenService:Create(SwitchKnob, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = Color3.fromRGB(170, 170, 190)}):Play()
                TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 15, 35)}):Play()
            end
            callback(toggled)
        end)
    end

    -- ฟังก์ชันสร้างช่องกรอกตัวเลข
    local function CreateInput(titleText, defaultVal, callback)
        local BoxFrame = Instance.new("Frame")
        BoxFrame.Size = UDim2.new(1, -6, 0, 40)
        BoxFrame.BackgroundColor3 = Color3.fromRGB(42, 22, 68)
        BoxFrame.Parent = Content
        Instance.new("UICorner", BoxFrame).CornerRadius = UDim.new(0, 8)

        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.Size = UDim2.new(0.6, 0, 1, 0)
        TitleLabel.Position = UDim2.new(0, 10, 0, 0)
        TitleLabel.Font = Enum.Font.GothamMedium
        TitleLabel.TextSize = 11
        TitleLabel.TextColor3 = Color3.fromRGB(240, 230, 255)
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        TitleLabel.BackgroundTransparency = 1
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
        TextBox.Parent = BoxFrame
        Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)

        TextBox.FocusLost:Connect(function()
            local num = tonumber(TextBox.Text)
            if num then callback(num) else TextBox.Text = tostring(defaultVal) end
        end)
    end

    -- สร้างปุ่มควบคุมฟีเจอร์ Lag Server ตามที่ขอ
    CreateToggle("🛹 เสก Skateboard (Real-Time)", function(state) LagSkateActive = state end)
    CreateToggle("🛹 เสก Hoverboard (Real-Time)", function(state) LagHoverboardActive = state end)
    CreateToggle("♿ เสก WheelChair (รถเข็น)", function(state) LagWheelChairActive = state end)
    
    CreateInput("💥 จำนวนครั้งยิงเซิฟแลค", 1000, function(val) SkateAmount = val end)
    CreateInput("⏱️ เวลาหน่วง (วินาที)", 1.0, function(val) LagDelay = val end)

    -- Loops ส่งคําสั่งยิง Remote
    task.spawn(function()
        while true do
            if LagSkateActive and LagServerRemote then
                for i = 1, SkateAmount do
                    if not LagSkateActive then break end
                    pcall(function() LagServerRemote:FireServer("SkateBoard", nil, nil) end)
                end
                task.wait(LagDelay)
            else
                task.wait(0.1)
            end
        end
    end)

    task.spawn(function()
        while true do
            if LagHoverboardActive and LagServerRemote then
                for i = 1, SkateAmount do
                    if not LagHoverboardActive then break end
                    pcall(function() LagServerRemote:FireServer("SegwaySmall", nil, nil) end)
                end
                task.wait(LagDelay)
            else
                task.wait(0.1)
            end
        end
    end)

    task.spawn(function()
        while true do
            if LagWheelChairActive and LagServerRemote then
                for i = 1, SkateAmount do
                    if not LagWheelChairActive then break end
                    pcall(function() LagServerRemote:FireServer("WheelChair", nil, nil) end)
                end
                task.wait(LagDelay)
            else
                task.wait(0.1)
            end
        end
    end)
end

--------------------------------------------------------------------------------
-- 3. ตรวจสอบคีย์เมื่อผู้เล่นกด Submit
--------------------------------------------------------------------------------
SubmitBtn.MouseButton1Click:Connect(function()
    local userKey = InputBox.Text
    
    -- เช็คระบบคีย์ส่วนกลางที่ Admin สร้างไว้
    if _G.GeneratedKeys and _G.GeneratedKeys[userKey] then
        local keyData = _G.GeneratedKeys[userKey]
        
        if keyData.Used then
            StatusText.Text = "❌ คีย์นี้ถูกใช้งานไปแล้ว (จำกัด 1 คนต่อ 1 คีย์)"
        elseif tick() > keyData.ExpireTime then
            StatusText.Text = "⏰ คีย์นี้หมดอายุการใช้งานแล้ว"
        else
            -- ใช้งานสำเร็จ ล็อกคีย์ทันทีไม่ให้คนอื่นใช้ซ้ำ
            keyData.Used = true
            keyData.UsedBy = LocalPlayer.Name
            
            StatusText.Text = "✅ คีย์ถูกต้อง! กำลังเข้าสู่ระบบ..."
            task.wait(0.8)
            LoadMainLagGUI()
        end
    else
        StatusText.Text = "❌ คีย์ไม่ถูกต้อง กรุณาตรวจสอบใหม่อีกครั้ง"
    end
end)
