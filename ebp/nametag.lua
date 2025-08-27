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

local function getDeviceEmoji(device)
    if device == "Mobile" then
        return "📱" -- Emoji para Mobile
    elseif device == "Console" then
        return "🎮" -- Emoji para Console
    elseif device == "VR" then
        return "🕶️" -- Emoji para VR
    else
        return "💻" -- Emoji para Desktop
    end
end

local function createNameTag(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local oldTag = character:FindFirstChild("PlayerNameTag")
    if oldTag then oldTag:Destroy() end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PlayerNameTag"
    billboard.Adornee = humanoidRootPart
    billboard.Size = UDim2.new(0, 200, 0, 120) -- Aumenta a altura para acomodar mais texto
    billboard.StudsOffset = Vector3.new(0, 3.5, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 50
    billboard.Parent = character

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = billboard

    local deviceEmoji = getDeviceEmoji(getPlayerDevice(player))

    local line1 = Instance.new("TextLabel")
    line1.Size = UDim2.new(1, 0, 0.3, 0)
    line1.Position = UDim2.new(0, 0, 0, 0)
    line1.Text = string.format("%s %s", deviceEmoji, player.Name) -- Adiciona emoji e nome
    line1.TextColor3 = player.Team and player.Team.TeamColor.Color or Color3.new(1, 1, 1)
    line1.BackgroundTransparency = 1
    line1.TextScaled = true
    line1.Font = Enum.Font.SourceSansBold
    line1.Parent = frame

    local rank = player:GetAttribute("Rank") or "N/A" -- Obtém a patente do jogador
    local line2 = Instance.new("TextLabel")
    line2.Size = UDim2.new(1, 0, 0.3, 0)
    line2.Position = UDim2.new(0, 0, 0.3, 0)
    line2.Text = string.format("Patente: %s", rank) -- Exibe a patente
    line2.TextColor3 = player.Team and player.Team.TeamColor.Color or Color3.new(1, 1, 1)
    line2.BackgroundTransparency = 1
    line2.TextScaled = true
    line2.Font = Enum.Font.SourceSans
    line2.Parent = frame

    local teamName = player.Team and player.Team.Name or "N/A" -- Obtém o nome do time
    local line3 = Instance.new("TextLabel")
    line3.Size = UDim2.new(1, 0, 0.4, 0)
    line3.Position = UDim2.new(0, 0, 0.6, 0)
    line3.Text = string.format("Time: %s", teamName) -- Exibe o nome do time
    line3.TextColor3 = player.Team and player.Team.TeamColor.Color or Color3.new(1, 1, 1)
    line3.BackgroundTransparency = 1
    line3.TextScaled = true
    line3.Font = Enum.Font.SourceSans
    line3.Parent = frame

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
