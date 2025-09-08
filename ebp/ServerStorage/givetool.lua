local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local GROUP_ID = 387273307 
local GAMEPASS_AK47 = 11111111
local GAMEPASS_MOTO = 22222222 

local toolsFolder = ServerStorage:WaitForChild("Tools")

-- give tool

local function giveTool(player, toolName)
	local tool = toolsFolder:FindFirstChild(toolName)
	if tool then
		local clone = tool:Clone()
		clone.Parent = player.Backpack
	end
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Wait()
	local rank = player:GetRankInGroup(GROUP_ID)

	if rank >= 3 then
		giveTool(player, "Tablet")
		giveTool(player, "FAL")
	end

	if rank >= 8 then
		giveTool(player, "Tablet")
		giveTool(player, "FAL")
		giveTool(player, "Algema")
	end

-- ak47 dourada

	local success, ownsAK47 = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, GAMEPASS_AK47)
	end)
	if success and ownsAK47 then
		giveTool(player, "AK-47 Dourada")
	end

	-- moto

	local success2, ownsMoto = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, GAMEPASS_MOTO)
	end)
	if success2 and ownsMoto then
		giveTool(player, "Moto")
	end
end)