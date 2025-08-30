local UserInputService = game:GetService("UserInputService")

local cursorEnabled = false

UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end

	if input.KeyCode == Enum.KeyCode.ButtonX then
		cursorEnabled = not cursorEnabled
		UserInputService.MouseIconEnabled = cursorEnabled
		UserInputService.ModalEnabled = cursorEnabled
	end
end)