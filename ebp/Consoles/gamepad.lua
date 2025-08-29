local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local cursor = Instance.new("ImageLabel")
cursor.Size = UDim2.new(0, 32, 0, 32)
cursor.Position = UDim2.new(0.5, -16, 0.5, -16)
cursor.BackgroundTransparency = 1
cursor.Image = "rbxassetid://7072717697"
cursor.Parent = screenGui

local cursorSpeed = 10
local cursorPosition = Vector2.new(cursor.AbsolutePosition.X, cursor.AbsolutePosition.Y)

UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Gamepad1 
	and input.KeyCode == Enum.KeyCode.Thumbstick1 then
		local delta = input.Position * cursorSpeed
		cursorPosition = cursorPosition + Vector2.new(delta.X, delta.Y)

		cursorPosition = Vector2.new(
			math.clamp(cursorPosition.X, 0, screenGui.AbsoluteSize.X - cursor.AbsoluteSize.X),
			math.clamp(cursorPosition.Y, 0, screenGui.AbsoluteSize.Y - cursor.AbsoluteSize.Y)
		)

		cursor.Position = UDim2.fromOffset(cursorPosition.X, cursorPosition.Y)
	end
end)

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.UserInputType == Enum.UserInputType.Gamepad1 
	and input.KeyCode == Enum.KeyCode.ButtonA then
		local guiObjects = player.PlayerGui:GetGuiObjectsAtPosition(cursorPosition.X, cursorPosition.Y)
		for _, obj in ipairs(guiObjects) do
			if obj:IsA("TextButton") or obj:IsA("ImageButton") then
				obj:Activate()
			end
		end
	end
end)