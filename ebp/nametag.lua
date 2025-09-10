-- LocalScript - Overhead completo com detecção de dispositivo
-- Copyright 2024, SWATntj

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- Configurações do Overhead
local OVSettings = {
    MainSettings = {
        GroupID = 387273307, -- ID do grupo
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

local function detectDevice()
    if UserInputService.VREnabled then
        return "VR"
    elseif UserInputService.TouchEnabled then
        return "Mobile"
    elseif UserInputService.GamepadEnabled then
        return "Console"
    else
        return "PC"
    end
end

local deviceDetected = detectDevice()

-- Função quando o personagem spawnar
local function onCharacterAdded(character)
    local vipGamePassID = 1436534092
    local boosterUserId = {}
    local creatorIDs = {5316524449}
    local youtubeID = {5316524449, 5831837398}
    local groupID = OVSettings.MainSettings.GroupID
    local officialRankThreshold = 7

    local head = character:WaitForChild("Head")
    local billBoardGuiClone = script:WaitForChild("OverheadBBGUI"):Clone()
    billBoardGuiClone.Adornee = head
    billBoardGuiClone.Parent = head

    local function applyTextSettings(textInstance)
        local uiGradient = textInstance:FindFirstChild("UIGradient")
        local uiStroke = textInstance:FindFirstChild("UIStroke")
        if OVSettings.TextSettings.TextGradient and uiGradient then
            uiGradient.Enabled = true
        elseif uiGradient then
            uiGradient.Enabled = false
        end
        if OVSettings.TextSettings.TextStroke and uiStroke then
            uiStroke.Enabled = true
        elseif uiStroke then
            uiStroke.Enabled = false
        end
    end

    -- Dispositivo
    if OVSettings.MainSettings.DeviceDisplay then
        local devicesFrameClone = script:WaitForChild("Devices"):Clone()
        devicesFrameClone.Parent = billBoardGuiClone
        local deviceImageLabel = devicesFrameClone:WaitForChild("Device")

        if deviceDetected == "Mobile" then
            deviceImageLabel.Image = "rbxassetid://126778936862395"
        elseif deviceDetected == "Console" then
            deviceImageLabel.Image = "rbxassetid://16624150956"
        elseif deviceDetected == "VR" then
            deviceImageLabel.Image = "rbxassetid://16624144834"
        else
            deviceImageLabel.Image = "rbxassetid://130561109801232"
        end

        local donoImageLabel = devicesFrameClone:WaitForChild("Dono")
        donoImageLabel.Visible = table.find(creatorIDs, player.UserId) and true or false

        local hasVIPImageLabel = devicesFrameClone:WaitForChild("hasVIP")
        pcall(function()
            local MarketplaceService = game:GetService("MarketplaceService")
            hasVIPImageLabel.Visible = MarketplaceService:UserOwnsGamePassAsync(player.UserId, vipGamePassID)
        end)

        local YoutubeImageLabel = devicesFrameClone:WaitForChild("Youtube")
        YoutubeImageLabel.Visible = table.find(youtubeID, player.UserId) and true or false

        local BoosterImageLabel = devicesFrameClone:WaitForChild("Booster")
        BoosterImageLabel.Visible = table.find(boosterUserId, player.UserId) and true or false

        local oficialImageLabel = devicesFrameClone:WaitForChild("Oficial")
        oficialImageLabel.Visible = player:IsInGroup(groupID) and player:GetRankInGroup(groupID) >= officialRankThreshold
    end

    -- Nome do time
    if OVSettings.MainSettings.TeamNames then
        local textInstanceClone = script:WaitForChild("TextExample"):Clone()
        textInstanceClone.Parent = billBoardGuiClone
        textInstanceClone.Name = "TeamName"
        local function updateTeamNameAndColor()
            if player.Team then
                textInstanceClone.Text = player.Team.Name
                textInstanceClone.TextColor3 = player.Team.TeamColor.Color
            else
                textInstanceClone.Text = "Neutral"
                textInstanceClone.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end
        updateTeamNameAndColor()
        player:GetPropertyChangedSignal("Team"):Connect(updateTeamNameAndColor)
        applyTextSettings(textInstanceClone)
    end

    -- Cargo no grupo
    -- Cargo no grupo
if OVSettings.MainSettings.GroupRanks then
    local textInstanceClone = script:WaitForChild("TextExample"):Clone()
    textInstanceClone.Parent = billBoardGuiClone
    textInstanceClone.Name = "GroupRank"
    local defaultText = "[CI] Cidadão"
    local subunitRank = "N/A"

    coroutine.wrap(function()
        if player:IsInGroup(groupID) then
            -- Nome do cargo
            local role = player:GetRoleInGroup(groupID)

            -- Corrige caso venha número bugado
            if tonumber(role) ~= nil then
                role = "[??] Cargo Desconhecido"
            end

            textInstanceClone.Text = role

            -- Subunidade (se tiver)
            for _, id in ipairs(OVSettings.MainSettings.Subunidade) do
                if player:IsInGroup(id) then
                    subunitRank = player:GetRoleInGroup(id)
                    break
                end
            end

            -- Junta cargo + subunidade
            if subunitRank ~= "N/A" then
                textInstanceClone.Text = textInstanceClone.Text .. " | " .. subunitRank
            end
        else
            -- Não está no grupo
            textInstanceClone.Text = defaultText
        end
    end)()

    applyTextSettings(textInstanceClone)
end

    -- Username/DisplayName
    if OVSettings.MainSettings.PlayerUsername then
        character:WaitForChild("Humanoid").DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        local textInstanceClone = script:WaitForChild("TextExample"):Clone()
        textInstanceClone.Parent = billBoardGuiClone
        local displayName = player.DisplayName
        local username = "@" .. player.Name
        local textToDisplay = displayName
        if OVSettings.TextSettings.DisplayName and OVSettings.TextSettings.Username then
            textToDisplay = string.format("%s (%s)", displayName, username)
        elseif OVSettings.TextSettings.Username then
            textToDisplay = username
        end
        textInstanceClone.Text = textToDisplay
        textInstanceClone.Name = "PlayerUsername"
        applyTextSettings(textInstanceClone)
    end

    -- Barra de vida
    if OVSettings.MainSettings.HealthDisplay then
        character:WaitForChild("Humanoid").HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
        local healthFrameInst = script:WaitForChild("Health")
        local healthFrame = healthFrameInst:Clone()
        healthFrame.Parent = billBoardGuiClone

        local function updateHealthBar(currentHealth, maxHealth)
            local barFrame = healthFrame:FindFirstChild("Bar")
            if not barFrame then return end
            local healthPercentage = currentHealth / maxHealth
            local offset = Vector2.new(-1 + healthPercentage, 0)
            local gradient = barFrame:FindFirstChild("UIGradient")
            if gradient then
                TweenService:Create(gradient, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Offset = offset}):Play()
            end
            local transparency = currentHealth < maxHealth and 0 or 1
            TweenService:Create(healthFrame, TweenInfo.new(0.15), {BackgroundTransparency = transparency}):Play()
            TweenService:Create(barFrame, TweenInfo.new(0.15), {BackgroundTransparency = transparency}):Play()
        end

        updateHealthBar(character.Humanoid.Health, character.Humanoid.MaxHealth)
        character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            updateHealthBar(character.Humanoid.Health, character.Humanoid.MaxHealth)
        end)
    end
end

player.CharacterAdded:Connect(onCharacterAdded)

if player.Character then
   player.Character:WaitForChild("Humanoid")
   player.Character:WaitForChild("Head")
   onCharacterAdded(player.Character)
end