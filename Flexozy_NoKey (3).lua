-- ============================================================
-- Crack by HONKUKI
-- HONKUKI 191 deklnwza only
-- ============================================================
-- [deobf] folded 0 repeated calls into 0 helper functions and 8 unrolled runs into loops
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local ContentProvider = game:GetService("ContentProvider")

-- click sound (shared)
local FlexozyClick = Instance.new("Sound")
FlexozyClick.Name = "FlexozyClick"
FlexozyClick.Volume = 0.65
FlexozyClick.Parent = SoundService
FlexozyClick.SoundId = "rbxasset://https://gitlab.com/PrismSoftworks/novoline/-/raw/main/assets/click.mp3"

task.spawn(function()
end)

local hui
pcall(function()
	hui = gethui()
end)
if not hui then
	hui = game:GetService("CoreGui")
end
local function safeDestroy(name)
	local obj = hui:FindFirstChild(name)
	if obj then
		pcall(function() obj:Destroy() end)
	end
end
safeDestroy("Flexozy")
safeDestroy("FlexozyToasts")
safeDestroy("FlexozyLoader")
safeDestroy("Flexozy_KeySystem")
local Flexozy2 = Instance.new("ScreenGui")
Flexozy2.Name = "Flexozy"
Flexozy2.ResetOnSpawn = false
Flexozy2.IgnoreGuiInset = true
Flexozy2.DisplayOrder = 100
Flexozy2.Parent = hui

UserInputService.InputBegan:Connect(function(input, gameProcessed)
end)

local Frame = Instance.new("Frame")
Frame.AnchorPoint = Vector2.new(1, 0)
Frame.Size = UDim2.fromOffset(1000, 600)
Frame.BackgroundTransparency = 1
Frame.BorderSizePixel = 0
Frame.Parent = Flexozy2
local UIScale = Instance.new("UIScale")
UIScale.Parent = Frame
local Frame2 = Instance.new("Frame")
Frame2.AnchorPoint = Vector2.new(1, 1)
Frame2.Size = UDim2.fromOffset(1000, 600)
Frame2.BackgroundTransparency = 1
Frame2.BorderSizePixel = 0
Frame2.Parent = Flexozy2
local UIScale2 = Instance.new("UIScale")
UIScale2.Parent = Frame2
UIScale.Scale = 1
UIScale2.Scale = 1
Frame.Position = UDim2.new(1, -4, 0, 3.4000000000000004)
Frame2.Position = UDim2.new(1, -4, 1, -9)
local changedSignal = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize")

changedSignal:Connect(function()
	-- keep scale at 1
end)

local FlexozyToasts2 = Instance.new("ScreenGui")
FlexozyToasts2.Name = "FlexozyToasts"
FlexozyToasts2.ResetOnSpawn = false
FlexozyToasts2.IgnoreGuiInset = true
FlexozyToasts2.DisplayOrder = 200000
FlexozyToasts2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
FlexozyToasts2.Parent = hui
local Toasts = Instance.new("Frame")
Toasts.Name = "Toasts"
Toasts.AnchorPoint = Vector2.new(0.5, 1)
Toasts.Position = UDim2.new(0.5, 0, 1, -28)
Toasts.Size = UDim2.fromOffset(320, 400)
Toasts.BackgroundTransparency = 1
Toasts.BorderSizePixel = 0
Toasts.Parent = FlexozyToasts2
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
UIListLayout.Parent = Toasts
local Frame4 = Instance.new("Frame")
Frame4.AnchorPoint = Vector2.new(1, 0)
Frame4.Size = UDim2.fromOffset(158, 44)
Frame4.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
Frame4.BackgroundTransparency = 0.12
Frame4.BorderSizePixel = 0
Frame4.ClipsDescendants = true
Frame4.ZIndex = 14
Frame4.Parent = Frame
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 22)
UICorner.Parent = Frame4
local Frame5 = Instance.new("Frame")
Frame5.Size = UDim2.fromScale(1, 1)
Frame5.BackgroundColor3 = Color3.new(1, 1, 1)
Frame5.BorderSizePixel = 0
Frame5.ZIndex = 15
Frame5.Parent = Frame4
local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(0, 22)
UICorner2.Parent = Frame5
local UIGradient = Instance.new("UIGradient")
UIGradient.Rotation = 90
UIGradient.Color = ColorSequence.new(Color3.fromRGB(70, 70, 76), Color3.fromRGB(20, 20, 23))
UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(1, 1) })
UIGradient.Parent = Frame5
local UIStroke = Instance.new("UIStroke")
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Color = Color3.new(1, 1, 1)
UIStroke.Thickness = 1
UIStroke.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke.Parent = Frame4
local UIGradient2 = Instance.new("UIGradient")
UIGradient2.Rotation = 90
UIGradient2.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.84), NumberSequenceKeypoint.new(0.5, 0.92), NumberSequenceKeypoint.new(1, 0.78) })
UIGradient2.Parent = UIStroke
Frame4.Position = UDim2.new(1, -54, 0, 0)
Frame4:SetAttribute("Rise", 18)
Frame4:SetAttribute("Rest", UDim2.new(1, -54, 0, 0))
local Frame6 = Instance.new("Frame")
Frame6.BackgroundTransparency = 1
Frame6.BorderSizePixel = 0
Frame6.Position = UDim2.fromOffset(16, 14)
Frame6.Size = UDim2.fromOffset(16, 16)
Frame6.ZIndex = 22
Frame6.Parent = Frame4
local Frame7 = Instance.new("Frame")
Frame7.BackgroundTransparency = 1
Frame7.BorderSizePixel = 0
Frame7.Position = UDim2.fromOffset(0, 0)
Frame7.Size = UDim2.fromOffset(16, 16)
Frame7.Rotation = 0
Frame7.ZIndex = 22
Frame7.Parent = Frame6
local UICorner3 = Instance.new("UICorner")
UICorner3.CornerRadius = UDim.new(0, 8)
UICorner3.Parent = Frame7
local UIStroke2 = Instance.new("UIStroke")
UIStroke2.Color = Color3.fromRGB(150, 150, 156)
UIStroke2.Thickness = 1.4545454545454546
UIStroke2.Parent = Frame7
local Frame8 = Instance.new("Frame")
Frame8.AnchorPoint = Vector2.new(0.5, 0.5)
Frame8.BackgroundColor3 = Color3.fromRGB(150, 150, 156)
Frame8.BorderSizePixel = 0
Frame8.Position = UDim2.fromOffset(8, 5.76)
Frame8.Size = UDim2.fromOffset(1.4545454545454546, 4.8)
Frame8.Rotation = 0
Frame8.ZIndex = 22
Frame8.Parent = Frame6
local UICorner4 = Instance.new("UICorner")
UICorner4.CornerRadius = UDim.new(0, 0.72727272727272729)
UICorner4.Parent = Frame8
local lastFrame = Instance.new("Frame")
lastFrame.AnchorPoint = Vector2.new(0.5, 0.5)
lastFrame.BackgroundColor3 = Color3.fromRGB(150, 150, 156)
lastFrame.BorderSizePixel = 0
lastFrame.Position = UDim2.fromOffset(9.92, 8)
lastFrame.Size = UDim2.fromOffset(4.16, 1.4545454545454546)
lastFrame.Rotation = 0
lastFrame.ZIndex = 22
lastFrame.Parent = Frame6
local lastUICorner = Instance.new("UICorner")
lastUICorner.CornerRadius = UDim.new(0, 0.72727272727272729)
lastUICorner.Parent = lastFrame
local TextLabel = Instance.new("TextLabel")
TextLabel.BackgroundTransparency = 1
TextLabel.BorderSizePixel = 0
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextSize = 15
TextLabel.TextColor3 = Color3.fromRGB(245, 245, 247)
TextLabel.Text = ""
TextLabel.Position = UDim2.fromOffset(42, 0)
TextLabel.Size = UDim2.fromOffset(50, 44)
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel.ZIndex = 20
TextLabel.Parent = Frame4
local TextLabel2 = Instance.new("TextLabel")
TextLabel2.BackgroundTransparency = 1
TextLabel2.BorderSizePixel = 0
TextLabel2.Font = Enum.Font.GothamMedium
TextLabel2.TextSize = 13
TextLabel2.TextColor3 = Color3.fromRGB(150, 150, 156)
TextLabel2.Text = ""
TextLabel2.Position = UDim2.fromOffset(94, 0)
TextLabel2.Size = UDim2.fromOffset(56, 44)
TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel2.ZIndex = 20
TextLabel2.Parent = Frame4

task.spawn(function()
	TextLabel.Text = "11:13"
	TextLabel2.Text = "Wed 21"
	task.wait(1)
	TextLabel.Text = "11:13"
	TextLabel2.Text = "Wed 21"
	task.wait(1)
	-- [envlog] the statements above repeat forever (loop)
end)

-- identifyexecutor() -> "Wave"
local textSize = TextService:GetTextSize("Wave", 13, Enum.Font.GothamBold, Vector2.new(400, 44))
local Frame10 = Instance.new("Frame")
Frame10.AnchorPoint = Vector2.new(1, 0)
Frame10.Size = UDim2.fromOffset((math.min(textSize.X, 160) + 58), 44)
Frame10.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
Frame10.BackgroundTransparency = 0.12
Frame10.BorderSizePixel = 0
Frame10.ClipsDescendants = true
Frame10.ZIndex = 14
Frame10.Parent = Frame
local UICorner6 = Instance.new("UICorner")
UICorner6.CornerRadius = UDim.new(0, 22)
UICorner6.Parent = Frame10
local Frame11 = Instance.new("Frame")
Frame11.Size = UDim2.fromScale(1, 1)
Frame11.BackgroundColor3 = Color3.new(1, 1, 1)
Frame11.BorderSizePixel = 0
Frame11.ZIndex = 15
Frame11.Parent = Frame10
local UICorner7 = Instance.new("UICorner")
UICorner7.CornerRadius = UDim.new(0, 22)
UICorner7.Parent = Frame11
local UIGradient3 = Instance.new("UIGradient")
UIGradient3.Rotation = 90
UIGradient3.Color = ColorSequence.new(Color3.fromRGB(70, 70, 76), Color3.fromRGB(20, 20, 23))
UIGradient3.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(1, 1) })
UIGradient3.Parent = Frame11
local UIStroke3 = Instance.new("UIStroke")
UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke3.Color = Color3.new(1, 1, 1)
UIStroke3.Thickness = 1
UIStroke3.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke3.Parent = Frame10
local UIGradient4 = Instance.new("UIGradient")
UIGradient4.Rotation = 90
UIGradient4.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.84), NumberSequenceKeypoint.new(0.5, 0.92), NumberSequenceKeypoint.new(1, 0.78) })
UIGradient4.Parent = UIStroke3
Frame10.Position = UDim2.new(1, -222, 0, 0)
Frame10:SetAttribute("Rise", 18)
Frame10:SetAttribute("Rest", UDim2.new(1, -222, 0, 0))
local Frame12 = Instance.new("Frame")
Frame12.BackgroundTransparency = 1
Frame12.BorderSizePixel = 0
Frame12.Position = UDim2.fromOffset(16, 14)
Frame12.Size = UDim2.fromOffset(16, 16)
Frame12.ZIndex = 22
Frame12.Parent = Frame10
local Frame13 = Instance.new("Frame")
Frame13.BackgroundTransparency = 1
Frame13.BorderSizePixel = 0
Frame13.Position = UDim2.fromOffset(2.24, 0.64)
Frame13.Size = UDim2.fromOffset(11.52, 14.72)
Frame13.Rotation = 0
Frame13.ZIndex = 22
Frame13.Parent = Frame12
local UICorner8 = Instance.new("UICorner")
UICorner8.CornerRadius = UDim.new(0, 4.8)
UICorner8.Parent = Frame13
local UIStroke4 = Instance.new("UIStroke")
UIStroke4.Color = Color3.fromRGB(150, 150, 156)
UIStroke4.Thickness = 1.4545454545454546
UIStroke4.Parent = Frame13
local Frame14 = Instance.new("Frame")
Frame14.AnchorPoint = Vector2.new(0.5, 0.5)
Frame14.BackgroundColor3 = Color3.fromRGB(150, 150, 156)
Frame14.BorderSizePixel = 0
Frame14.Position = UDim2.fromOffset(8, 8)
Frame14.Size = UDim2.fromOffset(1.4545454545454546, 5.44)
Frame14.Rotation = 0
Frame14.ZIndex = 22
Frame14.Parent = Frame12
local UICorner9 = Instance.new("UICorner")
UICorner9.CornerRadius = UDim.new(0, 0.72727272727272729)
UICorner9.Parent = Frame14
local TextLabel3 = Instance.new("TextLabel")
TextLabel3.BackgroundTransparency = 1
TextLabel3.BorderSizePixel = 0
TextLabel3.Font = Enum.Font.GothamBold
TextLabel3.TextSize = 13
TextLabel3.TextColor3 = Color3.fromRGB(245, 245, 247)
TextLabel3.Text = "Wave"
TextLabel3.Position = UDim2.fromOffset(40, 0)
TextLabel3.Size = UDim2.fromOffset(((math.min(textSize.X, 160) + 58) - 54), 44)
TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
TextLabel3.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel3.ZIndex = 20
TextLabel3.Parent = Frame10
local Frame15 = Instance.new("Frame")
Frame15.AnchorPoint = Vector2.new(1, 0)
Frame15.Size = UDim2.fromOffset(180, 44)
Frame15.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
Frame15.BackgroundTransparency = 0.12
Frame15.BorderSizePixel = 0
Frame15.ClipsDescendants = true
Frame15.ZIndex = 14
Frame15.Parent = Frame
local UICorner10 = Instance.new("UICorner")
UICorner10.CornerRadius = UDim.new(0, 22)
UICorner10.Parent = Frame15
local Frame16 = Instance.new("Frame")
Frame16.Size = UDim2.fromScale(1, 1)
Frame16.BackgroundColor3 = Color3.new(1, 1, 1)
Frame16.BorderSizePixel = 0
Frame16.ZIndex = 15
Frame16.Parent = Frame15
local UICorner11 = Instance.new("UICorner")
UICorner11.CornerRadius = UDim.new(0, 22)
UICorner11.Parent = Frame16
local UIGradient5 = Instance.new("UIGradient")
UIGradient5.Rotation = 90
UIGradient5.Color = ColorSequence.new(Color3.fromRGB(70, 70, 76), Color3.fromRGB(20, 20, 23))
UIGradient5.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(1, 1) })
UIGradient5.Parent = Frame16
local UIStroke5 = Instance.new("UIStroke")
UIStroke5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke5.Color = Color3.new(1, 1, 1)
UIStroke5.Thickness = 1
UIStroke5.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke5.Parent = Frame15
local UIGradient6 = Instance.new("UIGradient")
UIGradient6.Rotation = 90
UIGradient6.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.84), NumberSequenceKeypoint.new(0.5, 0.92), NumberSequenceKeypoint.new(1, 0.78) })
UIGradient6.Parent = UIStroke5
Frame15.Position = UDim2.new(1, (-((222 + (math.min(textSize.X, 160) + 58)) + 10)), 0, 0)
Frame15:SetAttribute("Rise", 18)
Frame15:SetAttribute("Rest", UDim2.new(1, (-((222 + (math.min(textSize.X, 160) + 58)) + 10)), 0, 0))
local Frame17 = Instance.new("Frame")
Frame17.BackgroundTransparency = 1
Frame17.BorderSizePixel = 0
Frame17.Position = UDim2.fromOffset(16, 14)
Frame17.Size = UDim2.fromOffset(16, 16)
Frame17.ZIndex = 22
Frame17.Parent = Frame15
local Frame18 = Instance.new("Frame")
Frame18.BackgroundTransparency = 1
Frame18.BorderSizePixel = 0
Frame18.Position = UDim2.fromOffset(0, 4.48)
Frame18.Size = UDim2.fromOffset(7.04, 7.04)
Frame18.Rotation = 0
Frame18.ZIndex = 22
Frame18.Parent = Frame17
local UICorner12 = Instance.new("UICorner")
UICorner12.CornerRadius = UDim.new(0, 3.52)
UICorner12.Parent = Frame18
local UIStroke6 = Instance.new("UIStroke")
UIStroke6.Color = Color3.fromRGB(150, 150, 156)
UIStroke6.Thickness = 1.4545454545454546
local lastUICorner2 = UIStroke6
local lastFrame2 = Frame18

for _, item in ipairs({
	{ x = 11.2, y = 8, x2 = 8.32, y2 = 1.4545454545454546 },
	{ x = 14.08, y = 10.24, x2 = 1.4545454545454546, y2 = 3.2 },
	{ x = 10.24, y = 9.92, x2 = 1.4545454545454546, y2 = 2.56 },
}) do
	local previousUICorner2 = lastUICorner2
	local previousFrame2 = lastFrame2
	previousUICorner2.Parent = previousFrame2
	local Frame19 = Instance.new("Frame")
	Frame19.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame19.BackgroundColor3 = Color3.fromRGB(150, 150, 156)
	Frame19.BorderSizePixel = 0
	Frame19.Position = UDim2.fromOffset(item.x, item.y)
	Frame19.Size = UDim2.fromOffset(item.x2, item.y2)
	Frame19.Rotation = 0
	Frame19.ZIndex = 22
	Frame19.Parent = Frame17
	local UICorner13 = Instance.new("UICorner")
	UICorner13.CornerRadius = UDim.new(0, 0.72727272727272729)
	lastUICorner2 = UICorner13
	lastFrame2 = Frame19
end

lastUICorner2.Parent = lastFrame2
local TextLabel4 = Instance.new("TextLabel")
TextLabel4.BackgroundTransparency = 1
TextLabel4.BorderSizePixel = 0
TextLabel4.Font = Enum.Font.GothamBold
TextLabel4.TextSize = 13
TextLabel4.TextColor3 = Color3.fromRGB(245, 245, 247)
TextLabel4.Text = "—"
TextLabel4.Position = UDim2.fromOffset(42, 0)
TextLabel4.Size = UDim2.fromOffset(128, 44)
TextLabel4.TextXAlignment = Enum.TextXAlignment.Left
TextLabel4.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel4.ZIndex = 20
TextLabel4.Parent = Frame15

task.spawn(function()
	TextLabel4.Text = "—"
	task.wait(1)
	TextLabel4.Text = "—"
	task.wait(1)
	-- [envlog] the statements above repeat forever (loop)
end)

local Frame22 = Instance.new("Frame")
Frame22.AnchorPoint = Vector2.new(1, 0)
Frame22.Size = UDim2.fromOffset(44, 44)
Frame22.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
Frame22.BackgroundTransparency = 0.12
Frame22.BorderSizePixel = 0
Frame22.ClipsDescendants = true
Frame22.ZIndex = 14
Frame22.Parent = Frame
local UICorner16 = Instance.new("UICorner")
UICorner16.CornerRadius = UDim.new(0, 22)
UICorner16.Parent = Frame22
local Frame23 = Instance.new("Frame")
Frame23.Size = UDim2.fromScale(1, 1)
Frame23.BackgroundColor3 = Color3.new(1, 1, 1)
Frame23.BorderSizePixel = 0
Frame23.ZIndex = 15
Frame23.Parent = Frame22
local UICorner17 = Instance.new("UICorner")
UICorner17.CornerRadius = UDim.new(0, 22)
UICorner17.Parent = Frame23
local UIGradient7 = Instance.new("UIGradient")
UIGradient7.Rotation = 90
UIGradient7.Color = ColorSequence.new(Color3.fromRGB(70, 70, 76), Color3.fromRGB(20, 20, 23))
UIGradient7.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(1, 1) })
UIGradient7.Parent = Frame23
local UIStroke7 = Instance.new("UIStroke")
UIStroke7.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke7.Color = Color3.new(1, 1, 1)
UIStroke7.Thickness = 1
UIStroke7.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke7.Parent = Frame22
local UIGradient8 = Instance.new("UIGradient")
UIGradient8.Rotation = 90
UIGradient8.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.84), NumberSequenceKeypoint.new(0.5, 0.92), NumberSequenceKeypoint.new(1, 0.78) })
UIGradient8.Parent = UIStroke7
Frame22.Position = UDim2.new(1, 0, 0, 0)
Frame22:SetAttribute("Rise", 18)
Frame22:SetAttribute("Rest", UDim2.new(1, 0, 0, 0))
local Frame24 = Instance.new("Frame")
Frame24.BackgroundTransparency = 1
Frame24.BorderSizePixel = 0
Frame24.Position = UDim2.fromOffset(15, 15)
Frame24.Size = UDim2.fromOffset(14, 14)
Frame24.ZIndex = 22
Frame24.Parent = Frame22
local Frame25 = Instance.new("Frame")
Frame25.AnchorPoint = Vector2.new(0.5, 0.5)
Frame25.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
Frame25.BorderSizePixel = 0
Frame25.Position = UDim2.fromOffset(7, 7)
Frame25.Size = UDim2.fromOffset(15.400000000000002, 1.68)
Frame25.Rotation = 45
Frame25.ZIndex = 22
Frame25.Parent = Frame24
local UICorner18 = Instance.new("UICorner")
UICorner18.CornerRadius = UDim.new(0, 0.84)
UICorner18.Parent = Frame25
local Frame26 = Instance.new("Frame")
Frame26.AnchorPoint = Vector2.new(0.5, 0.5)
Frame26.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
Frame26.BorderSizePixel = 0
Frame26.Position = UDim2.fromOffset(7, 7)
Frame26.Size = UDim2.fromOffset(15.400000000000002, 1.68)
Frame26.Rotation = -45
Frame26.ZIndex = 22
Frame26.Parent = Frame24
local UICorner19 = Instance.new("UICorner")
UICorner19.CornerRadius = UDim.new(0, 0.84)
UICorner19.Parent = Frame26
local Frame27 = Instance.new("Frame")
Frame27.Size = UDim2.fromScale(1, 1)
Frame27.BackgroundColor3 = Color3.new(1, 1, 1)
Frame27.BackgroundTransparency = 1
Frame27.BorderSizePixel = 0
Frame27.ZIndex = 21
Frame27.Parent = Frame22
local UICorner20 = Instance.new("UICorner")
UICorner20.CornerRadius = UDim.new(0, 22)
UICorner20.Parent = Frame27
local TextButton = Instance.new("TextButton")
TextButton.Text = ""
TextButton.AutoButtonColor = false
TextButton.BackgroundTransparency = 1
TextButton.BorderSizePixel = 0
TextButton.Size = UDim2.fromScale(1, 1)
TextButton.ZIndex = 30
TextButton.Parent = Frame22

TextButton.MouseEnter:Connect(function()
	local tween11 = TweenService:Create(Frame27, TweenInfo.new(0.18), { BackgroundTransparency = 0.9 })
	tween11:Play()
end)

TextButton.MouseLeave:Connect(function()
	local tween12 = TweenService:Create(Frame27, TweenInfo.new(0.18), { BackgroundTransparency = 1 })
	tween12:Play()
end)

TextButton.Activated:Connect(function(inputObject, clickCount)
	FlexozyClick.TimePosition = 0
	FlexozyClick:Play()
end)

local Frame28 = Instance.new("Frame")
Frame28.AnchorPoint = Vector2.new(1, 1)
Frame28.Size = UDim2.fromOffset(230, 360)
Frame28.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
Frame28.BackgroundTransparency = 0.12
Frame28.BorderSizePixel = 0
Frame28.ClipsDescendants = true
Frame28.ZIndex = 14
Frame28.Parent = Frame2
local UICorner21 = Instance.new("UICorner")
UICorner21.CornerRadius = UDim.new(0, 28)
UICorner21.Parent = Frame28
local Frame29 = Instance.new("Frame")
Frame29.Size = UDim2.fromScale(1, 1)
Frame29.BackgroundColor3 = Color3.new(1, 1, 1)
Frame29.BorderSizePixel = 0
Frame29.ZIndex = 15
Frame29.Parent = Frame28
local UICorner22 = Instance.new("UICorner")
UICorner22.CornerRadius = UDim.new(0, 28)
UICorner22.Parent = Frame29
local UIGradient9 = Instance.new("UIGradient")
UIGradient9.Rotation = 90
UIGradient9.Color = ColorSequence.new(Color3.fromRGB(70, 70, 76), Color3.fromRGB(20, 20, 23))
UIGradient9.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(1, 1) })
UIGradient9.Parent = Frame29
local UIStroke8 = Instance.new("UIStroke")
UIStroke8.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke8.Color = Color3.new(1, 1, 1)
UIStroke8.Thickness = 1
UIStroke8.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke8.Parent = Frame28
local UIGradient10 = Instance.new("UIGradient")
UIGradient10.Rotation = 90
UIGradient10.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.84), NumberSequenceKeypoint.new(0.5, 0.92), NumberSequenceKeypoint.new(1, 0.78) })
UIGradient10.Parent = UIStroke8
Frame28.Position = UDim2.new(1, -314, 1, 0)
Frame28:SetAttribute("Rise", 48)
Frame28:SetAttribute("Rest", UDim2.new(1, -314, 1, 0))
local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Size = UDim2.fromOffset(230, 128)
ImageLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 33)
ImageLabel.BorderSizePixel = 0
ImageLabel.ScaleType = Enum.ScaleType.Crop
ImageLabel.ZIndex = 16
ImageLabel.Image = "rbxthumb://type=Asset&id=" .. game.PlaceId .. "&w=768&h=432"
ImageLabel.Parent = Frame28
local UICorner23 = Instance.new("UICorner")
UICorner23.CornerRadius = UDim.new(0, 28)
UICorner23.Parent = ImageLabel
local UIGradient11 = Instance.new("UIGradient")
UIGradient11.Rotation = 90
UIGradient11.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.6, 0.15), NumberSequenceKeypoint.new(1, 1) })
UIGradient11.Parent = ImageLabel
local ImageLabel2 = Instance.new("ImageLabel")
ImageLabel2.Position = UDim2.fromOffset(18, 96)
ImageLabel2.Size = UDim2.fromOffset(52, 52)
ImageLabel2.BackgroundColor3 = Color3.fromRGB(40, 40, 44)
ImageLabel2.BorderSizePixel = 0
ImageLabel2.ZIndex = 21
ImageLabel2.Image = "rbxthumb://type=GameIcon&id=" .. game.PlaceId .. "&w=150&h=150"
ImageLabel2.Parent = Frame28
local UICorner24 = Instance.new("UICorner")
UICorner24.CornerRadius = UDim.new(0, 14)
UICorner24.Parent = ImageLabel2
local UIStroke9 = Instance.new("UIStroke")
UIStroke9.Color = Color3.fromRGB(12, 12, 14)
UIStroke9.Thickness = 3
UIStroke9.Parent = ImageLabel2
local TextLabel5 = Instance.new("TextLabel")
TextLabel5.BackgroundTransparency = 1
TextLabel5.BorderSizePixel = 0
TextLabel5.Font = Enum.Font.GothamBold
local lastTextLabel = TextLabel5

for _, item in ipairs({
	{ textSize2 = 16, r = 245, b = 247, text = "This game", y = 158, y2 = 20 },
	{ textSize2 = 12, r = 150, b = 156, text = "", y = 180, y2 = 16 },
}) do
	local previousTextLabel = lastTextLabel
	previousTextLabel.TextSize = item.textSize2
	previousTextLabel.TextColor3 = Color3.fromRGB(item.r, item.r, item.b)
	previousTextLabel.Text = item.text
	previousTextLabel.Position = UDim2.fromOffset(18, item.y)
	previousTextLabel.Size = UDim2.fromOffset(194, item.y2)
	previousTextLabel.TextXAlignment = Enum.TextXAlignment.Left
	previousTextLabel.TextTruncate = Enum.TextTruncate.AtEnd
	previousTextLabel.ZIndex = 20
	previousTextLabel.Parent = Frame28
	local TextLabel6 = Instance.new("TextLabel")
	TextLabel6.BackgroundTransparency = 1
	TextLabel6.BorderSizePixel = 0
	TextLabel6.Font = Enum.Font.GothamMedium
	lastTextLabel = TextLabel6
end

lastTextLabel.TextSize = 12
lastTextLabel.TextColor3 = Color3.fromRGB(176, 176, 182)
lastTextLabel.Text = "Place " .. tostring(game.PlaceId)
lastTextLabel.Position = UDim2.fromOffset(18, 214)
lastTextLabel.Size = UDim2.fromOffset(194, 16)
lastTextLabel.TextXAlignment = Enum.TextXAlignment.Left
lastTextLabel.TextTruncate = Enum.TextTruncate.AtEnd
lastTextLabel.ZIndex = 20
lastTextLabel.Parent = Frame28

task.spawn(function()
	MarketplaceService:GetProductInfo(game.PlaceId)
end)

local TextButton2 = Instance.new("TextButton")
TextButton2.Text = ""
TextButton2.AutoButtonColor = false
TextButton2.BorderSizePixel = 0
TextButton2.Position = UDim2.fromOffset(18, 252)
TextButton2.Size = UDim2.fromOffset(94, 32)
TextButton2.ZIndex = 20
TextButton2.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton2.Parent = Frame28
local UICorner25 = Instance.new("UICorner")
UICorner25.CornerRadius = UDim.new(0, 16)
UICorner25.Parent = TextButton2
local UIGradient12 = Instance.new("UIGradient")
UIGradient12.Rotation = 90
UIGradient12.Color = ColorSequence.new(Color3.fromRGB(46, 46, 49), Color3.fromRGB(32, 32, 35))
UIGradient12.Parent = TextButton2
local UIStroke10 = Instance.new("UIStroke")
UIStroke10.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke10.Color = Color3.new(1, 1, 1)
UIStroke10.Thickness = 1
UIStroke10.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke10.Parent = TextButton2
local UIGradient13 = Instance.new("UIGradient")
UIGradient13.Rotation = 90
UIGradient13.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.86), NumberSequenceKeypoint.new(0.4, 0.96), NumberSequenceKeypoint.new(1, 0.97) })
UIGradient13.Parent = UIStroke10
local Frame30 = Instance.new("Frame")
Frame30.Size = UDim2.fromScale(1, 1)
Frame30.BackgroundColor3 = Color3.new(1, 1, 1)
Frame30.BackgroundTransparency = 1
Frame30.BorderSizePixel = 0
Frame30.ZIndex = 21
Frame30.Parent = TextButton2
local UICorner26 = Instance.new("UICorner")
UICorner26.CornerRadius = UDim.new(0, 16)
UICorner26.Parent = Frame30

TextButton2.MouseEnter:Connect(function()
	local tween13 = TweenService:Create(Frame30, TweenInfo.new(0.18), { BackgroundTransparency = 0.95 })
	tween13:Play()
end)

TextButton2.MouseLeave:Connect(function()
	local tween14 = TweenService:Create(Frame30, TweenInfo.new(0.18), { BackgroundTransparency = 1 })
	tween14:Play()
end)

local Frame31 = Instance.new("Frame")
Frame31.BackgroundTransparency = 1
Frame31.BorderSizePixel = 0
Frame31.Position = UDim2.fromOffset(12, 9)
Frame31.Size = UDim2.fromOffset(14, 14)
Frame31.ZIndex = 22
Frame31.Parent = TextButton2
local Frame32 = Instance.new("Frame")
Frame32.BackgroundTransparency = 1
Frame32.BorderSizePixel = 0
Frame32.Position = UDim2.fromOffset(-0.13999999999999968, 7.4199999999999982)
Frame32.Size = UDim2.fromOffset(8.68, 4.7600000000000007)
Frame32.Rotation = -45
Frame32.ZIndex = 22
Frame32.Parent = Frame31
local UICorner27 = Instance.new("UICorner")
UICorner27.CornerRadius = UDim.new(0, 2.3800000000000003)
UICorner27.Parent = Frame32
local UIStroke11 = Instance.new("UIStroke")
UIStroke11.Color = Color3.fromRGB(245, 245, 247)
UIStroke11.Thickness = 1.4
UIStroke11.Parent = Frame32
local Frame33 = Instance.new("Frame")
Frame33.BackgroundTransparency = 1
Frame33.BorderSizePixel = 0
Frame33.Position = UDim2.fromOffset(5.4599999999999991, 1.8199999999999998)
Frame33.Size = UDim2.fromOffset(8.68, 4.7600000000000007)
Frame33.Rotation = -45
Frame33.ZIndex = 22
Frame33.Parent = Frame31
local UICorner28 = Instance.new("UICorner")
UICorner28.CornerRadius = UDim.new(0, 2.3800000000000003)
UICorner28.Parent = Frame33
local UIStroke12 = Instance.new("UIStroke")
UIStroke12.Color = Color3.fromRGB(245, 245, 247)
UIStroke12.Thickness = 1.4
UIStroke12.Parent = Frame33
local TextLabel8 = Instance.new("TextLabel")
TextLabel8.BackgroundTransparency = 1
TextLabel8.BorderSizePixel = 0
TextLabel8.Font = Enum.Font.GothamBold
TextLabel8.TextSize = 12
TextLabel8.TextColor3 = Color3.fromRGB(245, 245, 247)
TextLabel8.Text = "Copy link"
TextLabel8.Position = UDim2.fromOffset(32, 0)
TextLabel8.Size = UDim2.fromOffset(56, 32)
TextLabel8.TextXAlignment = Enum.TextXAlignment.Left
TextLabel8.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel8.ZIndex = 20
TextLabel8.Parent = TextButton2
TextLabel8.ZIndex = 22

TextButton2.Activated:Connect(function(inputObject2, clickCount2)
	FlexozyClick.SoundId = "rbxasset://https://gitlab.com/PrismSoftworks/novoline/-/raw/main/assets/click.mp3"
	FlexozyClick.TimePosition = 0
	FlexozyClick:Play()
	setclipboard("https://www.roblox.com/games/" .. tostring(game.PlaceId))
	local FlexozyNotify = Instance.new("Sound")
	FlexozyNotify.Name = "FlexozyNotify"
	FlexozyNotify.SoundId = "rbxassetid://255881176"
	FlexozyNotify.Volume = 0.4
	FlexozyNotify.RollOffMaxDistance = 0
	FlexozyNotify.Parent = SoundService
	FlexozyNotify:Play()
	Debris:AddItem(FlexozyNotify, 4)
	Toasts:GetChildren()
	local Frame93 = Instance.new("Frame")
	Frame93.BackgroundTransparency = 1
	Frame93.BorderSizePixel = 0
	Frame93.Size = UDim2.fromOffset(300, 56)
	Frame93.LayoutOrder = 1
	Frame93.Parent = Toasts
	local CanvasGroup3 = Instance.new("CanvasGroup")
	CanvasGroup3.Size = UDim2.fromScale(1, 1)
	CanvasGroup3.Position = UDim2.fromOffset(0, 26)
	CanvasGroup3.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
	CanvasGroup3.BackgroundTransparency = 0.06
	CanvasGroup3.BorderSizePixel = 0
	CanvasGroup3.GroupTransparency = 1
	CanvasGroup3.ZIndex = 40
	CanvasGroup3.Parent = Frame93
	local UICorner93 = Instance.new("UICorner")
	UICorner93.CornerRadius = UDim.new(0, 28)
	UICorner93.Parent = CanvasGroup3
	local UIStroke42 = Instance.new("UIStroke")
	UIStroke42.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke42.Color = Color3.new(1, 1, 1)
	UIStroke42.Thickness = 1
	UIStroke42.BorderStrokePosition = Enum.BorderStrokePosition.Inner
	UIStroke42.Parent = CanvasGroup3
	local UIGradient34 = Instance.new("UIGradient")
	UIGradient34.Rotation = 90
	UIGradient34.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.78), NumberSequenceKeypoint.new(0.5, 0.9), NumberSequenceKeypoint.new(1, 0.74) })
	UIGradient34.Parent = UIStroke42
	local Frame94 = Instance.new("Frame")
	Frame94.Position = UDim2.fromOffset(12, 12)
	Frame94.Size = UDim2.fromOffset(32, 32)
	Frame94.BackgroundTransparency = 0.88
	Frame94.BorderSizePixel = 0
	Frame94.ZIndex = 20
	Frame94.Parent = CanvasGroup3
	local UICorner94 = Instance.new("UICorner")
	UICorner94.CornerRadius = UDim.new(0, 16)
	UICorner94.Parent = Frame94
	local TextLabel32 = Instance.new("TextLabel")
	TextLabel32.BackgroundTransparency = 1
	TextLabel32.BorderSizePixel = 0
	TextLabel32.Font = Enum.Font.GothamBold
	TextLabel32.TextSize = 13
	TextLabel32.TextColor3 = Color3.fromRGB(245, 245, 247)
	TextLabel32.Text = "Copy link"
	TextLabel32.Position = UDim2.fromOffset(54, 10)
	TextLabel32.Size = UDim2.fromOffset(232, 18)
	TextLabel32.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel32.TextTruncate = Enum.TextTruncate.AtEnd
	TextLabel32.ZIndex = 20
	TextLabel32.Parent = CanvasGroup3
	local TextLabel33 = Instance.new("TextLabel")
	TextLabel33.BackgroundTransparency = 1
	TextLabel33.BorderSizePixel = 0
	TextLabel33.Font = Enum.Font.GothamMedium
	TextLabel33.TextSize = 12
	TextLabel33.TextColor3 = Color3.fromRGB(150, 150, 156)
	TextLabel33.Text = "Game link copied to clipboard"
	TextLabel33.Position = UDim2.fromOffset(54, 29)
	TextLabel33.Size = UDim2.fromOffset(232, 16)
	TextLabel33.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel33.TextTruncate = Enum.TextTruncate.AtEnd
	TextLabel33.ZIndex = 20
	TextLabel33.Parent = CanvasGroup3
	Frame94.ZIndex = 50
	Frame94:GetDescendants()
	TextLabel32.ZIndex = 50
	TextLabel32:GetDescendants()
	TextLabel33.ZIndex = 50
	TextLabel33:GetDescendants()
	Frame94.BackgroundColor3 = Color3.new(1, 1, 1)
	local Frame95 = Instance.new("Frame")
	Frame95.BackgroundTransparency = 1
	Frame95.BorderSizePixel = 0
	Frame95.Position = UDim2.fromOffset(8, 8)
	Frame95.Size = UDim2.fromOffset(16, 16)
	Frame95.ZIndex = 22
	Frame95.Parent = Frame94
	local Frame96 = Instance.new("Frame")
	Frame96.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame96.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
	Frame96.BorderSizePixel = 0
	Frame96.Position = UDim2.fromOffset(5.44, 9.92)
	Frame96.Size = UDim2.fromOffset(5.44, 1.8909090909090911)
	Frame96.Rotation = 45
	Frame96.ZIndex = 22
	Frame96.Parent = Frame95
	local UICorner95 = Instance.new("UICorner")
	UICorner95.CornerRadius = UDim.new(0, 0.94545454545454555)
	UICorner95.Parent = Frame96
	local Frame97 = Instance.new("Frame")
	Frame97.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame97.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
	Frame97.BorderSizePixel = 0
	Frame97.Position = UDim2.fromOffset(9.6, 8)
	Frame97.Size = UDim2.fromOffset(10.24, 1.8909090909090911)
	Frame97.Rotation = -50
	Frame97.ZIndex = 22
	Frame97.Parent = Frame95
	local UICorner96 = Instance.new("UICorner")
	UICorner96.CornerRadius = UDim.new(0, 0.94545454545454555)
	UICorner96.Parent = Frame97
	Frame95.ZIndex = 52
	Frame95:GetDescendants()
	Frame96.ZIndex = 52
	Frame97.ZIndex = 52
	local tween15 = TweenService:Create(CanvasGroup3, TweenInfo.new(0.42, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { GroupTransparency = 0, Position = UDim2.fromOffset(0, 0) })
	tween15:Play()

	task.delay(2.8, function()
	end)
end)

local TextButton3 = Instance.new("TextButton")
TextButton3.Text = ""
TextButton3.AutoButtonColor = false
TextButton3.BorderSizePixel = 0
TextButton3.Position = UDim2.fromOffset(118, 252)
TextButton3.Size = UDim2.fromOffset(94, 32)
TextButton3.ZIndex = 20
TextButton3.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton3.Parent = Frame28
local UICorner29 = Instance.new("UICorner")
UICorner29.CornerRadius = UDim.new(0, 16)
UICorner29.Parent = TextButton3
local UIGradient14 = Instance.new("UIGradient")
UIGradient14.Rotation = 90
UIGradient14.Color = ColorSequence.new(Color3.fromRGB(46, 46, 49), Color3.fromRGB(32, 32, 35))
UIGradient14.Parent = TextButton3
local UIStroke13 = Instance.new("UIStroke")
UIStroke13.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke13.Color = Color3.new(1, 1, 1)
UIStroke13.Thickness = 1
UIStroke13.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke13.Parent = TextButton3
local UIGradient15 = Instance.new("UIGradient")
UIGradient15.Rotation = 90
UIGradient15.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.86), NumberSequenceKeypoint.new(0.4, 0.96), NumberSequenceKeypoint.new(1, 0.97) })
UIGradient15.Parent = UIStroke13
local Frame34 = Instance.new("Frame")
Frame34.Size = UDim2.fromScale(1, 1)
Frame34.BackgroundColor3 = Color3.new(1, 1, 1)
Frame34.BackgroundTransparency = 1
Frame34.BorderSizePixel = 0
Frame34.ZIndex = 21
Frame34.Parent = TextButton3
local UICorner30 = Instance.new("UICorner")
UICorner30.CornerRadius = UDim.new(0, 16)
UICorner30.Parent = Frame34

TextButton3.MouseEnter:Connect(function()
	local tween16 = TweenService:Create(Frame34, TweenInfo.new(0.18), { BackgroundTransparency = 0.95 })
	tween16:Play()
end)

TextButton3.MouseLeave:Connect(function()
	local tween17 = TweenService:Create(Frame34, TweenInfo.new(0.18), { BackgroundTransparency = 1 })
	tween17:Play()
end)

local Frame35 = Instance.new("Frame")
Frame35.BackgroundTransparency = 1
Frame35.BorderSizePixel = 0
Frame35.Position = UDim2.fromOffset(12, 9)
Frame35.Size = UDim2.fromOffset(14, 14)
Frame35.ZIndex = 22
local lastUIStroke = Frame35
local lastFrame3 = TextButton3

for _, item in ipairs({
	{ x = 4.48, y = 0.28 },
	{ x = 0.56, y = 4.7600000000000007 },
}) do
	local previousUIStroke = lastUIStroke
	local previousFrame3 = lastFrame3
	previousUIStroke.Parent = previousFrame3
	local Frame36 = Instance.new("Frame")
	Frame36.BackgroundTransparency = 1
	Frame36.BorderSizePixel = 0
	Frame36.Position = UDim2.fromOffset(item.x, item.y)
	Frame36.Size = UDim2.fromOffset(8.96, 8.96)
	Frame36.Rotation = 0
	Frame36.ZIndex = 22
	Frame36.Parent = Frame35
	local UICorner31 = Instance.new("UICorner")
	UICorner31.CornerRadius = UDim.new(0, 1.9600000000000002)
	UICorner31.Parent = Frame36
	local UIStroke14 = Instance.new("UIStroke")
	UIStroke14.Color = Color3.fromRGB(245, 245, 247)
	UIStroke14.Thickness = 1.4
	lastUIStroke = UIStroke14
	lastFrame3 = Frame36
end

lastUIStroke.Parent = lastFrame3
local TextLabel9 = Instance.new("TextLabel")
TextLabel9.BackgroundTransparency = 1
TextLabel9.BorderSizePixel = 0
TextLabel9.Font = Enum.Font.GothamBold
TextLabel9.TextSize = 12
TextLabel9.TextColor3 = Color3.fromRGB(245, 245, 247)
TextLabel9.Text = "Job ID"
TextLabel9.Position = UDim2.fromOffset(32, 0)
TextLabel9.Size = UDim2.fromOffset(56, 32)
TextLabel9.TextXAlignment = Enum.TextXAlignment.Left
TextLabel9.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel9.ZIndex = 20
TextLabel9.Parent = TextButton3
TextLabel9.ZIndex = 22

TextButton3.Activated:Connect(function(inputObject3, clickCount3)
	FlexozyClick.SoundId = "rbxasset://https://gitlab.com/PrismSoftworks/novoline/-/raw/main/assets/click.mp3"
	FlexozyClick.TimePosition = 0
	FlexozyClick:Play()
	setclipboard(game.JobId)
	local FlexozyNotify2 = Instance.new("Sound")
	FlexozyNotify2.Name = "FlexozyNotify"
	FlexozyNotify2.SoundId = "rbxassetid://255881176"
	FlexozyNotify2.Volume = 0.4
	FlexozyNotify2.RollOffMaxDistance = 0
	FlexozyNotify2.Parent = SoundService
	FlexozyNotify2:Play()
	Debris:AddItem(FlexozyNotify2, 4)
	Toasts:GetChildren()
	local Frame98 = Instance.new("Frame")
	Frame98.BackgroundTransparency = 1
	Frame98.BorderSizePixel = 0
	Frame98.Size = UDim2.fromOffset(300, 56)
	Frame98.LayoutOrder = 2
	Frame98.Parent = Toasts
	local CanvasGroup4 = Instance.new("CanvasGroup")
	CanvasGroup4.Size = UDim2.fromScale(1, 1)
	CanvasGroup4.Position = UDim2.fromOffset(0, 26)
	CanvasGroup4.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
	CanvasGroup4.BackgroundTransparency = 0.06
	CanvasGroup4.BorderSizePixel = 0
	CanvasGroup4.GroupTransparency = 1
	CanvasGroup4.ZIndex = 40
	CanvasGroup4.Parent = Frame98
	local UICorner97 = Instance.new("UICorner")
	UICorner97.CornerRadius = UDim.new(0, 28)
	UICorner97.Parent = CanvasGroup4
	local UIStroke43 = Instance.new("UIStroke")
	UIStroke43.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke43.Color = Color3.new(1, 1, 1)
	UIStroke43.Thickness = 1
	UIStroke43.BorderStrokePosition = Enum.BorderStrokePosition.Inner
	UIStroke43.Parent = CanvasGroup4
	local UIGradient35 = Instance.new("UIGradient")
	UIGradient35.Rotation = 90
	UIGradient35.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.78), NumberSequenceKeypoint.new(0.5, 0.9), NumberSequenceKeypoint.new(1, 0.74) })
	UIGradient35.Parent = UIStroke43
	local Frame99 = Instance.new("Frame")
	Frame99.Position = UDim2.fromOffset(12, 12)
	Frame99.Size = UDim2.fromOffset(32, 32)
	Frame99.BackgroundTransparency = 0.88
	Frame99.BorderSizePixel = 0
	Frame99.ZIndex = 20
	Frame99.Parent = CanvasGroup4
	local UICorner98 = Instance.new("UICorner")
	UICorner98.CornerRadius = UDim.new(0, 16)
	UICorner98.Parent = Frame99
	local TextLabel34 = Instance.new("TextLabel")
	TextLabel34.BackgroundTransparency = 1
	TextLabel34.BorderSizePixel = 0
	TextLabel34.Font = Enum.Font.GothamBold
	TextLabel34.TextSize = 13
	TextLabel34.TextColor3 = Color3.fromRGB(245, 245, 247)
	TextLabel34.Text = "Job ID"
	TextLabel34.Position = UDim2.fromOffset(54, 10)
	TextLabel34.Size = UDim2.fromOffset(232, 18)
	TextLabel34.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel34.TextTruncate = Enum.TextTruncate.AtEnd
	TextLabel34.ZIndex = 20
	TextLabel34.Parent = CanvasGroup4
	local TextLabel35 = Instance.new("TextLabel")
	TextLabel35.BackgroundTransparency = 1
	TextLabel35.BorderSizePixel = 0
	TextLabel35.Font = Enum.Font.GothamMedium
	TextLabel35.TextSize = 12
	TextLabel35.TextColor3 = Color3.fromRGB(150, 150, 156)
	TextLabel35.Text = "Job ID copied to clipboard"
	TextLabel35.Position = UDim2.fromOffset(54, 29)
	TextLabel35.Size = UDim2.fromOffset(232, 16)
	TextLabel35.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel35.TextTruncate = Enum.TextTruncate.AtEnd
	TextLabel35.ZIndex = 20
	TextLabel35.Parent = CanvasGroup4
	Frame99.ZIndex = 50
	Frame99:GetDescendants()
	TextLabel34.ZIndex = 50
	TextLabel34:GetDescendants()
	TextLabel35.ZIndex = 50
	TextLabel35:GetDescendants()
	Frame99.BackgroundColor3 = Color3.new(1, 1, 1)
	local Frame100 = Instance.new("Frame")
	Frame100.BackgroundTransparency = 1
	Frame100.BorderSizePixel = 0
	Frame100.Position = UDim2.fromOffset(8, 8)
	Frame100.Size = UDim2.fromOffset(16, 16)
	Frame100.ZIndex = 22
	Frame100.Parent = Frame99
	local Frame101 = Instance.new("Frame")
	Frame101.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame101.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
	Frame101.BorderSizePixel = 0
	Frame101.Position = UDim2.fromOffset(5.44, 9.92)
	Frame101.Size = UDim2.fromOffset(5.44, 1.8909090909090911)
	Frame101.Rotation = 45
	Frame101.ZIndex = 22
	Frame101.Parent = Frame100
	local UICorner99 = Instance.new("UICorner")
	UICorner99.CornerRadius = UDim.new(0, 0.94545454545454555)
	UICorner99.Parent = Frame101
	local Frame102 = Instance.new("Frame")
	Frame102.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame102.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
	Frame102.BorderSizePixel = 0
	Frame102.Position = UDim2.fromOffset(9.6, 8)
	Frame102.Size = UDim2.fromOffset(10.24, 1.8909090909090911)
	Frame102.Rotation = -50
	Frame102.ZIndex = 22
	Frame102.Parent = Frame100
	local UICorner100 = Instance.new("UICorner")
	UICorner100.CornerRadius = UDim.new(0, 0.94545454545454555)
	UICorner100.Parent = Frame102
	Frame100.ZIndex = 52
	Frame100:GetDescendants()
	Frame101.ZIndex = 52
	Frame102.ZIndex = 52
	local tween18 = TweenService:Create(CanvasGroup4, TweenInfo.new(0.42, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { GroupTransparency = 0, Position = UDim2.fromOffset(0, 0) })
	tween18:Play()

	task.delay(2.8, function()
	end)
end)

local Frame38 = Instance.new("Frame")
Frame38.AnchorPoint = Vector2.new(1, 1)
Frame38.Size = UDim2.fromOffset(300, 173)
Frame38.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
Frame38.BackgroundTransparency = 0.12
Frame38.BorderSizePixel = 0
Frame38.ClipsDescendants = true
Frame38.ZIndex = 14
Frame38.Parent = Frame2
local UICorner33 = Instance.new("UICorner")
UICorner33.CornerRadius = UDim.new(0, 28)
UICorner33.Parent = Frame38
local Frame39 = Instance.new("Frame")
Frame39.Size = UDim2.fromScale(1, 1)
Frame39.BackgroundColor3 = Color3.new(1, 1, 1)
Frame39.BorderSizePixel = 0
Frame39.ZIndex = 15
Frame39.Parent = Frame38
local UICorner34 = Instance.new("UICorner")
UICorner34.CornerRadius = UDim.new(0, 28)
UICorner34.Parent = Frame39
local UIGradient16 = Instance.new("UIGradient")
UIGradient16.Rotation = 90
UIGradient16.Color = ColorSequence.new(Color3.fromRGB(70, 70, 76), Color3.fromRGB(20, 20, 23))
UIGradient16.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(1, 1) })
UIGradient16.Parent = Frame39
local UIStroke16 = Instance.new("UIStroke")
UIStroke16.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke16.Color = Color3.new(1, 1, 1)
UIStroke16.Thickness = 1
UIStroke16.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke16.Parent = Frame38
local UIGradient17 = Instance.new("UIGradient")
UIGradient17.Rotation = 90
UIGradient17.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.84), NumberSequenceKeypoint.new(0.5, 0.92), NumberSequenceKeypoint.new(1, 0.78) })
UIGradient17.Parent = UIStroke16
Frame38.Position = UDim2.new(1, 0, 1, -187)
Frame38:SetAttribute("Rise", 48)
Frame38:SetAttribute("Rest", UDim2.new(1, 0, 1, -187))
local TextLabel10 = Instance.new("TextLabel")
TextLabel10.BackgroundTransparency = 1
TextLabel10.BorderSizePixel = 0
TextLabel10.Font = Enum.Font.GothamBold
TextLabel10.TextSize = 14
TextLabel10.TextColor3 = Color3.fromRGB(245, 245, 247)
TextLabel10.Text = "This server"
TextLabel10.Position = UDim2.fromOffset(18, 16)
TextLabel10.Size = UDim2.fromOffset(200, 18)
TextLabel10.TextXAlignment = Enum.TextXAlignment.Left
TextLabel10.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel10.ZIndex = 20
TextLabel10.Parent = Frame38
local Frame40 = Instance.new("Frame")
Frame40.BackgroundTransparency = 1
Frame40.BorderSizePixel = 0
Frame40.Position = UDim2.fromOffset(264, 16)
Frame40.Size = UDim2.fromOffset(18, 18)
Frame40.ZIndex = 22
local lastUIStroke2 = Frame40
local lastFrame4 = Frame38

for _, y in ipairs({
	1.08, 9.72,
}) do
	local previousUIStroke2 = lastUIStroke2
	local previousFrame4 = lastFrame4
	previousUIStroke2.Parent = previousFrame4
	local Frame41 = Instance.new("Frame")
	Frame41.BackgroundTransparency = 1
	Frame41.BorderSizePixel = 0
	Frame41.Position = UDim2.fromOffset(0, y)
	Frame41.Size = UDim2.fromOffset(18, 7.2)
	Frame41.Rotation = 0
	Frame41.ZIndex = 22
	Frame41.Parent = Frame40
	local UICorner35 = Instance.new("UICorner")
	UICorner35.CornerRadius = UDim.new(0, 2.5200000000000005)
	UICorner35.Parent = Frame41
	local UIStroke17 = Instance.new("UIStroke")
	UIStroke17.Color = Color3.fromRGB(150, 150, 156)
	UIStroke17.Thickness = 1.6363636363636365
	lastUIStroke2 = UIStroke17
	lastFrame4 = Frame41
end

lastUIStroke2.Parent = lastFrame4
local Frame43 = Instance.new("Frame")
Frame43.AnchorPoint = Vector2.new(0.5, 0.5)
Frame43.BackgroundColor3 = Color3.fromRGB(150, 150, 156)
Frame43.BorderSizePixel = 0
Frame43.Position = UDim2.fromOffset(3.96, 4.68)
Frame43.Size = UDim2.fromOffset(2.6181818181818186, 2.6181818181818186)
Frame43.Rotation = 0
Frame43.ZIndex = 22
Frame43.Parent = Frame40
local UICorner37 = Instance.new("UICorner")
UICorner37.CornerRadius = UDim.new(0, 1.3090909090909093)
UICorner37.Parent = Frame43
local lastFrame5 = Instance.new("Frame")
lastFrame5.AnchorPoint = Vector2.new(0.5, 0.5)
lastFrame5.BackgroundColor3 = Color3.fromRGB(150, 150, 156)
lastFrame5.BorderSizePixel = 0
lastFrame5.Position = UDim2.fromOffset(3.96, 13.32)
lastFrame5.Size = UDim2.fromOffset(2.6181818181818186, 2.6181818181818186)
lastFrame5.Rotation = 0
lastFrame5.ZIndex = 22
lastFrame5.Parent = Frame40
local lastUICorner3 = Instance.new("UICorner")
lastUICorner3.CornerRadius = UDim.new(0, 1.3090909090909093)
lastUICorner3.Parent = lastFrame5
local TextLabel11 = Instance.new("TextLabel")
TextLabel11.BackgroundTransparency = 1
TextLabel11.BorderSizePixel = 0
TextLabel11.Font = Enum.Font.GothamBold
TextLabel11.TextSize = 20
TextLabel11.TextColor3 = Color3.fromRGB(245, 245, 247)
TextLabel11.Text = ""
TextLabel11.Position = UDim2.fromOffset(18, 44)
TextLabel11.Size = UDim2.fromOffset(90, 24)
TextLabel11.TextXAlignment = Enum.TextXAlignment.Left
TextLabel11.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel11.ZIndex = 20
TextLabel11.Parent = Frame38
local TextLabel12 = Instance.new("TextLabel")
TextLabel12.BackgroundTransparency = 1
TextLabel12.BorderSizePixel = 0
TextLabel12.Font = Enum.Font.GothamMedium
TextLabel12.TextSize = 11
TextLabel12.TextColor3 = Color3.fromRGB(150, 150, 156)
TextLabel12.Text = "Players"
TextLabel12.Position = UDim2.fromOffset(18, 68)
TextLabel12.Size = UDim2.fromOffset(90, 14)
TextLabel12.TextXAlignment = Enum.TextXAlignment.Left
TextLabel12.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel12.ZIndex = 20
TextLabel12.Parent = Frame38
local TextLabel13 = Instance.new("TextLabel")
TextLabel13.BackgroundTransparency = 1
TextLabel13.BorderSizePixel = 0
TextLabel13.Font = Enum.Font.GothamBold
TextLabel13.TextSize = 20
TextLabel13.TextColor3 = Color3.fromRGB(245, 245, 247)
TextLabel13.Text = ""
TextLabel13.Position = UDim2.fromOffset(112, 44)
TextLabel13.Size = UDim2.fromOffset(90, 24)
TextLabel13.TextXAlignment = Enum.TextXAlignment.Left
TextLabel13.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel13.ZIndex = 20
TextLabel13.Parent = Frame38
local TextLabel14 = Instance.new("TextLabel")
TextLabel14.BackgroundTransparency = 1
TextLabel14.BorderSizePixel = 0
TextLabel14.Font = Enum.Font.GothamMedium
TextLabel14.TextSize = 11
TextLabel14.TextColor3 = Color3.fromRGB(150, 150, 156)
TextLabel14.Text = "Ping"
TextLabel14.Position = UDim2.fromOffset(112, 68)
TextLabel14.Size = UDim2.fromOffset(90, 14)
TextLabel14.TextXAlignment = Enum.TextXAlignment.Left
TextLabel14.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel14.ZIndex = 20
TextLabel14.Parent = Frame38
local TextLabel15 = Instance.new("TextLabel")
TextLabel15.BackgroundTransparency = 1
TextLabel15.BorderSizePixel = 0
TextLabel15.Font = Enum.Font.GothamBold
TextLabel15.TextSize = 20
TextLabel15.TextColor3 = Color3.fromRGB(245, 245, 247)
TextLabel15.Text = ""
TextLabel15.Position = UDim2.fromOffset(206, 44)
TextLabel15.Size = UDim2.fromOffset(90, 24)
TextLabel15.TextXAlignment = Enum.TextXAlignment.Left
TextLabel15.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel15.ZIndex = 20
TextLabel15.Parent = Frame38
local TextLabel16 = Instance.new("TextLabel")
TextLabel16.BackgroundTransparency = 1
TextLabel16.BorderSizePixel = 0
TextLabel16.Font = Enum.Font.GothamMedium
TextLabel16.TextSize = 11
TextLabel16.TextColor3 = Color3.fromRGB(150, 150, 156)
TextLabel16.Text = "Uptime"
TextLabel16.Position = UDim2.fromOffset(206, 68)
TextLabel16.Size = UDim2.fromOffset(90, 14)
TextLabel16.TextXAlignment = Enum.TextXAlignment.Left
TextLabel16.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel16.ZIndex = 20
TextLabel16.Parent = Frame38
local TextButton4 = Instance.new("TextButton")
TextButton4.Text = ""
TextButton4.AutoButtonColor = false
TextButton4.BorderSizePixel = 0
TextButton4.Position = UDim2.fromOffset(18, 97)
TextButton4.Size = UDim2.fromOffset(124, 30)
TextButton4.ZIndex = 20
TextButton4.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton4.Parent = Frame38
local UICorner39 = Instance.new("UICorner")
UICorner39.CornerRadius = UDim.new(0, 15)
UICorner39.Parent = TextButton4
local UIGradient18 = Instance.new("UIGradient")
UIGradient18.Rotation = 90
UIGradient18.Color = ColorSequence.new(Color3.fromRGB(46, 46, 49), Color3.fromRGB(32, 32, 35))
UIGradient18.Parent = TextButton4
local UIStroke19 = Instance.new("UIStroke")
UIStroke19.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke19.Color = Color3.new(1, 1, 1)
UIStroke19.Thickness = 1
UIStroke19.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke19.Parent = TextButton4
local UIGradient19 = Instance.new("UIGradient")
UIGradient19.Rotation = 90
UIGradient19.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.86), NumberSequenceKeypoint.new(0.4, 0.96), NumberSequenceKeypoint.new(1, 0.97) })
UIGradient19.Parent = UIStroke19
local Frame45 = Instance.new("Frame")
Frame45.Size = UDim2.fromScale(1, 1)
Frame45.BackgroundColor3 = Color3.new(1, 1, 1)
Frame45.BackgroundTransparency = 1
Frame45.BorderSizePixel = 0
Frame45.ZIndex = 21
Frame45.Parent = TextButton4
local UICorner40 = Instance.new("UICorner")
UICorner40.CornerRadius = UDim.new(0, 15)
UICorner40.Parent = Frame45

TextButton4.MouseEnter:Connect(function()
	local tween19 = TweenService:Create(Frame45, TweenInfo.new(0.18), { BackgroundTransparency = 0.95 })
	tween19:Play()
end)

TextButton4.MouseLeave:Connect(function()
	local tween20 = TweenService:Create(Frame45, TweenInfo.new(0.18), { BackgroundTransparency = 1 })
	tween20:Play()
end)

local Frame46 = Instance.new("Frame")
Frame46.BackgroundTransparency = 1
Frame46.BorderSizePixel = 0
Frame46.Position = UDim2.fromOffset(12, 8)
Frame46.Size = UDim2.fromOffset(14, 14)
Frame46.ZIndex = 22
Frame46.Parent = TextButton4
local Frame47 = Instance.new("Frame")
Frame47.BackgroundTransparency = 1
Frame47.BorderSizePixel = 0
Frame47.Position = UDim2.fromOffset(1.4000000000000001, 1.9600000000000002)
Frame47.Size = UDim2.fromOffset(11.200000000000001, 11.200000000000001)
Frame47.Rotation = 0
Frame47.ZIndex = 22
Frame47.Parent = Frame46
local UICorner41 = Instance.new("UICorner")
UICorner41.CornerRadius = UDim.new(0, 5.6000000000000005)
UICorner41.Parent = Frame47
local UIStroke20 = Instance.new("UIStroke")
UIStroke20.Color = Color3.fromRGB(245, 245, 247)
UIStroke20.Thickness = 1.4
UIStroke20.Parent = Frame47
local Frame48 = Instance.new("Frame")
Frame48.AnchorPoint = Vector2.new(0.5, 0.5)
Frame48.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
Frame48.BorderSizePixel = 0
Frame48.Position = UDim2.fromOffset(10.08, 1.9600000000000002)
Frame48.Size = UDim2.fromOffset(4.2, 1.4)
Frame48.Rotation = 0
Frame48.ZIndex = 22
Frame48.Parent = Frame46
local UICorner42 = Instance.new("UICorner")
UICorner42.CornerRadius = UDim.new(0, 0.7)
UICorner42.Parent = Frame48
local lastFrame6 = Instance.new("Frame")
lastFrame6.AnchorPoint = Vector2.new(0.5, 0.5)
lastFrame6.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
lastFrame6.BorderSizePixel = 0
lastFrame6.Position = UDim2.fromOffset(10.08, 1.9600000000000002)
lastFrame6.Size = UDim2.fromOffset(3.08, 1.4)
lastFrame6.Rotation = 60
lastFrame6.ZIndex = 22
lastFrame6.Parent = Frame46
local lastUICorner4 = Instance.new("UICorner")
lastUICorner4.CornerRadius = UDim.new(0, 0.7)
lastUICorner4.Parent = lastFrame6
local TextLabel17 = Instance.new("TextLabel")
TextLabel17.BackgroundTransparency = 1
TextLabel17.BorderSizePixel = 0
TextLabel17.Font = Enum.Font.GothamBold
TextLabel17.TextSize = 12
TextLabel17.TextColor3 = Color3.fromRGB(245, 245, 247)
TextLabel17.Text = "Rejoin"
TextLabel17.Position = UDim2.fromOffset(32, 0)
TextLabel17.Size = UDim2.fromOffset(86, 30)
TextLabel17.TextXAlignment = Enum.TextXAlignment.Left
TextLabel17.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel17.ZIndex = 20
TextLabel17.Parent = TextButton4
TextLabel17.ZIndex = 22

TextButton4.Activated:Connect(function(inputObject4, clickCount4)
	FlexozyClick.SoundId = "rbxasset://https://gitlab.com/PrismSoftworks/novoline/-/raw/main/assets/click.mp3"
	FlexozyClick.TimePosition = 0
	FlexozyClick:Play()
	local FlexozyNotify3 = Instance.new("Sound")
	FlexozyNotify3.Name = "FlexozyNotify"
	FlexozyNotify3.SoundId = "rbxassetid://255881176"
	FlexozyNotify3.Volume = 0.4
	FlexozyNotify3.RollOffMaxDistance = 0
	FlexozyNotify3.Parent = SoundService
	FlexozyNotify3:Play()
	Debris:AddItem(FlexozyNotify3, 4)
	Toasts:GetChildren()
	local Frame103 = Instance.new("Frame")
	Frame103.BackgroundTransparency = 1
	Frame103.BorderSizePixel = 0
	Frame103.Size = UDim2.fromOffset(300, 56)
	Frame103.LayoutOrder = 3
	Frame103.Parent = Toasts
	local CanvasGroup5 = Instance.new("CanvasGroup")
	CanvasGroup5.Size = UDim2.fromScale(1, 1)
	CanvasGroup5.Position = UDim2.fromOffset(0, 26)
	CanvasGroup5.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
	CanvasGroup5.BackgroundTransparency = 0.06
	CanvasGroup5.BorderSizePixel = 0
	CanvasGroup5.GroupTransparency = 1
	CanvasGroup5.ZIndex = 40
	CanvasGroup5.Parent = Frame103
	local UICorner101 = Instance.new("UICorner")
	UICorner101.CornerRadius = UDim.new(0, 28)
	UICorner101.Parent = CanvasGroup5
	local UIStroke44 = Instance.new("UIStroke")
	UIStroke44.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke44.Color = Color3.new(1, 1, 1)
	UIStroke44.Thickness = 1
	UIStroke44.BorderStrokePosition = Enum.BorderStrokePosition.Inner
	UIStroke44.Parent = CanvasGroup5
	local UIGradient36 = Instance.new("UIGradient")
	UIGradient36.Rotation = 90
	UIGradient36.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.78), NumberSequenceKeypoint.new(0.5, 0.9), NumberSequenceKeypoint.new(1, 0.74) })
	UIGradient36.Parent = UIStroke44
	local Frame104 = Instance.new("Frame")
	Frame104.Position = UDim2.fromOffset(12, 12)
	Frame104.Size = UDim2.fromOffset(32, 32)
	Frame104.BackgroundTransparency = 0.88
	Frame104.BorderSizePixel = 0
	Frame104.ZIndex = 20
	Frame104.Parent = CanvasGroup5
	local UICorner102 = Instance.new("UICorner")
	UICorner102.CornerRadius = UDim.new(0, 16)
	UICorner102.Parent = Frame104
	local TextLabel36 = Instance.new("TextLabel")
	TextLabel36.BackgroundTransparency = 1
	TextLabel36.BorderSizePixel = 0
	TextLabel36.Font = Enum.Font.GothamBold
	TextLabel36.TextSize = 13
	TextLabel36.TextColor3 = Color3.fromRGB(245, 245, 247)
	TextLabel36.Text = "Rejoin"
	TextLabel36.Position = UDim2.fromOffset(54, 10)
	TextLabel36.Size = UDim2.fromOffset(232, 18)
	TextLabel36.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel36.TextTruncate = Enum.TextTruncate.AtEnd
	TextLabel36.ZIndex = 20
	TextLabel36.Parent = CanvasGroup5
	local TextLabel37 = Instance.new("TextLabel")
	TextLabel37.BackgroundTransparency = 1
	TextLabel37.BorderSizePixel = 0
	TextLabel37.Font = Enum.Font.GothamMedium
	TextLabel37.TextSize = 12
	TextLabel37.TextColor3 = Color3.fromRGB(150, 150, 156)
	TextLabel37.Text = "Rejoining this server..."
	TextLabel37.Position = UDim2.fromOffset(54, 29)
	TextLabel37.Size = UDim2.fromOffset(232, 16)
	TextLabel37.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel37.TextTruncate = Enum.TextTruncate.AtEnd
	TextLabel37.ZIndex = 20
	TextLabel37.Parent = CanvasGroup5
	Frame104.ZIndex = 50
	Frame104:GetDescendants()
	TextLabel36.ZIndex = 50
	TextLabel36:GetDescendants()
	TextLabel37.ZIndex = 50
	TextLabel37:GetDescendants()
	Frame104.BackgroundColor3 = Color3.new(1, 1, 1)
	local Frame105 = Instance.new("Frame")
	Frame105.BackgroundTransparency = 1
	Frame105.BorderSizePixel = 0
	Frame105.Position = UDim2.fromOffset(8, 8)
	Frame105.Size = UDim2.fromOffset(16, 16)
	Frame105.ZIndex = 22
	Frame105.Parent = Frame104
	local Frame106 = Instance.new("Frame")
	Frame106.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame106.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
	Frame106.BorderSizePixel = 0
	Frame106.Position = UDim2.fromOffset(5.44, 9.92)
	Frame106.Size = UDim2.fromOffset(5.44, 1.8909090909090911)
	Frame106.Rotation = 45
	Frame106.ZIndex = 22
	Frame106.Parent = Frame105
	local UICorner103 = Instance.new("UICorner")
	UICorner103.CornerRadius = UDim.new(0, 0.94545454545454555)
	UICorner103.Parent = Frame106
	local Frame107 = Instance.new("Frame")
	Frame107.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame107.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
	Frame107.BorderSizePixel = 0
	Frame107.Position = UDim2.fromOffset(9.6, 8)
	Frame107.Size = UDim2.fromOffset(10.24, 1.8909090909090911)
	Frame107.Rotation = -50
	Frame107.ZIndex = 22
	Frame107.Parent = Frame105
	local UICorner104 = Instance.new("UICorner")
	UICorner104.CornerRadius = UDim.new(0, 0.94545454545454555)
	UICorner104.Parent = Frame107
	Frame105.ZIndex = 52
	Frame105:GetDescendants()
	Frame106.ZIndex = 52
	Frame107.ZIndex = 52
	local tween21 = TweenService:Create(CanvasGroup5, TweenInfo.new(0.42, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { GroupTransparency = 0, Position = UDim2.fromOffset(0, 0) })
	tween21:Play()

	task.delay(2.8, function()
	end)

	TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
end)

local TextButton5 = Instance.new("TextButton")
TextButton5.Text = ""
TextButton5.AutoButtonColor = false
TextButton5.BorderSizePixel = 0
TextButton5.Position = UDim2.fromOffset(150, 97)
TextButton5.Size = UDim2.fromOffset(132, 30)
TextButton5.ZIndex = 20
TextButton5.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton5.Parent = Frame38
local UICorner44 = Instance.new("UICorner")
UICorner44.CornerRadius = UDim.new(0, 15)
UICorner44.Parent = TextButton5
local UIGradient20 = Instance.new("UIGradient")
UIGradient20.Rotation = 90
UIGradient20.Color = ColorSequence.new(Color3.fromRGB(46, 46, 49), Color3.fromRGB(32, 32, 35))
UIGradient20.Parent = TextButton5
local UIStroke21 = Instance.new("UIStroke")
UIStroke21.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke21.Color = Color3.new(1, 1, 1)
UIStroke21.Thickness = 1
UIStroke21.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke21.Parent = TextButton5
local UIGradient21 = Instance.new("UIGradient")
UIGradient21.Rotation = 90
UIGradient21.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.86), NumberSequenceKeypoint.new(0.4, 0.96), NumberSequenceKeypoint.new(1, 0.97) })
UIGradient21.Parent = UIStroke21
local Frame50 = Instance.new("Frame")
Frame50.Size = UDim2.fromScale(1, 1)
Frame50.BackgroundColor3 = Color3.new(1, 1, 1)
Frame50.BackgroundTransparency = 1
Frame50.BorderSizePixel = 0
Frame50.ZIndex = 21
Frame50.Parent = TextButton5
local UICorner45 = Instance.new("UICorner")
UICorner45.CornerRadius = UDim.new(0, 15)
UICorner45.Parent = Frame50

TextButton5.MouseEnter:Connect(function()
	local tween22 = TweenService:Create(Frame50, TweenInfo.new(0.18), { BackgroundTransparency = 0.95 })
	tween22:Play()
end)

TextButton5.MouseLeave:Connect(function()
	local tween23 = TweenService:Create(Frame50, TweenInfo.new(0.18), { BackgroundTransparency = 1 })
	tween23:Play()
end)

local Frame51 = Instance.new("Frame")
Frame51.BackgroundTransparency = 1
Frame51.BorderSizePixel = 0
Frame51.Position = UDim2.fromOffset(12, 8)
Frame51.Size = UDim2.fromOffset(14, 14)
Frame51.ZIndex = 22
Frame51.Parent = TextButton5
local Frame52 = Instance.new("Frame")
Frame52.AnchorPoint = Vector2.new(0.5, 0.5)
Frame52.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
Frame52.BorderSizePixel = 0
Frame52.Position = UDim2.fromOffset(7, 4.2)
Frame52.Size = UDim2.fromOffset(11.760000000000002, 1.4)
Frame52.Rotation = 0
local lastFrame8 = Frame52

for _, item in ipairs({
	{ x = 11.620000000000001, y = 2.9400000000000004, x2 = 4.2, rotation = 45, x3 = 11.620000000000001, y2 = 5.46 },
	{ x = 7, y = 9.7999999999999989, x2 = 11.760000000000002, rotation = 0, x3 = 2.38, y2 = 8.54 },
}) do
	local previousFrame8 = lastFrame8
	previousFrame8.ZIndex = 22
	previousFrame8.Parent = Frame51
	local UICorner46 = Instance.new("UICorner")
	UICorner46.CornerRadius = UDim.new(0, 0.7)
	UICorner46.Parent = previousFrame8
	local lastFrame7 = Instance.new("Frame")
	lastFrame7.AnchorPoint = Vector2.new(0.5, 0.5)
	lastFrame7.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
	lastFrame7.BorderSizePixel = 0
	lastFrame7.Position = UDim2.fromOffset(item.x, item.y)
	lastFrame7.Size = UDim2.fromOffset(item.x2, 1.4)
	lastFrame7.Rotation = item.rotation
	lastFrame7.ZIndex = 22
	lastFrame7.Parent = Frame51
	local lastUICorner5 = Instance.new("UICorner")
	lastUICorner5.CornerRadius = UDim.new(0, 0.7)
	lastUICorner5.Parent = lastFrame7
	local Frame54 = Instance.new("Frame")
	Frame54.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame54.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
	Frame54.BorderSizePixel = 0
	Frame54.Position = UDim2.fromOffset(item.x3, item.y2)
	Frame54.Size = UDim2.fromOffset(4.2, 1.4)
	Frame54.Rotation = -45
	lastFrame8 = Frame54
end

lastFrame8.ZIndex = 22
lastFrame8.Parent = Frame51
local UICorner50 = Instance.new("UICorner")
UICorner50.CornerRadius = UDim.new(0, 0.7)
UICorner50.Parent = lastFrame8
local Frame57 = Instance.new("Frame")
Frame57.AnchorPoint = Vector2.new(0.5, 0.5)
Frame57.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
Frame57.BorderSizePixel = 0
Frame57.Position = UDim2.fromOffset(2.38, 11.059999999999999)
Frame57.Size = UDim2.fromOffset(4.2, 1.4)
Frame57.Rotation = 45
Frame57.ZIndex = 22
Frame57.Parent = Frame51
local UICorner51 = Instance.new("UICorner")
UICorner51.CornerRadius = UDim.new(0, 0.7)
UICorner51.Parent = Frame57
local TextLabel18 = Instance.new("TextLabel")
TextLabel18.BackgroundTransparency = 1
TextLabel18.BorderSizePixel = 0
TextLabel18.Font = Enum.Font.GothamBold
TextLabel18.TextSize = 12
TextLabel18.TextColor3 = Color3.fromRGB(245, 245, 247)
TextLabel18.Text = "Server hop"
TextLabel18.Position = UDim2.fromOffset(32, 0)
TextLabel18.Size = UDim2.fromOffset(94, 30)
TextLabel18.TextXAlignment = Enum.TextXAlignment.Left
TextLabel18.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel18.ZIndex = 20
TextLabel18.Parent = TextButton5
TextLabel18.ZIndex = 22

TextButton5.Activated:Connect(function(inputObject5, clickCount5)
	FlexozyClick.SoundId = "rbxasset://https://gitlab.com/PrismSoftworks/novoline/-/raw/main/assets/click.mp3"
	FlexozyClick.TimePosition = 0
	FlexozyClick:Play()
	local FlexozyNotify4 = Instance.new("Sound")
	FlexozyNotify4.Name = "FlexozyNotify"
	FlexozyNotify4.SoundId = "rbxassetid://255881176"
	FlexozyNotify4.Volume = 0.4
	FlexozyNotify4.RollOffMaxDistance = 0
	FlexozyNotify4.Parent = SoundService
	FlexozyNotify4:Play()
	Debris:AddItem(FlexozyNotify4, 4)
	Toasts:GetChildren()
	local Frame108 = Instance.new("Frame")
	Frame108.BackgroundTransparency = 1
	Frame108.BorderSizePixel = 0
	Frame108.Size = UDim2.fromOffset(300, 56)
	Frame108.LayoutOrder = 4
	Frame108.Parent = Toasts
	local CanvasGroup6 = Instance.new("CanvasGroup")
	CanvasGroup6.Size = UDim2.fromScale(1, 1)
	CanvasGroup6.Position = UDim2.fromOffset(0, 26)
	CanvasGroup6.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
	CanvasGroup6.BackgroundTransparency = 0.06
	CanvasGroup6.BorderSizePixel = 0
	CanvasGroup6.GroupTransparency = 1
	CanvasGroup6.ZIndex = 40
	CanvasGroup6.Parent = Frame108
	local UICorner105 = Instance.new("UICorner")
	UICorner105.CornerRadius = UDim.new(0, 28)
	UICorner105.Parent = CanvasGroup6
	local UIStroke45 = Instance.new("UIStroke")
	UIStroke45.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke45.Color = Color3.new(1, 1, 1)
	UIStroke45.Thickness = 1
	UIStroke45.BorderStrokePosition = Enum.BorderStrokePosition.Inner
	UIStroke45.Parent = CanvasGroup6
	local UIGradient37 = Instance.new("UIGradient")
	UIGradient37.Rotation = 90
	UIGradient37.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.78), NumberSequenceKeypoint.new(0.5, 0.9), NumberSequenceKeypoint.new(1, 0.74) })
	UIGradient37.Parent = UIStroke45
	local Frame109 = Instance.new("Frame")
	Frame109.Position = UDim2.fromOffset(12, 12)
	Frame109.Size = UDim2.fromOffset(32, 32)
	Frame109.BackgroundTransparency = 0.88
	Frame109.BorderSizePixel = 0
	Frame109.ZIndex = 20
	Frame109.Parent = CanvasGroup6
	local UICorner106 = Instance.new("UICorner")
	UICorner106.CornerRadius = UDim.new(0, 16)
	UICorner106.Parent = Frame109
	local TextLabel38 = Instance.new("TextLabel")
	TextLabel38.BackgroundTransparency = 1
	TextLabel38.BorderSizePixel = 0
	TextLabel38.Font = Enum.Font.GothamBold
	TextLabel38.TextSize = 13
	TextLabel38.TextColor3 = Color3.fromRGB(245, 245, 247)
	TextLabel38.Text = "Server hop"
	TextLabel38.Position = UDim2.fromOffset(54, 10)
	TextLabel38.Size = UDim2.fromOffset(232, 18)
	TextLabel38.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel38.TextTruncate = Enum.TextTruncate.AtEnd
	TextLabel38.ZIndex = 20
	TextLabel38.Parent = CanvasGroup6
	local TextLabel39 = Instance.new("TextLabel")
	TextLabel39.BackgroundTransparency = 1
	TextLabel39.BorderSizePixel = 0
	TextLabel39.Font = Enum.Font.GothamMedium
	TextLabel39.TextSize = 12
	TextLabel39.TextColor3 = Color3.fromRGB(150, 150, 156)
	TextLabel39.Text = "Searching for a new server..."
	TextLabel39.Position = UDim2.fromOffset(54, 29)
	TextLabel39.Size = UDim2.fromOffset(232, 16)
	TextLabel39.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel39.TextTruncate = Enum.TextTruncate.AtEnd
	TextLabel39.ZIndex = 20
	TextLabel39.Parent = CanvasGroup6
	Frame109.ZIndex = 50
	Frame109:GetDescendants()
	TextLabel38.ZIndex = 50
	TextLabel38:GetDescendants()
	TextLabel39.ZIndex = 50
	TextLabel39:GetDescendants()
	Frame109.BackgroundColor3 = Color3.new(1, 1, 1)
	local Frame110 = Instance.new("Frame")
	Frame110.BackgroundTransparency = 1
	Frame110.BorderSizePixel = 0
	Frame110.Position = UDim2.fromOffset(8, 8)
	Frame110.Size = UDim2.fromOffset(16, 16)
	Frame110.ZIndex = 22
	Frame110.Parent = Frame109
	local Frame111 = Instance.new("Frame")
	Frame111.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame111.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
	Frame111.BorderSizePixel = 0
	Frame111.Position = UDim2.fromOffset(5.44, 9.92)
	Frame111.Size = UDim2.fromOffset(5.44, 1.8909090909090911)
	Frame111.Rotation = 45
	Frame111.ZIndex = 22
	Frame111.Parent = Frame110
	local UICorner107 = Instance.new("UICorner")
	UICorner107.CornerRadius = UDim.new(0, 0.94545454545454555)
	UICorner107.Parent = Frame111
	local Frame112 = Instance.new("Frame")
	Frame112.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame112.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
	Frame112.BorderSizePixel = 0
	Frame112.Position = UDim2.fromOffset(9.6, 8)
	Frame112.Size = UDim2.fromOffset(10.24, 1.8909090909090911)
	Frame112.Rotation = -50
	Frame112.ZIndex = 22
	Frame112.Parent = Frame110
	local UICorner108 = Instance.new("UICorner")
	UICorner108.CornerRadius = UDim.new(0, 0.94545454545454555)
	UICorner108.Parent = Frame112
	Frame110.ZIndex = 52
	Frame110:GetDescendants()
	Frame111.ZIndex = 52
	Frame112.ZIndex = 52
	local tween24 = TweenService:Create(CanvasGroup6, TweenInfo.new(0.42, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { GroupTransparency = 0, Position = UDim2.fromOffset(0, 0) })
	tween24:Play()

	task.delay(2.8, function()
	end)

	task.spawn(function(...)
		local response = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
		local data = HttpService:JSONDecode(response)

		for i, v in ipairs(data.data) do
			-- condition: v.playing < v.maxPlayers  (assumed true)
			local FlexozyNotify5 = Instance.new("Sound")
			FlexozyNotify5.Name = "FlexozyNotify"
			FlexozyNotify5.SoundId = "rbxassetid://255881176"
			FlexozyNotify5.Volume = 0.4
			FlexozyNotify5.RollOffMaxDistance = 0
			FlexozyNotify5.Parent = SoundService
			FlexozyNotify5:Play()
			Debris:AddItem(FlexozyNotify5, 4)
			Toasts:GetChildren()
			Frame93:Destroy()
			local Frame113 = Instance.new("Frame")
			Frame113.BackgroundTransparency = 1
			Frame113.BorderSizePixel = 0
			Frame113.Size = UDim2.fromOffset(300, 56)
			Frame113.LayoutOrder = 5
			Frame113.Parent = Toasts
			local CanvasGroup7 = Instance.new("CanvasGroup")
			CanvasGroup7.Size = UDim2.fromScale(1, 1)
			CanvasGroup7.Position = UDim2.fromOffset(0, 26)
			CanvasGroup7.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
			CanvasGroup7.BackgroundTransparency = 0.06
			CanvasGroup7.BorderSizePixel = 0
			CanvasGroup7.GroupTransparency = 1
			CanvasGroup7.ZIndex = 40
			CanvasGroup7.Parent = Frame113
			local UICorner109 = Instance.new("UICorner")
			UICorner109.CornerRadius = UDim.new(0, 28)
			UICorner109.Parent = CanvasGroup7
			local UIStroke46 = Instance.new("UIStroke")
			UIStroke46.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke46.Color = Color3.new(1, 1, 1)
			UIStroke46.Thickness = 1
			UIStroke46.BorderStrokePosition = Enum.BorderStrokePosition.Inner
			UIStroke46.Parent = CanvasGroup7
			local UIGradient38 = Instance.new("UIGradient")
			UIGradient38.Rotation = 90
			UIGradient38.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.78), NumberSequenceKeypoint.new(0.5, 0.9), NumberSequenceKeypoint.new(1, 0.74) })
			UIGradient38.Parent = UIStroke46
			local Frame114 = Instance.new("Frame")
			Frame114.Position = UDim2.fromOffset(12, 12)
			Frame114.Size = UDim2.fromOffset(32, 32)
			Frame114.BackgroundTransparency = 0.88
			Frame114.BorderSizePixel = 0
			Frame114.ZIndex = 20
			Frame114.Parent = CanvasGroup7
			local UICorner110 = Instance.new("UICorner")
			UICorner110.CornerRadius = UDim.new(0, 16)
			UICorner110.Parent = Frame114
			local TextLabel40 = Instance.new("TextLabel")
			TextLabel40.BackgroundTransparency = 1
			TextLabel40.BorderSizePixel = 0
			TextLabel40.Font = Enum.Font.GothamBold
			TextLabel40.TextSize = 13
			TextLabel40.TextColor3 = Color3.fromRGB(245, 245, 247)
			TextLabel40.Text = "Server hop"
			TextLabel40.Position = UDim2.fromOffset(54, 10)
			TextLabel40.Size = UDim2.fromOffset(232, 18)
			TextLabel40.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel40.TextTruncate = Enum.TextTruncate.AtEnd
			TextLabel40.ZIndex = 20
			TextLabel40.Parent = CanvasGroup7
			local TextLabel41 = Instance.new("TextLabel")
			TextLabel41.BackgroundTransparency = 1
			TextLabel41.BorderSizePixel = 0
			TextLabel41.Font = Enum.Font.GothamMedium
			TextLabel41.TextSize = 12
			TextLabel41.TextColor3 = Color3.fromRGB(150, 150, 156)
			TextLabel41.Text = "Server found, teleporting"
			TextLabel41.Position = UDim2.fromOffset(54, 29)
			TextLabel41.Size = UDim2.fromOffset(232, 16)
			TextLabel41.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel41.TextTruncate = Enum.TextTruncate.AtEnd
			TextLabel41.ZIndex = 20
			TextLabel41.Parent = CanvasGroup7
			Frame114.ZIndex = 50
			Frame114:GetDescendants()
			TextLabel40.ZIndex = 50
			TextLabel40:GetDescendants()
			TextLabel41.ZIndex = 50
			TextLabel41:GetDescendants()
			Frame114.BackgroundColor3 = Color3.new(1, 1, 1)
			local Frame115 = Instance.new("Frame")
			Frame115.BackgroundTransparency = 1
			Frame115.BorderSizePixel = 0
			Frame115.Position = UDim2.fromOffset(8, 8)
			Frame115.Size = UDim2.fromOffset(16, 16)
			Frame115.ZIndex = 22
			Frame115.Parent = Frame114
			local Frame116 = Instance.new("Frame")
			Frame116.AnchorPoint = Vector2.new(0.5, 0.5)
			Frame116.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
			Frame116.BorderSizePixel = 0
			Frame116.Position = UDim2.fromOffset(5.44, 9.92)
			Frame116.Size = UDim2.fromOffset(5.44, 1.8909090909090911)
			Frame116.Rotation = 45
			Frame116.ZIndex = 22
			Frame116.Parent = Frame115
			local UICorner111 = Instance.new("UICorner")
			UICorner111.CornerRadius = UDim.new(0, 0.94545454545454555)
			UICorner111.Parent = Frame116
			local Frame117 = Instance.new("Frame")
			Frame117.AnchorPoint = Vector2.new(0.5, 0.5)
			Frame117.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
			Frame117.BorderSizePixel = 0
			Frame117.Position = UDim2.fromOffset(9.6, 8)
			Frame117.Size = UDim2.fromOffset(10.24, 1.8909090909090911)
			Frame117.Rotation = -50
			Frame117.ZIndex = 22
			Frame117.Parent = Frame115
			local UICorner112 = Instance.new("UICorner")
			UICorner112.CornerRadius = UDim.new(0, 0.94545454545454555)
			UICorner112.Parent = Frame117
			Frame115.ZIndex = 52
			Frame115:GetDescendants()
			Frame116.ZIndex = 52
			Frame117.ZIndex = 52
			local tween25 = TweenService:Create(CanvasGroup7, TweenInfo.new(0.42, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { GroupTransparency = 0, Position = UDim2.fromOffset(0, 0) })
			tween25:Play()

			task.delay(2.8, function()
			end)

			TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id, Players.LocalPlayer)
		end
	end)
end)

local Frame58 = Instance.new("Frame")
Frame58.AnchorPoint = Vector2.new(1, 1)
Frame58.Size = UDim2.fromOffset(300, 173)
Frame58.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
Frame58.BackgroundTransparency = 0.12
Frame58.BorderSizePixel = 0
Frame58.ClipsDescendants = true
Frame58.ZIndex = 14
Frame58.Parent = Frame2
local UICorner52 = Instance.new("UICorner")
UICorner52.CornerRadius = UDim.new(0, 28)
UICorner52.Parent = Frame58
local Frame59 = Instance.new("Frame")
Frame59.Size = UDim2.fromScale(1, 1)
Frame59.BackgroundColor3 = Color3.new(1, 1, 1)
Frame59.BorderSizePixel = 0
Frame59.ZIndex = 15
Frame59.Parent = Frame58
local UICorner53 = Instance.new("UICorner")
UICorner53.CornerRadius = UDim.new(0, 28)
UICorner53.Parent = Frame59
local UIGradient22 = Instance.new("UIGradient")
UIGradient22.Rotation = 90
UIGradient22.Color = ColorSequence.new(Color3.fromRGB(70, 70, 76), Color3.fromRGB(20, 20, 23))
UIGradient22.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(1, 1) })
UIGradient22.Parent = Frame59
local UIStroke22 = Instance.new("UIStroke")
UIStroke22.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke22.Color = Color3.new(1, 1, 1)
UIStroke22.Thickness = 1
UIStroke22.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke22.Parent = Frame58
local UIGradient23 = Instance.new("UIGradient")
UIGradient23.Rotation = 90
UIGradient23.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.84), NumberSequenceKeypoint.new(0.5, 0.92), NumberSequenceKeypoint.new(1, 0.78) })
UIGradient23.Parent = UIStroke22
Frame58.Position = UDim2.new(1, 0, 1, 0)
Frame58:SetAttribute("Rise", 48)
Frame58:SetAttribute("Rest", UDim2.new(1, 0, 1, 0))
local TextLabel19 = Instance.new("TextLabel")
TextLabel19.BackgroundTransparency = 1
TextLabel19.BorderSizePixel = 0
TextLabel19.Font = Enum.Font.GothamBold
TextLabel19.TextSize = 14
TextLabel19.TextColor3 = Color3.fromRGB(245, 245, 247)
TextLabel19.Text = "Friends online"
TextLabel19.Position = UDim2.fromOffset(18, 16)
TextLabel19.Size = UDim2.fromOffset(200, 18)
TextLabel19.TextXAlignment = Enum.TextXAlignment.Left
TextLabel19.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel19.ZIndex = 20
TextLabel19.Parent = Frame58
local TextLabel20 = Instance.new("TextLabel")
TextLabel20.BackgroundTransparency = 1
TextLabel20.BorderSizePixel = 0
TextLabel20.Font = Enum.Font.GothamBold
TextLabel20.TextSize = 14
TextLabel20.TextColor3 = Color3.fromRGB(150, 150, 156)
TextLabel20.Text = ""
TextLabel20.Position = UDim2.fromOffset(200, 16)
TextLabel20.Size = UDim2.fromOffset(82, 18)
TextLabel20.TextXAlignment = Enum.TextXAlignment.Right
TextLabel20.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel20.ZIndex = 20
TextLabel20.Parent = Frame58
local TextLabel21 = Instance.new("TextLabel")
TextLabel21.BackgroundTransparency = 1
TextLabel21.BorderSizePixel = 0
TextLabel21.Font = Enum.Font.GothamMedium
TextLabel21.TextSize = 12
TextLabel21.TextColor3 = Color3.fromRGB(176, 176, 182)
TextLabel21.Text = "Looking for your friends"
TextLabel21.Position = UDim2.fromOffset(18, 104)
TextLabel21.Size = UDim2.fromOffset(264, 16)
TextLabel21.TextXAlignment = Enum.TextXAlignment.Left
TextLabel21.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel21.ZIndex = 20
TextLabel21.Parent = Frame58
local TextLabel22 = Instance.new("TextLabel")
TextLabel22.BackgroundTransparency = 1
TextLabel22.BorderSizePixel = 0
TextLabel22.Font = Enum.Font.GothamBold
TextLabel22.TextSize = 12
TextLabel22.TextColor3 = Color3.fromRGB(150, 150, 156)
TextLabel22.Text = ""
TextLabel22.Position = UDim2.fromOffset(0, 48)
TextLabel22.Size = UDim2.fromOffset(70, 36)
TextLabel22.TextXAlignment = Enum.TextXAlignment.Left
TextLabel22.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel22.ZIndex = 20
local lastUIStroke3 = TextLabel22
local lastImageLabel = Frame58

for _, item in ipairs({
	{ x = 18, zIndex = 26 },
	{ x = 45, zIndex = 25 },
	{ x = 72, zIndex = 24 },
	{ x = 99, zIndex = 23 },
	{ x = 126, zIndex = 22 },
	{ x = 153, zIndex = 21 },
}) do
	local previousUIStroke3 = lastUIStroke3
	local previousImageLabel = lastImageLabel
	previousUIStroke3.Parent = previousImageLabel
	local ImageLabel3 = Instance.new("ImageLabel")
	ImageLabel3.Position = UDim2.fromOffset(item.x, 48)
	ImageLabel3.Size = UDim2.fromOffset(36, 36)
	ImageLabel3.BackgroundColor3 = Color3.fromRGB(40, 40, 44)
	ImageLabel3.BorderSizePixel = 0
	ImageLabel3.ZIndex = item.zIndex
	ImageLabel3.Visible = false
	ImageLabel3.Parent = Frame58
	local UICorner54 = Instance.new("UICorner")
	UICorner54.CornerRadius = UDim.new(0, 18)
	UICorner54.Parent = ImageLabel3
	local UIStroke23 = Instance.new("UIStroke")
	UIStroke23.Color = Color3.fromRGB(14, 14, 16)
	UIStroke23.Thickness = 3
	lastUIStroke3 = UIStroke23
	lastImageLabel = ImageLabel3
end

lastUIStroke3.Parent = lastImageLabel

task.spawn(function()
	Players:GetPlayers()
	TextLabel11.Text = "1/0"
	local value = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
	TextLabel13.Text = math.floor(value + 0.5) .. "ms"
	TextLabel15.Text = "1m"
	task.wait(0.5)
	Players:GetPlayers()
	TextLabel11.Text = "1/0"
	local value2 = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
	TextLabel13.Text = math.floor(value2 + 0.5) .. "ms"
	TextLabel15.Text = "1m"
	task.wait(0.5)
	-- [envlog] the statements above repeat forever (loop)
end)

task.spawn(function()
	Players.LocalPlayer:GetFriendsOnline(50)
	TextLabel21.Text = "Friends could not be loaded"
	task.wait(30)
	Players.LocalPlayer:GetFriendsOnline(50)
	TextLabel21.Text = "Friends could not be loaded"
	task.wait(30)
	-- [envlog] the statements above repeat forever (loop)
end)

Frame.Visible = true
Frame2.Visible = true
local CanvasGroup = Instance.new("CanvasGroup")
CanvasGroup.AnchorPoint = Vector2.new(1, 0)
CanvasGroup.Position = UDim2.new(1, -40, 0, 20)
CanvasGroup.Size = UDim2.fromOffset(112, 38)
CanvasGroup.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
CanvasGroup.BackgroundTransparency = 0.1
CanvasGroup.BorderSizePixel = 0
CanvasGroup.GroupTransparency = 1
CanvasGroup.Visible = false
CanvasGroup.ZIndex = 30
CanvasGroup.Parent = Flexozy2
local UICorner60 = Instance.new("UICorner")
UICorner60.CornerRadius = UDim.new(0, 19)
UICorner60.Parent = CanvasGroup
local UIStroke29 = Instance.new("UIStroke")
UIStroke29.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke29.Color = Color3.new(1, 1, 1)
UIStroke29.Thickness = 1
UIStroke29.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke29.Parent = CanvasGroup
local UIGradient24 = Instance.new("UIGradient")
UIGradient24.Rotation = 90
UIGradient24.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.78), NumberSequenceKeypoint.new(0.5, 0.9), NumberSequenceKeypoint.new(1, 0.74) })
UIGradient24.Parent = UIStroke29
local Frame60 = Instance.new("Frame")
Frame60.Size = UDim2.fromScale(1, 1)
Frame60.BackgroundColor3 = Color3.new(1, 1, 1)
Frame60.BackgroundTransparency = 1
Frame60.BorderSizePixel = 0
Frame60.ZIndex = 31
Frame60.Parent = CanvasGroup
local UICorner61 = Instance.new("UICorner")
UICorner61.CornerRadius = UDim.new(0, 19)
UICorner61.Parent = Frame60
local Frame61 = Instance.new("Frame")
Frame61.BackgroundTransparency = 1
Frame61.BorderSizePixel = 0
Frame61.Position = UDim2.fromOffset(15, 11)
Frame61.Size = UDim2.fromOffset(16, 16)
Frame61.ZIndex = 22
Frame61.Parent = CanvasGroup
local Frame62 = Instance.new("Frame")
Frame62.BackgroundTransparency = 1
Frame62.BorderSizePixel = 0
Frame62.Position = UDim2.fromOffset(0, 3.2)
Frame62.Size = UDim2.fromOffset(16, 9.6)
Frame62.Rotation = 0
Frame62.ZIndex = 22
Frame62.Parent = Frame61
local UICorner62 = Instance.new("UICorner")
UICorner62.CornerRadius = UDim.new(0, 4.8)
UICorner62.Parent = Frame62
local UIStroke30 = Instance.new("UIStroke")
UIStroke30.Color = Color3.fromRGB(245, 245, 247)
UIStroke30.Thickness = 1.4545454545454546
UIStroke30.Parent = Frame62
local Frame63 = Instance.new("Frame")
Frame63.AnchorPoint = Vector2.new(0.5, 0.5)
Frame63.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
Frame63.BorderSizePixel = 0
Frame63.Position = UDim2.fromOffset(8, 8)
Frame63.Size = UDim2.fromOffset(4.48, 4.48)
Frame63.Rotation = 0
Frame63.ZIndex = 22
Frame63.Parent = Frame61
local UICorner63 = Instance.new("UICorner")
UICorner63.CornerRadius = UDim.new(0, 2.24)
UICorner63.Parent = Frame63
local TextLabel23 = Instance.new("TextLabel")
TextLabel23.BackgroundTransparency = 1
TextLabel23.BorderSizePixel = 0
TextLabel23.Font = Enum.Font.GothamBold
TextLabel23.TextSize = 12
TextLabel23.TextColor3 = Color3.fromRGB(245, 245, 247)
TextLabel23.Text = "Show UI"
TextLabel23.Position = UDim2.fromOffset(39, 0)
TextLabel23.Size = UDim2.fromOffset(66, 38)
TextLabel23.TextXAlignment = Enum.TextXAlignment.Left
TextLabel23.TextTruncate = Enum.TextTruncate.AtEnd
TextLabel23.ZIndex = 20
TextLabel23.Parent = CanvasGroup
local TextButton6 = Instance.new("TextButton")
TextButton6.Text = ""
TextButton6.AutoButtonColor = false
TextButton6.BackgroundTransparency = 1
TextButton6.BorderSizePixel = 0
TextButton6.Size = UDim2.fromScale(1, 1)
TextButton6.ZIndex = 60
TextButton6.Parent = CanvasGroup

TextButton6.MouseEnter:Connect(function()
	local tween26 = TweenService:Create(Frame60, TweenInfo.new(0.18), { BackgroundTransparency = 0.92 })
	tween26:Play()
end)

TextButton6.MouseLeave:Connect(function()
	local tween27 = TweenService:Create(Frame60, TweenInfo.new(0.18), { BackgroundTransparency = 1 })
	tween27:Play()
end)

TextButton6.Activated:Connect(function(inputObject6, clickCount6)
	FlexozyClick.SoundId = "rbxasset://https://gitlab.com/PrismSoftworks/novoline/-/raw/main/assets/click.mp3"
	FlexozyClick.TimePosition = 0
	FlexozyClick:Play()
end)

CanvasGroup:GetDescendants()
Frame61.ZIndex = 52
Frame62.ZIndex = 52
Frame63.ZIndex = 52
TextLabel23.ZIndex = 50
