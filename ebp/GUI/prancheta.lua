-- LocalScript dentro de StarterPlayerScripts ou StarterGui

-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- =========================
-- Criar a ScreenGui
-- =========================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PainelGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- =========================
-- Frame principal
-- =========================
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.3, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local uICorner = Instance.new("UICorner")
uICorner.CornerRadius = UDim.new(0, 15)
uICorner.Parent = mainFrame

-- =========================
-- Barra de botões
-- =========================
local buttonBar = Instance.new("Frame")
buttonBar.Name = "ButtonBar"
buttonBar.Size = UDim2.new(1, -20, 0, 50)
buttonBar.Position = UDim2.new(0, 10, 0, 10)
buttonBar.BackgroundTransparency = 1
buttonBar.Parent = mainFrame

local buttonNames = {"Pontuações", "Relatórios", "Cronômetro", "Anotações"}
local buttonCount = #buttonNames
local buttonSpacing = 10

for i, name in ipairs(buttonNames) do
    local button = Instance.new("TextButton")
    button.Name = name.."Button"
    button.Text = name
    button.Size = UDim2.new(0, 80, 1, 0)
    button.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = buttonBar

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 10)
    buttonCorner.Parent = button
end

local function adjustButtons()
    local totalWidth = buttonBar.AbsoluteSize.X
    local buttonWidth = (totalWidth - buttonSpacing * (buttonCount - 1)) / buttonCount
    for i, button in ipairs(buttonBar:GetChildren()) do
        if button:IsA("TextButton") then
            button.Size = UDim2.new(0, buttonWidth, 1, 0)
            button.Position = UDim2.new(0, (i-1)*(buttonWidth + buttonSpacing), 0, 0)
        end
    end
end

RunService.RenderStepped:Connect(adjustButtons)

-- =========================
-- Funcionalidade de arrastar
-- =========================
local dragging = false
local dragInput, startPos, startFramePos

local function startDrag(input)
    dragging = true
    startPos = input.Position
    startFramePos = mainFrame.Position
    input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
            dragging = false
        end
    end)
end

local function updateDrag(input)
    local delta = input.Position - startPos
    mainFrame.Position = UDim2.new(
        0,
        startFramePos.X.Offset + delta.X,
        0,
        startFramePos.Y.Offset + delta.Y
    )
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        startDrag(input)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- =========================
-- Função para botões universais (PC, Mobile, Console)
-- =========================
local function connectButton(button, callback)
    -- Activated funciona para mouse, touch e gamepad
    button.Activated:Connect(callback)
end
-- =========================
-- Funcionalidade de Pontuações
-- =========================
local scoresGui

local function createScoresGui()
    if scoresGui then
        scoresGui:Destroy()
        scoresGui = nil
        return
    end

    scoresGui = Instance.new("Frame")
    scoresGui.Name = "ScoresFrame"
    scoresGui.Size = UDim2.new(0, 380, 0, 250)
    scoresGui.Position = UDim2.new(0.5, -190, 0.5, -125)
    scoresGui.BackgroundColor3 = mainFrame.BackgroundColor3
    scoresGui.BorderSizePixel = 0
    scoresGui.Parent = screenGui

    local uICornerScores = Instance.new("UICorner")
    uICornerScores.CornerRadius = UDim.new(0, 15)
    uICornerScores.Parent = scoresGui

    local playersList = Instance.new("ScrollingFrame")
    playersList.Size = UDim2.new(1, -20, 1, -20)
    playersList.Position = UDim2.new(0, 10, 0, 10)
    playersList.BackgroundTransparency = 1
    playersList.ScrollBarThickness = 6
    playersList.Parent = scoresGui

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Padding = UDim.new(0, 10)
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Parent = playersList

    local function createPlayerItem(plr)
        local itemFrame = Instance.new("Frame")
        itemFrame.Size = UDim2.new(1, 0, 0, 50)
        itemFrame.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        itemFrame.BorderSizePixel = 0
        itemFrame.Parent = playersList

        local itemCorner = Instance.new("UICorner")
        itemCorner.CornerRadius = UDim.new(0, 10)
        itemCorner.Parent = itemFrame

        local playerImage = Instance.new("ImageLabel")
        playerImage.Size = UDim2.new(0, 40, 0, 40)
        playerImage.Position = UDim2.new(0, 5, 0.5, -20)
        playerImage.BackgroundTransparency = 1
        playerImage.Image = "rbxthumb://type=AvatarHeadShot&id="..plr.UserId.."&w=48&h=48"
        playerImage.Parent = itemFrame

        local imageCorner = Instance.new("UICorner")
        imageCorner.CornerRadius = UDim.new(1, 0)
        imageCorner.Parent = playerImage

        local playerName = Instance.new("TextLabel")
        playerName.Text = plr.Name
        playerName.Size = UDim2.new(0, 120, 1, 0)
        playerName.Position = UDim2.new(0, 50, 0, 0)
        playerName.BackgroundTransparency = 1
        playerName.TextColor3 = Color3.fromRGB(255, 255, 255)
        playerName.TextScaled = true
        playerName.Parent = itemFrame

        local score = 0
        local scoreLabel = Instance.new("TextLabel")
        scoreLabel.Text = tostring(score)
        scoreLabel.Size = UDim2.new(0, 50, 1, 0)
        scoreLabel.Position = UDim2.new(0, 180, 0, 0)
        scoreLabel.BackgroundTransparency = 1
        scoreLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        scoreLabel.TextScaled = true
        scoreLabel.Parent = itemFrame

        local minusButton = Instance.new("TextButton")
        minusButton.Text = "-"
        minusButton.Size = UDim2.new(0, 30, 0, 30)
        minusButton.Position = UDim2.new(0, 240, 0.5, -15)
        minusButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        minusButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        minusButton.Parent = itemFrame
        local minusCorner = Instance.new("UICorner")
        minusCorner.CornerRadius = UDim.new(0, 5)
        minusCorner.Parent = minusButton

        connectButton(minusButton, function()
            score = score - 1
            scoreLabel.Text = tostring(score)
        end)

        local plusButton = Instance.new("TextButton")
        plusButton.Text = "+"
        plusButton.Size = UDim2.new(0, 30, 0, 30)
        plusButton.Position = UDim2.new(0, 280, 0.5, -15)
        plusButton.BackgroundColor3 = Color3.fromRGB(0, 0, 200)
        plusButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        plusButton.Parent = itemFrame
        local plusCorner = Instance.new("UICorner")
        plusCorner.CornerRadius = UDim.new(0, 5)
        plusCorner.Parent = plusButton

        connectButton(plusButton, function()
            score = score + 1
            scoreLabel.Text = tostring(score)
        end)

        local deleteButton = Instance.new("TextButton")
        deleteButton.Text = "🗑️"
        deleteButton.Size = UDim2.new(0, 30, 0, 30)
        deleteButton.Position = UDim2.new(0, 320, 0.5, -15)
        deleteButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        deleteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        deleteButton.Parent = itemFrame
        local deleteCorner = Instance.new("UICorner")
        deleteCorner.CornerRadius = UDim.new(0, 5)
        deleteCorner.Parent = deleteButton

        connectButton(deleteButton, function()
            itemFrame:Destroy()
        end)
    end

    for _, plr in ipairs(Players:GetPlayers()) do
        createPlayerItem(plr)
    end

    Players.PlayerAdded:Connect(createPlayerItem)
end

-- =========================
-- Botão Regras
-- =========================
local rulesButton = Instance.new("TextButton")
rulesButton.Name = "RegrasButton"
rulesButton.Text = "Regras"
rulesButton.Size = UDim2.new(0, 80, 1, 0)
rulesButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
rulesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
rulesButton.Parent = buttonBar

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 10)
buttonCorner.Parent = rulesButton

-- Ajustar largura dos botões novamente
adjustButtons()

-- =========================
-- Funcionalidade de Regras
-- =========================

local regrasGui

local regrasLista = {
    "Regras Básicas:",
    "I - Não use hacks.",
    "II - Respeite todos os jogadores.",
    "III - Não faça spam no chat.",
    "IV - Siga as instruções dos superiores.",
    "V - Não abuse de bugs."
}

local function createRegrasGui()
    if regrasGui then
        regrasGui:Destroy()
        regrasGui = nil
        return
    end

    regrasGui = Instance.new("Frame")
    regrasGui.Name = "RegrasFrame"
    regrasGui.Size = UDim2.new(0, 380, 0, 250)
    regrasGui.Position = UDim2.new(0.5, -190, 0.5, -125)
    regrasGui.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
    regrasGui.BorderSizePixel = 0
    regrasGui.Parent = screenGui

    local uICornerRegras = Instance.new("UICorner")
    uICornerRegras.CornerRadius = UDim.new(0, 15)
    uICornerRegras.Parent = regrasGui

    local regrasList = Instance.new("ScrollingFrame")
    regrasList.Size = UDim2.new(1, -20, 1, -20)
    regrasList.Position = UDim2.new(0, 10, 0, 10)
    regrasList.BackgroundTransparency = 1
    regrasList.ScrollBarThickness = 6
    regrasList.Parent = regrasGui

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Padding = UDim.new(0, 10)
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Parent = regrasList

    -- Criar botões de regras
    for _, regra in ipairs(regrasLista) do
        local regraButton = Instance.new("TextButton")
        regraButton.Text = regra
        regraButton.Size = UDim2.new(1, -10, 0, 40)
        regraButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
        regraButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        regraButton.Parent = regrasList

        local regraCorner = Instance.new("UICorner")
        regraCorner.CornerRadius = UDim.new(0, 8)
        regraCorner.Parent = regraButton

        connectButton(regraButton, function()
            -- Enviar no chat global com balão
            game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(regra, "All")
        end)
    end
end

-- Conectar botão Regras
connectButton(rulesButton, createRulesGui)
-- =========================
-- Funcionalidade de Relatórios
-- =========================
local reportsGui
local groupId = 387273307

local function getRoleTag(plr)
    local roleName = plr:GetRoleInGroup(groupId)
    return "["..string.sub(roleName,1,1).."] "..roleName
end

local function createReportsGui()
    if reportsGui then
        reportsGui:Destroy()
        reportsGui = nil
        return
    end

    reportsGui = Instance.new("Frame")
    reportsGui.Name = "ReportsFrame"
    reportsGui.Size = UDim2.new(0, 380, 0, 250)
    reportsGui.Position = UDim2.new(0.5, -190, 0.5, -125)
    reportsGui.BackgroundColor3 = mainFrame.BackgroundColor3
    reportsGui.BorderSizePixel = 0
    reportsGui.Parent = screenGui

    local uICornerReports = Instance.new("UICorner")
    uICornerReports.CornerRadius = UDim.new(0, 15)
    uICornerReports.Parent = reportsGui

    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(1, -20, 0, 50)
    buttonContainer.Position = UDim2.new(0, 10, 0, 10)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = reportsGui

    local reportButtons = {"Alistamento", "Treinamento"}
    local buttonSpacing = 10
    for i, name in ipairs(reportButtons) do
        local button = Instance.new("TextButton")
        button.Name = name.."Button"
        button.Text = name
        button.Size = UDim2.new(0, 150, 1, 0)
        button.Position = UDim2.new(0, (i-1)*(150 + buttonSpacing), 0, 0)
        button.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Parent = buttonContainer

        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 10)
        buttonCorner.Parent = button

        connectButton(button, function()
            local frameName = name.."Frame"
            if reportsGui:FindFirstChild(frameName) then
                reportsGui[frameName]:Destroy()
                return
            end

            local reportFrame = Instance.new("Frame")
            reportFrame.Name = frameName
            reportFrame.Size = UDim2.new(1, -20, 1, -70)
            reportFrame.Position = UDim2.new(0, 10, 0, 70)
            reportFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            reportFrame.BorderSizePixel = 0
            reportFrame.Parent = reportsGui

            local uICornerText = Instance.new("UICorner")
            uICornerText.CornerRadius = UDim.new(0, 10)
            uICornerText.Parent = reportFrame

            local textBox = Instance.new("TextBox")
            textBox.Size = UDim2.new(1, -20, 1, -20)
            textBox.Position = UDim2.new(0, 10, 0, 10)
            textBox.BackgroundTransparency = 0.5
            textBox.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
            textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            textBox.TextXAlignment = Enum.TextXAlignment.Left
            textBox.TextYAlignment = Enum.TextYAlignment.Top
            textBox.MultiLine = true
            textBox.ClearTextOnFocus = false
            textBox.Parent = reportFrame

            local reportTitle = name == "Alistamento" and "RELATÓRIO DE ALISTAMENTO" or "RELATÓRIO DE TREINAMENTO"
            local reportText = "**⌠ "..reportTitle.." ⌡**\n─────────────────────────────\n" ..
                               "* **Instrutor(a):** "..player.Name.."\n" ..
                               "* **Auxiliar(es):**\n" ..
                               "* **Função:** "..getRoleTag(player).."\n─────────────────────────────\n" ..
                               "* **Participantes & Pontuação:**\n"

            if scoresGui then
                local playersList = scoresGui:FindFirstChildWhichIsA("ScrollingFrame")
                if playersList then
                    for _, item in ipairs(playersList:GetChildren()) do
                        if item:IsA("Frame") then
                            local labels = {}
                            for _, lbl in ipairs(item:GetChildren()) do
                                if lbl:IsA("TextLabel") then
                                    table.insert(labels, lbl)
                                end
                            end
                            if #labels >= 2 then
                                reportText = reportText..labels[1].Text.." - "..labels[2].Text.."\n"
                            end
                        end
                    end
                end
            end

            reportText = reportText.."* **Aprovados:**\n* **Observações:**\n─────────────────────────────\n* **Data e hora:** "..os.date("%d/%m/%Y %H:%M:%S").."\n* **Comprovações:**\n─────────────────────────────"
            textBox.Text = reportText
        end)
    end
end

-- =========================
-- Funcionalidade de Cronômetro
-- =========================
local timerGui
local timerRunning = false
local elapsedTime = 0
local startTime = 0

local function formatTime(ms)
    local minutes = math.floor(ms / 60000)
    local seconds = math.floor((ms % 60000) / 1000)
    local milliseconds = math.floor((ms % 1000) / 10)
    return string.format("%02d(m):%02d(s):%02d(ms)", minutes, seconds, milliseconds)
end

local function createTimerGui()
    if timerGui then
        timerGui:Destroy()
        timerGui = nil
        return
    end

    timerGui = Instance.new("Frame")
    timerGui.Name = "TimerFrame"
    timerGui.Size = UDim2.new(0, 380, 0, 250)
    timerGui.Position = UDim2.new(0.5, -190, 0.5, -125)
    timerGui.BackgroundColor3 = mainFrame.BackgroundColor3
    timerGui.BorderSizePixel = 0
    timerGui.Parent = screenGui

    local uICornerTimer = Instance.new("UICorner")
    uICornerTimer.CornerRadius = UDim.new(0, 15)
    uICornerTimer.Parent = timerGui

    local timerBox = Instance.new("TextBox")
    timerBox.Size = UDim2.new(1, -20, 0, 50)
    timerBox.Position = UDim2.new(0, 10, 0, 20)
    timerBox.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
    timerBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    timerBox.TextScaled = true
    timerBox.Text = "00(m):00(s):00(ms)"
    timerBox.ClearTextOnFocus = false
    timerBox.Parent = timerGui
    local uICornerBox = Instance.new("UICorner")
    uICornerBox.CornerRadius = UDim.new(0, 10)
    uICornerBox.Parent = timerBox

    local startButton = Instance.new("TextButton")
    startButton.Text = "Start"
    startButton.Size = UDim2.new(0, 100, 0, 40)
    startButton.Position = UDim2.new(0, 50, 0, 100)
    startButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    startButton.Parent = timerGui
    local startCorner = Instance.new("UICorner")
    startCorner.CornerRadius = UDim.new(0, 10)
    startCorner.Parent = startButton

    local stopButton = Instance.new("TextButton")
    stopButton.Text = "Stop"
    stopButton.Size = UDim2.new(0, 100, 0, 40)
    stopButton.Position = UDim2.new(0, 200, 0, 100)
    stopButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    stopButton.Parent = timerGui
    local stopCorner = Instance.new("UICorner")
    stopCorner.CornerRadius = UDim.new(0, 10)
    stopCorner.Parent = stopButton

    local resetButton = Instance.new("TextButton")
    resetButton.Text = "Reset"
    resetButton.Size = UDim2.new(0, 100, 0, 40)
    resetButton.Position = UDim2.new(0, 125, 0, 160)
    resetButton.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
    resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetButton.Parent = timerGui
    local resetCorner = Instance.new("UICorner")
    resetCorner.CornerRadius = UDim.new(0, 10)
    resetCorner.Parent = resetButton

    connectButton(startButton, function()
        if not timerRunning then
            timerRunning = true
            startTime = tick() - elapsedTime
        end
    end)

    connectButton(stopButton, function()
        if timerRunning then
            timerRunning = false
            elapsedTime = tick() - startTime
        end
    end)

    connectButton(resetButton, function()
        timerRunning = false
        elapsedTime = 0
        timerBox.Text = formatTime(0)
    end)

    RunService.RenderStepped:Connect(function()
        if timerRunning then
            elapsedTime = tick() - startTime
            timerBox.Text = formatTime(elapsedTime * 1000)
        end
    end)
end

-- =========================
-- Função de Anotações
-- =========================
local notesGui
local function createNotesGui()
    if notesGui then
        notesGui:Destroy()
        notesGui = nil
        return
    end

    notesGui = Instance.new("Frame")
    notesGui.Name = "NotesFrame"
    notesGui.Size = UDim2.new(0, 380, 0, 250)
    notesGui.Position = UDim2.new(0.5, -190, 0.5, -125)
    notesGui.BackgroundColor3 = mainFrame.BackgroundColor3
    notesGui.BorderSizePixel = 0
    notesGui.Parent = screenGui

    local uICornerNotes = Instance.new("UICorner")
    uICornerNotes.CornerRadius = UDim.new(0, 15)
    uICornerNotes.Parent = notesGui

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, -20, 1, -20)
    textBox.Position = UDim2.new(0, 10, 0, 10)
    textBox.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.TextYAlignment = Enum.TextYAlignment.Top
    textBox.MultiLine = true
    textBox.ClearTextOnFocus = false
    textBox.Parent = notesGui
end

-- =========================
-- Conectar os botões principais
-- =========================
for _, button in ipairs(buttonBar:GetChildren()) do
    if button:IsA("TextButton") then
        if button.Name == "PontuaçõesButton" then
            connectButton(button, createScoresGui)
        elseif button.Name == "RelatóriosButton" then
            connectButton(button, createReportsGui)
        elseif button.Name == "CronômetroButton" then
            connectButton(button, createTimerGui)
        elseif button.Name == "AnotaçõesButton" then
            connectButton(button, createNotesGui)
        end
    end
end