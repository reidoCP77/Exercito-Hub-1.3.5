local Players = game:GetService("Players")
local player = Players.LocalPlayer
local function changeToR6(character)
    if character then
        if character:FindFirstChild("Humanoid") and character.Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
            character:BreakJoints() 
            local newCharacter = Instance.new("Model")
            newCharacter.Name = player.Name
            newCharacter.Parent = workspace
            local r6 = game.ServerStorage:WaitForChild("R6"):Clone()
            r6.Parent = newCharacter
            player.Character = newCharacter
        end
    end
end

player.CharacterAdded:Connect(changeToR6)
changeToR6(player.Character)
