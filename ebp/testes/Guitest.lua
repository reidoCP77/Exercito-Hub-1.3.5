local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Cria a ScreenGui
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "MainMenu"
mainGui.Parent = playerGui

-- Cria um Frame que ocupa a tela inteira
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Cor de fundo preta
mainFrame.Parent = mainGui

-- Cria a imagem acima dos botões
local imageLabel = Instance.new("ImageLabel")
imageLabel.Size = UDim2.new(0.5, 0, 0.3, 0)
imageLabel.Position = UDim2.new(0.25, 0, 0.1, 0)
imageLabel.Image = "rbxassetid://<YOUR_IMAGE_ID>" -- Substitua pelo ID da sua imagem
imageLabel.BackgroundTransparency = 1
imageLabel.Parent = mainFrame

-- Cria o botão "Jogar"
local playButton = Instance.new("TextButton")
playButton.Size = UDim2.new(0.3, 0, 0.1, 0)
playButton.Position = UDim2.new(0.35, 0, 0.5, 0)
playButton.Text = "Jogar"
playButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
playButton.Parent = mainFrame

-- Cria o botão "Créditos"
local creditsButton = Instance.new("TextButton")
creditsButton.Size = UDim2.new(0.3, 0, 0.1, 0)
creditsButton.Position = UDim2.new(0.35, 0, 0.65, 0)
creditsButton.Text = "Créditos"
creditsButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
creditsButton.Parent = mainFrame

-- Função para iniciar o jogo
local function startGame()
    mainGui:Destroy() -- Remove a GUI inicial
    -- Aqui você pode adicionar a lógica para iniciar o jogo
end

-- Função para abrir a GUI de Créditos
local function openCredits()
    -- Cria a GUI de Créditos
    local creditsGui = Instance.new("ScreenGui")
    creditsGui.Name = "CreditsMenu"
    creditsGui.Parent = playerGui

    -- Cria um Frame para os Créditos
    local creditsFrame = Instance.new("Frame")
    creditsFrame.Size = UDim2.new(1, 0, 1, 0)
    creditsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    creditsFrame.Parent = creditsGui

    -- Cria um texto para os Créditos
    local creditsText = Instance.new("TextLabel")
    creditsText.Size = UDim2.new(1, 0, 0.8, 0)
    creditsText.Position = UDim2.new(0, 0, 0.1, 0)
    creditsText.Text = "Créditos:\nMIngal_amargo3 - Criador\nGabrielBStar2 - Scripter e Builder\nDoandyRVaEy - Builder"
    creditsText.TextColor3 = Color3.fromRGB(255, 255, 255)
    creditsText.BackgroundTransparency = 1
    creditsText.Parent = creditsFrame

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0.3, 0, 0.1, 0)
    closeButton.Position = UDim2.new(0.35, 0, 0.85, 0)
    closeButton.Text = "Fechar"
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Parent = creditsFrame
    closeButton.MouseButton1Click:Connect(function()
        creditsGui:Destroy() 
    end)
end
playButton.MouseButton1Click:Connect(startGame)
creditsButton.MouseButton1Click:Connect(openCredits)
