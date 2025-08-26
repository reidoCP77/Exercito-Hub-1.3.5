-- LocalScript: Botão de Correr/Andar
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local WALK_SPEED = 16 -- velocidade normal
local RUN_SPEED = 30  -- velocidade de corrida

local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RunWalkGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local outerButton = Instance.new("TextButton")
outerButton.Name = "RunButton"
outerButton.Size = UDim2.new(0, 100, 0, 100) -- botão 100x100
outerButton.Position = UDim2.new(0.9, 0, 0.5, -50) -- 1/2y, d
outerButton.AnchorPoint = Vector2.new(0, 0) 
outerButton.BackgroundTransparency = 1 -- totalmente transparente
outerButton.Text = ""
outerButton.BorderSizePixel = 0
outerButton.AutoButtonColor = true
outerButton.Parent = screenGui
outerButton.ClipsDescendants = true

local uiCornerOuter = Instance.new("UICorner")
uiCornerOuter.CornerRadius = UDim.new(1, 0) -- círculo
uiCornerOuter.Parent = outerButton

local innerFrame = Instance.new("Frame")
innerFrame.Size = UDim2.new(0.7, 0, 0.7, 0)
innerFrame.Position = UDim2.new(0.15, 0, 0.15, 0)
innerFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 80) -- cinza
innerFrame.BackgroundTransparency = 0.5 -- deixa transparente
innerFrame.Parent = outerButton

local uiCornerInner = Instance.new("UICorner")
uiCornerInner.CornerRadius = UDim.new(0.2, 0)
uiCornerInner.Parent = innerFrame

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.Text = "Correr"
label.TextColor3 = Color3.fromRGB(255,255,255)
label.TextScaled = true
label.Font = Enum.Font.SourceSansBold
label.Parent = innerFrame

local isRunning = false
outerButton.MouseButton1Click:Connect(function()
	isRunning = not isRunning
	if isRunning then
		humanoid.WalkSpeed = RUN_SPEED
		label.Text = "Andar"
	else
		humanoid.WalkSpeed = WALK_SPEED
		label.Text = "Correr"
	end
end)

player.CharacterAdded:Connect(function(char)
	character = char
	humanoid = character:WaitForChild("Humanoid")
	humanoid.WalkSpeed = WALK_SPEED
	isRunning = false
	label.Text = "Correr"
end)