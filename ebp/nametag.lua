-- Copyright 2024, SWATntj, All rights reserved.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Configurações do Overhead
local OVSettings = {
MainSettings = {
GroupID = 387273307, -- ID do grupo já definido
DeviceDisplay = true,
TeamNames = true,
GroupRanks = true,
PlayerUsername = true,
Subunidade = {}, -- IDs de subunidades, se houver
HealthDisplay = true
},
TextSettings = {
TextGradient = true,
TextStroke = true,
DisplayName = true,
Username = true
}
}

-- Função para verificar Game Pass
local function hasGamePass(player, gamePassID)
local success, hasPass = pcall(function()
return game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.UserId, gamePassID)
end)
return success and hasPass
end

local function onCharacterAdded(character, player)
local vipGamePassID = 1033598019
local boosterUserId = {}
local creatorIDs = {game.CreatorId}
local youtubeID = {}
local groupID = OVSettings.MainSettings.GroupID
local officialRankThreshold = 9

local head = character:WaitForChild("Head") local billBoardGuiClone = script.OverheadBBGUI:Clone() billBoardGuiClone.Adornee = head billBoardGuiClone.Parent = head local function applyTextSettings(textInstance) local uiGradient = textInstance:FindFirstChild("UIGradient") local uiStroke = textInstance:FindFirstChild("UIStroke") if OVSettings.TextSettings.TextGradient and uiGradient then uiGradient.Enabled = true elseif not OVSettings.TextSettings.TextGradient and uiGradient then uiGradient.Enabled = false end if OVSettings.TextSettings.TextStroke and uiStroke then uiStroke.Enabled = true elseif not OVSettings.TextSettings.TextStroke and uiStroke then uiStroke.Enabled = false end end if OVSettings.MainSettings.DeviceDisplay then local devicesFrameClone = script.Devices:Clone() devicesFrameClone.Parent = billBoardGuiClone local deviceImageLabel = devicesFrameClone:WaitForChild("Device") if deviceImageLabel then if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then deviceImageLabel.Image = "rbxassetid://126778936862395" elseif UserInputService.GamepadEnabled then deviceImageLabel.Image = "rbxassetid://16624150956" elseif UserInputService.VREnabled then deviceImageLabel.Image = "rbxassetid://16624144834" else if UserInputService.MouseEnabled then deviceImageLabel.Image = "rbxassetid://130561109801232" else deviceImageLabel.Image = "rbxassetid://126778936862395" end end end local donoImageLabel = devicesFrameClone:WaitForChild("Dono") donoImageLabel.Visible = table.find(creatorIDs, player.UserId) and true or false local hasVIPImageLabel = devicesFrameClone:WaitForChild("hasVIP") hasVIPImageLabel.Visible = hasGamePass(player, vipGamePassID) and true or false local YoutubeImageLabel = devicesFrameClone:WaitForChild("Youtube") YoutubeImageLabel.Visible = table.find(youtubeID, player.UserId) and true or false local BoosterImageLabel = devicesFrameClone:WaitForChild("Booster") BoosterImageLabel.Visible = table.find(boosterUserId, player.UserId) and true or false local oficialImageLabel = devicesFrameClone:WaitForChild("Oficial") oficialImageLabel.Visible = player:IsInGroup(groupID) and player:GetRankInGroup(groupID) >= officialRankThreshold and true or false end if OVSettings.MainSettings.TeamNames then local textInstanceClone = script.TextExample:Clone() textInstanceClone.Parent = billBoardGuiClone textInstanceClone.Name = "TeamName" local function updateTeamNameAndColor() if player.Team then textInstanceClone.Text = player.Team.Name textInstanceClone.TextColor3 = player.Team.TeamColor.Color else textInstanceClone.Text = "Neutral" textInstanceClone.TextColor3 = Color3.fromRGB(255, 255, 255) end end updateTeamNameAndColor() player:GetPropertyChangedSignal("Team"):Connect(updateTeamNameAndColor) if OVSettings.MainSettings.PlayerUsername or OVSettings.MainSettings.GroupRanks or OVSettings.MainSettings.TeamNames then applyTextSettings(textInstanceClone) end end if OVSettings.MainSettings.GroupRanks then local textInstanceClone = script.TextExample:Clone() textInstanceClone.Parent = billBoardGuiClone textInstanceClone.Name = "GroupRank" local defaultText = "[Civ] Civis" local subunitRank = "N/A" coroutine.wrap(function() if player:IsInGroup(groupID) then local role = player:GetRoleInGroup(groupID) textInstanceClone.Text = role for _, id in ipairs(OVSettings.MainSettings.Subunidade) do if player:IsInGroup(id) then subunitRank = player:GetRoleInGroup(id) break end end textInstanceClone.Text = textInstanceClone.Text .. " | " .. subunitRank else textInstanceClone.Text = defaultText end end)() if OVSettings.MainSettings.PlayerUsername or OVSettings.MainSettings.GroupRanks or OVSettings.MainSettings.TeamNames then applyTextSettings(textInstanceClone) end end if OVSettings.MainSettings.PlayerUsername then player.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None local textInstanceClone = script.TextExample:Clone() textInstanceClone.Parent = billBoardGuiClone local displayName = player.DisplayName local username = "@" .. player.Name local textToDisplay = displayName if OVSettings.TextSettings.DisplayName and OVSettings.TextSettings.Username then textToDisplay = string.format("%s (%s)", displayName, username) elseif OVSettings.TextSettings.Username then textToDisplay = username end textInstanceClone.Text = textToDisplay textInstanceClone.Name = "PlayerUsername" if OVSettings.MainSettings.PlayerUsername or OVSettings.MainSettings.GroupRanks or OVSettings.MainSettings.TeamNames then applyTextSettings(textInstanceClone) end end local function updateHealthBar(healthFrame, currentHealth, maxHealth) local barFrame = healthFrame:FindFirstChild("Bar") if not barFrame then return end local healthPercentage = currentHealth / maxHealth local offset = Vector2.new(-1 + healthPercentage, 0) local gradient = barFrame:FindFirstChild("UIGradient") if gradient then local tween = TweenService:Create(gradient, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Offset = offset}) tween:Play() end local transparency = currentHealth < maxHealth and 0 or 1 local healthTween = TweenService:Create(healthFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = transparency}) local barTween = TweenService:Create(barFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = transparency}) healthTween:Play() barTween:Play() end if OVSettings.MainSettings.HealthDisplay then character.Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff local healthFrameInst = script:FindFirstChild("Health") local healthFrame = healthFrameInst:Clone() healthFrame.Parent = billBoardGuiClone if healthFrame then updateHealthBar(healthFrame, character.Humanoid.Health, character.Humanoid.MaxHealth) character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function() updateHealthBar(healthFrame, character.Humanoid.Health, character.Humanoid.MaxHealth) end) end end 

end

Players.PlayerAdded:Connect(function(player)
player.CharacterAdded:Connect(function(character)
onCharacterAdded(character, player)
end)
end)

for _, player in ipairs(Players:GetPlayers()) do
if player.Character then
onCharacterAdded(player.Character, player)
end
end

