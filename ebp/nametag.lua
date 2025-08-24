local Players = game:GetService("Players")

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

local function createNameTag(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local oldTag = character:FindFirstChild("PlayerNameTag")
    if oldTag then oldTag:Destroy() end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PlayerNameTag"
    billboard.Adornee = humanoidRootPart
    billboard.Size = UDim2.new(0, 200, 0, 80)
    billboard.StudsOffset = Vector3.new(0, 3.5, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 50
    billboard.Parent = character

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = billboard

    local line1 = Instance.new("TextLabel")
    line1.Size = UDim2.new(1, 0, 0.4, 0)
    line1.Position = UDim2.new(0, 0, 0, 0)
    line1.Text = string.format("%s - %s", getPlayerDevice(player), player.Name)
    line1.TextColor3 = player.Team and player.Team.TeamColor.Color or Color3.new(1, 1, 1)
    line1.BackgroundTransparency = 1
    line1.TextScaled = true
    line1.Font = Enum.Font.SourceSansBold
    line1.Parent = frame

    local line2 = Instance.new("TextLabel")
    line2.Size = UDim2.new(1, 0, 0.4, 0)
    line2.Position = UDim2.new(0, 0, 0.4, 0)
    line2.Text = string.format("%s - %s", player.Team and tostring(player.Team.AutoAssignable) or "N/A", player.Team and tostring(player.Team.AutoAssignable) or "N/A")
    line2.TextColor3 = player.Team and player.Team.TeamColor.Color or Color3.new(1, 1, 1)
    line2.BackgroundTransparency = 1
    line2.TextScaled = true
    line2.Font = Enum.Font.SourceSans
    line2.Parent = frame

    return billboard
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        wait(1)
        createNameTag(player)
    end)
    player:GetPropertyChangedSignal("Team"):Connect(function()
        if player.Character then
            createNameTag(player)
        end
    end)
end)

for _, player in ipairs(Players:GetPlayers()) do
    if player.Character then
        createNameTag(player)
    end
end
