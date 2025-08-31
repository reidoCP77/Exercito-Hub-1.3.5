-- cmt1
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local GrupoID = 387273307 -- ID do grupo

local function detectDevice(player)
    local device = "Desktop"
    local lastInput = UserInputService:GetLastInputType()
    if lastInput == Enum.UserInputType.Touch then
        device = "Mobile"
    elseif lastInput == Enum.UserInputType.Gamepad1 then
        device = "Console"
    elseif lastInput == Enum.UserInputType.VR then
        device = "VR"
    end
    player:SetAttribute("Mobile", device == "Mobile")
    player:SetAttribute("Console", device == "Console")
    player:SetAttribute("VR", device == "VR")
end

local function getPlayerDevice(player)
    local device = "Desktop"
    if player:GetAttribute("Mobile") then
        device = "Mobile"
    elseif player:GetAttribute("Console") then
        device = "Console"
    elseif player:GetAttribute("VR") then
        device = "VR"
    end
    return device
end

local function getDeviceEmoji(device)
    if device == "Mobile" then
        return "📱"
    elseif device == "Console" then
        return "🎮"
    elseif device == "VR" then
        return "🕶️"
    else
        return "💻"
    end
end

local function updateRank(player)
    local rankName = "Civil"
    pcall(function()
        if player:IsInGroup(GrupoID) then
            rankName = player:GetRoleInGroup(GrupoID)
        end
    end)
    player:SetAttribute("Rank", rankName)
end

local function createNameTag(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local oldTag = character:FindFirstChild("PlayerNameTag")
    if oldTag then oldTag:Destroy() end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PlayerNameTag"
    billboard.Adornee = humanoidRootPart
    billboard.Size = UDim2.new(0, 120, 0, 120)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 50
    billboard.Parent = character

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = billboard

    local deviceEmoji = getDeviceEmoji(getPlayerDevice(player))
    local teamColor = player.Team and player.Team.TeamColor.Color or Color3.new(1, 1, 1)

    local line1 = Instance.new("TextLabel")
    line1.Size = UDim2.new(1, 0, 0.3, 0)
    line1.Position = UDim2.new(0, 0, 0, 5)
    line1.Text = string.format("%s  - %s", deviceEmoji, player.Name)
    line1.TextColor3 = teamColor
    line1.BackgroundTransparency = 1
    line1.TextScaled = true
    line1.Font = Enum.Font.SourceSansBold
    line1.Parent = frame

    local teamName = player.Team and player.Team.Name or "N/A"
    local line2 = Instance.new("TextLabel")
    line2.Size = UDim2.new(1, 0, 0.15, 0)
    line2.Position = UDim2.new(0, 0, 0.2, 6)
    line2.Text = string.format(teamName)
    line2.TextColor3 = teamColor
    line2.BackgroundTransparency = 1
    line2.TextScaled = true
    line2.Font = Enum.Font.SourceSansBold 
    line2.Parent = frame

    local rank = player:GetAttribute("Rank") or "Civil"
    local line3 = Instance.new("TextLabel")
    line3.Size = UDim2.new(1, 0, 0.15, 0)
    line3.Position = UDim2.new(0, 0, 0.6, -25)
    line3.Text = string.format(rank)
    line3.TextColor3 = teamColor
    line3.BackgroundTransparency = 1
    line3.TextScaled = true
    line3.Font = Enum.Font.SourceSansBold
    line3.Parent = frame

    return billboard
end

local player = Players.LocalPlayer
detectDevice(player)
updateRank(player)

player.CharacterAdded:Connect(function(character)
    task.wait(1)
    updateRank(player)
    createNameTag(player)
end)

player:GetPropertyChangedSignal("Team"):Connect(function()
    if player.Character then
        createNameTag(player)
    end
end)

if player.Character then
    updateRank(player)
    createNameTag(player)
end