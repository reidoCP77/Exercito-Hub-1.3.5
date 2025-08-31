-- LocalScript: Botão de Correr/Andar
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local WALK_SPEED = 16
local RUN_SPEED = 30

local playerGui = player:WaitForChild("PlayerGui")

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RunWalkGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local outerButton = Instance.new("TextButton")
outerButton.Name = "RunButton"
outerButton.Size = UDim2.new(0, 60, 0, 60) -- menor
outerButton.Position = UDim2.new(0.9, 0, 0.5, -30)
outerButton.AnchorPoint = Vector2.new(0, 0)
outerButton.BackgroundTransparency = 1
outerButton.Text = ""
outerButton.BorderSizePixel = 0
outerButton.AutoButtonColor = true
outerButton.Parent = screenGui
outerButton.ClipsDescendants = true

local uiCornerOuter = Instance.new("UICorner")
uiCornerOuter.CornerRadius = UDim.new(1, 0)
uiCornerOuter.Parent = outerButton

local innerFrame = Instance.new("Frame")
innerFrame.Size = UDim2.new(0.7, 0, 0.7, 0)
innerFrame.Position = UDim2.new(0.15, 0, 0.15, 0)
innerFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
innerFrame.BackgroundTransparency = 0.5
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

-- Função para alternar correr
local function toggleRun()
    isRunning = not isRunning
    if isRunning then
        humanoid.WalkSpeed = RUN_SPEED
        label.Text = "Andar"
    else
        humanoid.WalkSpeed = WALK_SPEED
        label.Text = "Correr"
    end
end

-- Clique no botão
outerButton.MouseButton1Click:Connect(toggleRun)

-- Input do console e PC
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.LeftShift then
        toggleRun()
    elseif input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonX then
        toggleRun()
    end
end)

-- Reset ao respawn
player.CharacterAdded:Connect(function(char)
    character = char
    humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = WALK_SPEED
    isRunning = false
    label.Text = "Correr"
end)