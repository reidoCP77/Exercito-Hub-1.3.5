-- LocalScript -> StarterGui

local player = game.Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")

-- Criar ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MeuGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- =========================
-- BOTÕES SUPERIORES
-- =========================

-- Função para criar botão superior
local function criarBotaoSuperior(texto, posX)
    local botao = Instance.new("TextButton")
    botao.Size = UDim2.new(0, 120, 0, 40)
    botao.Position = UDim2.new(0, posX, 0, -45)
    botao.Text = texto
    botao.TextColor3 = Color3.fromRGB(255,255,255)
    botao.BackgroundColor3 = Color3.fromRGB(60,60,60)
    botao.Parent = screenGui
    botao.Font = Enum.Font.SourceSansBold
    botao.TextSize = 18
    botao.AutoButtonColor = true
    botao.BackgroundTransparency = 0.2
    botao.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = botao
    
    return botao
end

-- Criar botões
local dinheiroBtn = criarBotaoSuperior("R$0", 200)
local gamepassesBtn = criarBotaoSuperior("Gamepasses", 340)
local configBtn = criarBotaoSuperior("Configurações", 470)

-- =========================
-- GUI CENTRAL (Gamepasses)
-- =========================

local gamepassesFrame = Instance.new("Frame")
gamepassesFrame.Size = UDim2.new(0, 350, 0, 300)
gamepassesFrame.Position = UDim2.new(0.5, -175, 0.5, -145) -- centralizado
gamepassesFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
gamepassesFrame.BorderSizePixel = 4
gamepassesFrame.BorderColor3 = Color3.fromRGB(0, 200, 0)
gamepassesFrame.Visible = false -- começa invisível
gamepassesFrame.Parent = screenGui

-- Bordas arredondadas
local gpCorner = Instance.new("UICorner")
gpCorner.CornerRadius = UDim.new(0, 15)
gpCorner.Parent = gamepassesFrame

--- =========================
-- Frame do setup
-- =========================

local configFrame= Instance.new("Frame")
configFrame.Size = UDim2.new(0, 350, 0, 300)
configFrame.Position = UDim2.new(0.5, -175, 0.5, -145) -- centralizado
configFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
configFrame.BorderSizePixel = 4
configFrame.BorderColor3 = Color3.fromRGB(0, 200, 0)
configFrame.Visible = false -- começa invisível
configFrame.Parent = screenGui

-- button Frame Vip
local imageButton = Instance.new("ImageButton")
imageButton.Size = UDim2.new(0, 80, 0, 80)       -- tamanho do botão
imageButton.Position = UDim2.new(0.5, -140, 0.5, -130) -- centralizado no Frame
imageButton.BackgroundTransparency = 1             
imageButton.Image = "rbxassetid://109447956060260"
imageButton.Parent = gamepassesFrame

imageButton.MouseButton1Click:Connect(function()
    -- Criar retângulo principal para o Gamepass
    local gpCard = Instance.new("Frame")
    gpCard.Size = UDim2.new(0, 300, 0, 150)
    gpCard.Position = UDim2.new(0, 20, 0, 125) -- posição dentro do gamepassesFrame
    gpCard.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    gpCard.BorderSizePixel = 0
    gpCard.Parent = gamepassesFrame
    
    local gpCardCorner = Instance.new("UICorner")
    gpCardCorner.CornerRadius = UDim.new(0, 12)
    gpCardCorner.Parent = gpCard
    
    -- Ícone da Gamepass
    local gpIcon = Instance.new("ImageLabel")
    gpIcon.Size = UDim2.new(0, 80, 0, 80)
    gpIcon.Position = UDim2.new(0, 10, 0, 10)
    gpIcon.BackgroundTransparency = 1
    gpIcon.Image = "rbxassetid://109447956060260" -- seu ícone
    gpIcon.Parent = gpCard
    
    -- Nome do Gamepass
    local gpName = Instance.new("TextLabel")
    gpName.Size = UDim2.new(0, 180, 0, 25)
    gpName.Position = UDim2.new(0, 100, 0, 10)
    gpName.BackgroundTransparency = 1
    gpName.Text = "VIP"
    gpName.TextColor3 = Color3.fromRGB(255, 255, 255)
    gpName.Font = Enum.Font.SourceSansBold
    gpName.TextSize = 18
    gpName.TextXAlignment = Enum.TextXAlignment.Left
    gpName.Parent = gpCard
    
    -- Descrição do Gamepass
    local gpDesc = Instance.new("TextLabel")
    gpDesc.Size = UDim2.new(0, 180, 0, 40)
    gpDesc.Position = UDim2.new(0, 100, 0, 40)
    gpDesc.BackgroundTransparency = 1
    gpDesc.Text = "Tenha acesso ao quartel, personalize seus avatares, tenha sua capacitação de patente reduzida, entre outros privilégios do Exército do New."
    gpDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
    gpDesc.Font = Enum.Font.SourceSans
    gpDesc.TextSize = 11
    gpDesc.TextWrapped = true
    gpDesc.TextXAlignment = Enum.TextXAlignment.Left
    gpDesc.Parent = gpCard
    
    -- Preço do Gamepass
    local gpPrice = Instance.new("TextLabel")
    gpPrice.Size = UDim2.new(0, 180, 0, 25)
    gpPrice.Position = UDim2.new(0, 100, 0, 85)
    gpPrice.BackgroundTransparency = 1
    gpPrice.Text = "R$ 60"
    gpPrice.TextColor3 = Color3.fromRGB(0, 255, 0)
    gpPrice.Font = Enum.Font.SourceSansBold
    gpPrice.TextSize = 16
    gpPrice.TextXAlignment = Enum.TextXAlignment.Left
    gpPrice.Parent = gpCard
    
    -- Botão Comprar
    local buyBtn = Instance.new("TextButton")
    buyBtn.Size = UDim2.new(0, 80, 0, 30)
    buyBtn.Position = UDim2.new(0, 200, 0, 110)
    buyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    buyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    buyBtn.Text = "Comprar"
    buyBtn.Font = Enum.Font.SourceSansBold
    buyBtn.TextSize = 16
    buyBtn.Parent = gpCard
    
    local buyCorner = Instance.new("UICorner")
    buyCorner.CornerRadius = UDim.new(0, 8)
    buyCorner.Parent = buyBtn
    
    -- Comprar Gamepass via MarketplaceService
    buyBtn.MouseButton1Click:Connect(function()
        local gamepassId = 1436534092 -- seu Gamepass ID
        MarketplaceService:PromptPurchase(player, gamepassId)
    end)
end)
-- Novo botão Gamepass "AK-47 Dourada"
local akButton = Instance.new("ImageButton")
akButton.Size = UDim2.new(0, 80, 0, 80)
akButton.Position = UDim2.new(0.5, -35, 0.5, -130) -- no meio entre VIP e Moto
akButton.BackgroundTransparency = 1
akButton.Image = "rbxassetid://131192129843444"
akButton.Parent = gamepassesFrame
 
akButton.MouseButton1Click:Connect(function()
    -- Criar retângulo principal para o Gamepass AK-47 Dourada
    local gpCard = Instance.new("Frame")
    gpCard.Size = UDim2.new(0, 300, 0, 150)
    gpCard.Position = UDim2.new(0, 20, 0, 125)
    gpCard.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    gpCard.BorderSizePixel = 0
    gpCard.Parent = gamepassesFrame
    
    local gpCardCorner = Instance.new("UICorner")
    gpCardCorner.CornerRadius = UDim.new(0, 12)
    gpCardCorner.Parent = gpCard
    
    -- Ícone da Gamepass
    local gpIcon = Instance.new("ImageLabel")
    gpIcon.Size = UDim2.new(0, 80, 0, 80)
    gpIcon.Position = UDim2.new(0, 10, 0, 10)
    gpIcon.BackgroundTransparency = 1
    gpIcon.Image = "rbxassetid://131192129843444"
    gpIcon.Parent = gpCard
    
    -- Nome do Gamepass
    local gpName = Instance.new("TextLabel")
    gpName.Size = UDim2.new(0, 180, 0, 25)
    gpName.Position = UDim2.new(0, 100, 0, 10)
    gpName.BackgroundTransparency = 1
    gpName.Text = "AK-47 Dourada"
    gpName.TextColor3 = Color3.fromRGB(255, 255, 255)
    gpName.Font = Enum.Font.SourceSansBold
    gpName.TextSize = 18
    gpName.TextXAlignment = Enum.TextXAlignment.Left
    gpName.Parent = gpCard
    
    -- Descrição
    local gpDesc = Instance.new("TextLabel")
    gpDesc.Size = UDim2.new(0, 180, 0, 40)
    gpDesc.Position = UDim2.new(0, 100, 0, 40)
    gpDesc.BackgroundTransparency = 1
    gpDesc.Text = "Tenha um armamento militar privilegiado."
    gpDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
    gpDesc.Font = Enum.Font.SourceSans
    gpDesc.TextSize = 14
    gpDesc.TextWrapped = true
    gpDesc.TextXAlignment = Enum.TextXAlignment.Left
    gpDesc.Parent = gpCard
    
    -- Preço
    local gpPrice = Instance.new("TextLabel")
    gpPrice.Size = UDim2.new(0, 180, 0, 25)
    gpPrice.Position = UDim2.new(0, 100, 0, 85)
    gpPrice.BackgroundTransparency = 1
    gpPrice.Text = "R$ 45"
    gpPrice.TextColor3 = Color3.fromRGB(0, 255, 0)
    gpPrice.Font = Enum.Font.SourceSansBold
    gpPrice.TextSize = 16
    gpPrice.TextXAlignment = Enum.TextXAlignment.Left
    gpPrice.Parent = gpCard
    
    -- Botão Comprar
    local buyBtn = Instance.new("TextButton")
    buyBtn.Size = UDim2.new(0, 80, 0, 30)
    buyBtn.Position = UDim2.new(0, 200, 0, 110)
    buyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    buyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    buyBtn.Text = "Comprar"
    buyBtn.Font = Enum.Font.SourceSansBold
    buyBtn.TextSize = 16
    buyBtn.Parent = gpCard
    
    local buyCorner = Instance.new("UICorner")
    buyCorner.CornerRadius = UDim.new(0, 8)
    buyCorner.Parent = buyBtn
    
    buyBtn.MouseButton1Click:Connect(function()
        local gamepassId = 1451727546
        MarketplaceService:PromptPurchase(player, gamepassId)
    end)
end)
-- BORDER RADIUS

local gpCorner = Instance.new("UICorner")
gpCorner.CornerRadius = UDim.new(0, 15)
gpCorner.Parent = configFrame
-- Novo botão Gamepass "Moto"
local motoButton = Instance.new("ImageButton")
motoButton.Size = UDim2.new(0, 80, 0, 80)      
motoButton.Position = UDim2.new(0.5, 70, 0.5, -130) -- à direita do VIP
motoButton.BackgroundTransparency = 1             
motoButton.Image = "rbxassetid://92310714349262" -- substitua pelo ID da imagem
motoButton.Parent = gamepassesFrame
 
motoButton.MouseButton1Click:Connect(function()
    -- Criar retângulo principal para o Gamepass Moto
    local gpCard = Instance.new("Frame")
    gpCard.Size = UDim2.new(0, 300, 0, 150)
    gpCard.Position = UDim2.new(0, 20, 0, 125) 
    gpCard.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    gpCard.BorderSizePixel = 0
    gpCard.Parent = gamepassesFrame
    
    local gpCardCorner = Instance.new("UICorner")
    gpCardCorner.CornerRadius = UDim.new(0, 12)
    gpCardCorner.Parent = gpCard
    
    -- Ícone da Gamepass Moto
    local gpIcon = Instance.new("ImageLabel")
    gpIcon.Size = UDim2.new(0, 80, 0, 80)
    gpIcon.Position = UDim2.new(0, 10, 0, 10)
    gpIcon.BackgroundTransparency = 1
    gpIcon.Image = "rbxassetid://92310714349262"
    gpIcon.Parent = gpCard
    
    -- Nome do Gamepass
    local gpName = Instance.new("TextLabel")
    gpName.Size = UDim2.new(0, 180, 0, 25)
    gpName.Position = UDim2.new(0, 100, 0, 10)
    gpName.BackgroundTransparency = 1
    gpName.Text = "Moto"
    gpName.TextColor3 = Color3.fromRGB(255, 255, 255)
    gpName.Font = Enum.Font.SourceSansBold
    gpName.TextSize = 18
    gpName.TextXAlignment = Enum.TextXAlignment.Left
    gpName.Parent = gpCard
    
    -- Descrição
    local gpDesc = Instance.new("TextLabel")
    gpDesc.Size = UDim2.new(0, 180, 0, 40)
    gpDesc.Position = UDim2.new(0, 100, 0, 40)
    gpDesc.BackgroundTransparency = 1
    gpDesc.Text = "Usado para facilitar o transporte pelo mapa."
    gpDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
    gpDesc.Font = Enum.Font.SourceSans
    gpDesc.TextSize = 14
    gpDesc.TextWrapped = true
    gpDesc.TextXAlignment = Enum.TextXAlignment.Left
    gpDesc.Parent = gpCard
    
    -- Preço
    local gpPrice = Instance.new("TextLabel")
    gpPrice.Size = UDim2.new(0, 180, 0, 25)
    gpPrice.Position = UDim2.new(0, 100, 0, 85)
    gpPrice.BackgroundTransparency = 1
    gpPrice.Text = "R$ 40"
    gpPrice.TextColor3 = Color3.fromRGB(0, 255, 0)
    gpPrice.Font = Enum.Font.SourceSansBold
    gpPrice.TextSize = 16
    gpPrice.TextXAlignment = Enum.TextXAlignment.Left
    gpPrice.Parent = gpCard
    
    -- Botão Comprar
    local buyBtn = Instance.new("TextButton")
    buyBtn.Size = UDim2.new(0, 80, 0, 30)
    buyBtn.Position = UDim2.new(0, 200, 0, 110)
    buyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    buyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    buyBtn.Text = "Comprar"
    buyBtn.Font = Enum.Font.SourceSansBold
    buyBtn.TextSize = 16
    buyBtn.Parent = gpCard
    
    local buyCorner = Instance.new("UICorner")
    buyCorner.CornerRadius = UDim.new(0, 8)
    buyCorner.Parent = buyBtn
    
    buyBtn.MouseButton1Click:Connect(function()
        local gamepassIdx = 1451711664
        MarketplaceService:PromptPurchase(player, gamepassIdx)
    end)
end)
-- =========================
-- Set up do Gamepass
-- =========================

gamepassesBtn.MouseButton1Click:Connect(function()
    if gamepassesBtn.Text == "Gamepasses" then
        gamepassesBtn.Text = "Fechar"
        gamepassesBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 235)
        gamepassesFrame.Visible = true
    else
        gamepassesBtn.Text = "Gamepasses"
        gamepassesBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
        gamepassesFrame.Visible = false
    end
end)

-- Setup do Config

configBtn.MouseButton1Click:Connect(function()
    if configBtn.Text == "Configurações" then
        configBtn.Text = "Fechar"
        configBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 235)
        configFrame.Visible = true
    else
        configBtn.Text = "Configurações"
        configBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
        configFrame.Visible = false
    end
end)

-- update do leaderstats
local function atualizarDinheiro()
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local dinheiro = leaderstats:FindFirstChild("Dinheiro")
        if dinheiro then
            dinheiroBtn.Text = "R$"..dinheiro.Value
            dinheiro:GetPropertyChangedSignal("Value"):Connect(function()
                dinheiroBtn.Text = "R$"..dinheiro.Value
            end)
        end
    end
end
atualizarDinheiro()

-- =========================
-- BOTÃO CORRER (INFERIOR DIREITO)
-- =========================

local correrBtn = Instance.new("TextButton")
correrBtn.Size = UDim2.new(0, 50, 0, 50)
correrBtn.Position = UDim2.new(0,740, 0, 175) 
correrBtn.Text = "Correr"
correrBtn.TextColor3 = Color3.fromRGB(250,250,250)
correrBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
correrBtn.Font = Enum.Font.SourceSansBold
correrBtn.TextSize = 20
correrBtn.AutoButtonColor = true
correrBtn.Parent = screenGui
correrBtn.BorderSizePixel = 4
correrBtn.BackgroundTransparency = 0
correrBtn.BorderColor3 = Color3.fromRGB(0, 200, 0)

-- Arredondar bordas
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = correrBtn

-- Função de clique do botão correr
correrBtn.MouseButton1Click:Connect(function()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    if correrBtn.Text == "Correr" then
        correrBtn.Text = "Andar"
        humanoid.WalkSpeed = 27 -- velocidade ao "Correr"
    else
        correrBtn.Text = "Correr"
        humanoid.WalkSpeed = 15 -- velocidade padrão
    end
end)
-- =========================
-- CONFIGURAÇÕES: Textos + Botões
-- =========================

-- Função para criar uma linha de configuração
local function criarOpcaoConfig(nome, ordem)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 0, 30)
    label.Position = UDim2.new(0, 20, 0, 20 + (ordem * 40)) -- espaçamento vertical
    label.BackgroundTransparency = 1
    label.Text = nome
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = configFrame

    -- Botão ao lado
    local botao = Instance.new("TextButton")
    botao.Size = UDim2.new(0, 80, 0, 30)
    botao.Position = UDim2.new(0, 240, 0, 20 + (ordem * 40))
    botao.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    botao.TextColor3 = Color3.fromRGB(255, 255, 255)
    botao.Text = "Ativar"
    botao.Font = Enum.Font.SourceSansBold
    botao.TextSize = 14
    botao.Parent = configFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = botao

    return botao
end

-- Criar as 3 opções
local btnTexturas = criarOpcaoConfig("Remover texturas", 0)
local btnSombras = criarOpcaoConfig("Remover sombras", 1)
local btnSom = criarOpcaoConfig("Remover som", 2)

-- =========================
-- Ações dos botões
-- =========================

-- Exemplo: remover texturas (toggle)
local texturasRemovidas = false
local texturasGuardadas = {} -- guardar para restaurar depois

btnTexturas.MouseButton1Click:Connect(function()
    if not texturasRemovidas then
        -- remover e guardar
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Texture") or obj:IsA("Decal") then
                table.insert(texturasGuardadas, obj)
                obj.Parent = nil
            end
        end
        btnTexturas.Text = "OK"
        btnTexturas.BackgroundColor3 = Color3.fromRGB(0,150,0)
        texturasRemovidas = true
    else
        -- restaurar
        for _, obj in ipairs(texturasGuardadas) do
            obj.Parent = workspace
        end
        texturasGuardadas = {}
        btnTexturas.Text = "Ativar"
        btnTexturas.BackgroundColor3 = Color3.fromRGB(0,200,0)
        texturasRemovidas = false
    end
end)

-- Exemplo: remover sombras (toggle)
local sombrasRemovidas = false
btnSombras.MouseButton1Click:Connect(function()
    if not sombrasRemovidas then
        game.Lighting.GlobalShadows = false
        btnSombras.Text = "OK"
        btnSombras.BackgroundColor3 = Color3.fromRGB(0,150,0)
        sombrasRemovidas = true
    else
        game.Lighting.GlobalShadows = true
        btnSombras.Text = "Ativar"
        btnSombras.BackgroundColor3 = Color3.fromRGB(0,200,0)
        sombrasRemovidas = false
    end
end)

-- Exemplo: remover sons (toggle)
local somRemovido = false
btnSom.MouseButton1Click:Connect(function()
    if not somRemovido then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Sound") then
                obj:SetAttribute("VolumeAntigo", obj.Volume) -- guardar volume
                obj.Volume = 0
                obj.Playing = false
            end
        end
        btnSom.Text = "OK"
        btnSom.BackgroundColor3 = Color3.fromRGB(0,150,0)
        somRemovido = true
    else
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Sound") then
                local antigo = obj:GetAttribute("VolumeAntigo")
                if antigo then
                    obj.Volume = antigo
                else
                    obj.Volume = 1
                end
            end
        end
        btnSom.Text = "Ativar"
        btnSom.BackgroundColor3 = Color3.fromRGB(0,200,0)
        somRemovido = false
    end
end)

local function ajustarLayout()
    if UserInputService.GamepadEnabled then
        -- 🎮 Console
        correrBtn.Position = UDim2.new(0.5, -25, 1, -80) -- centralizado inferior
        dinheiroBtn.Position = UDim2.new(0.5, -60, 0, 10) -- superior central
        gamepassesBtn.Position = UDim2.new(0.5, -60, 0, 60)
        configBtn.Position = UDim2.new(0.5, -60, 0, 110)
    else
        correrBtn.Position = UDim2.new(0, 740, 0, 175) 
        dinheiroBtn.Position = UDim2.new(0, 200, 0, -45)
        gamepassesBtn.Position = UDim2.new(0, 340, 0, -45)
        configBtn.Position = UDim2.new(0, 470, 0, -45)
    end
end

ajustarLayout()
UserInputService.LastInputTypeChanged:Connect(ajustarLayout)