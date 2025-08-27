-- interface primária

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- settings -->
local BLUR_SIZE_ON = 24
local BLUR_SIZE_OFF = 0
local TWEEN_TIME = 0.3

local DEVELOPER_NAMES = {
	"Creator, Mingal_amargo3",
	"Builder/Scripter, GabrielBStar2",
	"Builder/Scripter, Felipe2101778",
}

local blur = Lighting:FindFirstChild("MenuBlurEffect")
if not blur then
	blur = Instance.new("BlurEffect")
	blur.Name = "MenuBlurEffect"
	blur.Parent = Lighting
	blur.Size = BLUR_SIZE_OFF
end

local function tweenBlur(targetSize)
	TweenService:Create(blur, TweenInfo.new(TWEEN_TIME, Enum.EasingStyle.Sine), {Size = targetSize}):Play()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MainMenuGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundTransparency = 0.6
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.Parent = screenGui
mainFrame.Visible = true

local centerContainer = Instance.new("Frame")
centerContainer.Name = "CenterContainer"
centerContainer.Size = UDim2.new(0.45, 0, 0.55, 0)
centerContainer.AnchorPoint = Vector2.new(0.5, 0.5)
centerContainer.Position = UDim2.new(0.5, 0, 0.45, 0)
centerContainer.BackgroundTransparency = 1
centerContainer.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0.3, 0)
titleLabel.AnchorPoint = Vector2.new(0.5, 0)
titleLabel.Position = UDim2.new(0.5, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.Text = "Exército Brasileiro"
titleLabel.TextSize = 40
titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- amarelo
titleLabel.TextStrokeTransparency = 0.2
titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 100, 0) -- verde
titleLabel.Parent = centerContainer

-- Subtítulo "Nostalgia"
local subLabel = Instance.new("TextLabel")
subLabel.Name = "SubLabel"
subLabel.Size = UDim2.new(1, 0, 0.15, 0)
subLabel.AnchorPoint = Vector2.new(0.5, 0)
subLabel.Position = UDim2.new(0.5, 0, 0.32, 0)
subLabel.BackgroundTransparency = 1
subLabel.Font = Enum.Font.Gotham
subLabel.Text = "Nostalgia"
subLabel.TextSize = 22
subLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
subLabel.TextStrokeTransparency = 0.3
subLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
subLabel.Parent = centerContainer

-- Botões
local buttonsFrame = Instance.new("Frame")
buttonsFrame.Name = "ButtonsFrame"
buttonsFrame.BackgroundTransparency = 1
buttonsFrame.Size = UDim2.new(1, 0, 0.2, 0)
buttonsFrame.Position = UDim2.new(0, 0, 0.55, 0)
buttonsFrame.Parent = centerContainer

local uiLayout = Instance.new("UIListLayout")
uiLayout.FillDirection = Enum.FillDirection.Horizontal
uiLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiLayout.VerticalAlignment = Enum.VerticalAlignment.Center
uiLayout.Padding = UDim.new(0, 16)
uiLayout.Parent = buttonsFrame

local function createButton(name, text)
	local b = Instance.new("TextButton")
	b.Name = name
	b.Size = UDim2.new(0.45, 0, 1, 0)
	b.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	b.BorderSizePixel = 0
	b.AutoButtonColor = true
	b.Font = Enum.Font.GothamBold
	b.TextSize = 20
	b.Text = text
	b.TextColor3 = Color3.fromRGB(255, 255, 255)
	b.Parent = buttonsFrame
	local uicorner = Instance.new("UICorner", b)
	uicorner.CornerRadius = UDim.new(0, 12)
	return b
end

local creditsBtn = createButton("CreditsButton", "Créditos")
local playBtn = createButton("PlayButton", "Jogar")

local creditsFrame = Instance.new("Frame")
creditsFrame.Name = "CreditsFrame"
creditsFrame.AnchorPoint = Vector2.new(0.5, 0.5)
creditsFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
creditsFrame.Size = UDim2.new(0.6, 0, 0.6, 0)
creditsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
creditsFrame.BorderSizePixel = 0
creditsFrame.Visible = false
creditsFrame.Parent = screenGui

local creditsCorner = Instance.new("UICorner", creditsFrame)
creditsCorner.CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel")
title.Name = "CreditsTitle"
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -24, 0, 48)
title.Position = UDim2.new(0, 12, 0, 12)
title.Font = Enum.Font.GothamBold
title.Text = "Créditos"
title.TextSize = 28
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = creditsFrame

local closeCreditsBtn = Instance.new("TextButton")
closeCreditsBtn.Name = "CloseCreditsBtn"
closeCreditsBtn.Size = UDim2.new(0, 36, 0, 36)
closeCreditsBtn.AnchorPoint = Vector2.new(1, 0)
closeCreditsBtn.Position = UDim2.new(1, -12, 0, 12)
closeCreditsBtn.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
closeCreditsBtn.BorderSizePixel = 0
closeCreditsBtn.Font = Enum.Font.GothamBold
closeCreditsBtn.Text = "X"
closeCreditsBtn.TextSize = 20
closeCreditsBtn.TextColor3 = Color3.new(1,1,1)
closeCreditsBtn.Parent = creditsFrame
Instance.new("UICorner", closeCreditsBtn).CornerRadius = UDim.new(0, 8)

local namesFrame = Instance.new("ScrollingFrame")
namesFrame.Name = "NamesFrame"
namesFrame.Position = UDim2.new(0, 12, 0, 72)
namesFrame.Size = UDim2.new(1, -24, 1, -84)
namesFrame.BackgroundTransparency = 1
namesFrame.BorderSizePixel = 0
namesFrame.CanvasSize = UDim2.new(0,0,0,0)
namesFrame.ScrollBarThickness = 6
namesFrame.Parent = creditsFrame

local namesLayout = Instance.new("UIListLayout", namesFrame)
namesLayout.SortOrder = Enum.SortOrder.LayoutOrder
namesLayout.Padding = UDim.new(0, 8)

for i, nameStr in ipairs(DEVELOPER_NAMES) do
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, 0, 0, 36)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.Gotham
	lbl.TextSize = 20
	lbl.TextColor3 = Color3.fromRGB(240,240,240)
	lbl.Text = nameStr
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = namesFrame
end

local function refreshCanvasSize()
	local contentHeight = namesLayout.AbsoluteContentSize.Y
	namesFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight + 8)
end

namesLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(refreshCanvasSize)

creditsBtn.MouseButton1Click:Connect(function()
	creditsFrame.Visible = true
	tweenBlur(BLUR_SIZE_ON + 2)
end)

closeCreditsBtn.MouseButton1Click:Connect(function()
	creditsFrame.Visible = false
	tweenBlur(BLUR_SIZE_ON)
end)

playBtn.MouseButton1Click:Connect(function()
	tweenBlur(BLUR_SIZE_OFF)
	screenGui:Destroy()
	delay(TWEEN_TIME + 0.05, function()
		if blur and blur.Parent then
			blur:Destroy()
		end
	end)
end)

tweenBlur(BLUR_SIZE_ON)