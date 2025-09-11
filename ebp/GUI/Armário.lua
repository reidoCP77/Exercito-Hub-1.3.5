local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ================== CRIAR GUI ==================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ArmarioGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 600, 0, 300)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderColor3 = Color3.fromRGB(0,255,0)
mainFrame.BorderMode = Enum.BorderMode.Outline
mainFrame.Parent = screenGui

-- Label FECHAR
local fecharLabel = Instance.new("TextLabel")
fecharLabel.Name = "FecharLabel"
fecharLabel.Size = UDim2.new(0, 100, 0, 30)
fecharLabel.Position = UDim2.new(0, 10, 0, 10)
fecharLabel.BackgroundTransparency = 1
fecharLabel.Text = "> FECHAR"
fecharLabel.Font = Enum.Font.SourceSansItalic
fecharLabel.TextSize = 24
fecharLabel.TextColor3 = Color3.new(1,1,1)
fecharLabel.TextXAlignment = Enum.TextXAlignment.Left
fecharLabel.Parent = mainFrame

-- Botão FECHAR transparente por cima
local fecharButton = Instance.new("TextButton")
fecharButton.Size = fecharLabel.Size
fecharButton.Position = fecharLabel.Position
fecharButton.BackgroundTransparency = 1
fecharButton.Text = ""
fecharButton.Parent = mainFrame

fecharButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)
fecharButton.MouseEnter:Connect(function()
    fecharLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
end)
fecharButton.MouseLeave:Connect(function()
    fecharLabel.TextColor3 = Color3.new(1,1,1)
end)

-- Título ARMÁRIO
local tituloLabel = Instance.new("TextLabel")
tituloLabel.Name = "Titulo"
tituloLabel.Size = UDim2.new(0, 300, 0, 30)
tituloLabel.Position = UDim2.new(0, 10, 0, 50)
tituloLabel.BackgroundTransparency = 1
tituloLabel.Text = "ARMÁRIO"
tituloLabel.Font = Enum.Font.SourceSansBoldItalic
tituloLabel.TextSize = 24
tituloLabel.TextColor3 = Color3.new(1,1,1)
tituloLabel.TextXAlignment = Enum.TextXAlignment.Left
tituloLabel.Parent = mainFrame

-- Caixa de texto para o armário
local armarioBox = Instance.new("TextBox")
armarioBox.Name = "ArmarioBox"
armarioBox.Size = UDim2.new(0, 350, 0, 200)
armarioBox.Position = UDim2.new(0, 10, 0, 80)
armarioBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
armarioBox.BorderColor3 = Color3.fromRGB(0,255,0)
armarioBox.ClearTextOnFocus = false
armarioBox.Text = ""
armarioBox.TextColor3 = Color3.new(1,1,1)
armarioBox.Font = Enum.Font.SourceSans
armarioBox.TextSize = 20
armarioBox.TextWrapped = true
armarioBox.ReadOnly = true
armarioBox.Parent = mainFrame

-- Frame direito superior (info do item e botão comprar/equipar)
local rightTopFrame = Instance.new("Frame")
rightTopFrame.Name = "RightTopFrame"
rightTopFrame.Size = UDim2.new(0, 230, 0, 120)
rightTopFrame.Position = UDim2.new(0, 370, 0, 30)
rightTopFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
rightTopFrame.BorderColor3 = Color3.fromRGB(0,255,0)
rightTopFrame.Parent = mainFrame

local nALabel1 = Instance.new("TextLabel")
nALabel1.Name = "NALabel1"
nALabel1.Size = UDim2.new(1, 0, 0, 30)
nALabel1.Position = UDim2.new(0, 0, 0, 10)
nALabel1.BackgroundTransparency = 1
nALabel1.Text = "N/A"
nALabel1.Font = Enum.Font.SourceSansBold
nALabel1.TextSize = 24
nALabel1.TextColor3 = Color3.new(1,1,1)
nALabel1.TextXAlignment = Enum.TextXAlignment.Center
nALabel1.Parent = rightTopFrame

local nALabel2 = Instance.new("TextLabel")
nALabel2.Name = "NALabel2"
nALabel2.Size = UDim2.new(1, 0, 0, 30)
nALabel2.Position = UDim2.new(0, 0, 0, 45)
nALabel2.BackgroundTransparency = 1
nALabel2.Text = "N/A"
nALabel2.Font = Enum.Font.SourceSansItalic
nALabel2.TextSize = 20
nALabel2.TextColor3 = Color3.fromRGB(255, 255, 150)
nALabel2.TextXAlignment = Enum.TextXAlignment.Center
nALabel2.Parent = rightTopFrame

local comprarButton = Instance.new("TextButton")
comprarButton.Name = "ComprarButton"
comprarButton.Size = UDim2.new(1, -20, 0, 40)
comprarButton.Position = UDim2.new(0, 10, 1, -50)
comprarButton.BackgroundColor3 = Color3.fromRGB(0, 140, 0)
comprarButton.BorderColor3 = Color3.fromRGB(20, 120, 20)
comprarButton.Text = "COMPRAR"
comprarButton.Font = Enum.Font.SourceSansBold
comprarButton.TextSize = 24
comprarButton.TextColor3 = Color3.new(1,1,1)
comprarButton.Parent = rightTopFrame

-- Frame direito inferior (remover acessórios)
local rightBottomFrame = Instance.new("Frame")
rightBottomFrame.Name = "RightBottomFrame"
rightBottomFrame.Size = UDim2.new(0, 230, 0, 130)
rightBottomFrame.Position = UDim2.new(0, 370, 0, 160)
rightBottomFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
rightBottomFrame.BorderColor3 = Color3.fromRGB(0,255,0)
rightBottomFrame.Parent = mainFrame

local removerLabel = Instance.new("TextLabel")
removerLabel.Name = "RemoverLabel"
removerLabel.Size = UDim2.new(1, 0, 0, 40)
removerLabel.Position = UDim2.new(0, 0, 0, 10)
removerLabel.BackgroundTransparency = 1
removerLabel.Text = "Remover\nAcessórios"
removerLabel.Font = Enum.Font.SourceSansBoldItalic
removerLabel.TextSize = 24
removerLabel.TextColor3 = Color3.new(1,1,1)
removerLabel.TextWrapped = true
removerLabel.TextYAlignment = Enum.TextYAlignment.Top
removerLabel.TextXAlignment = Enum.TextXAlignment.Center
removerLabel.Parent = rightBottomFrame

local removerButton = Instance.new("TextButton")
removerButton.Name = "RemoverButton"
removerButton.Size = UDim2.new(1, -20, 0, 40)
removerButton.Position = UDim2.new(0, 10, 1, -50)
removerButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
removerButton.BorderColor3 = Color3.fromRGB(120, 0, 0)
removerButton.Text = "> REMOVER"
removerButton.Font = Enum.Font.SourceSansBold
removerButton.TextSize = 24
removerButton.TextColor3 = Color3.fromRGB(255, 0, 0)
removerButton.Parent = rightBottomFrame

-- ================== VARIÁVEIS ==================
local acessorioSelecionado = nil
local itensComprados = {}
local itemEquipped = nil

-- Lista de acessórios
local acessorios = {
    {Nome="Boina", Preco=0, Id=1234, Icone="rbxassetid://12345678"},
    {Nome="Colete", Preco=3000, Id=1235, Icone="rbxassetid://12345678"},
    {Nome="Capa", Preco=5000, Id=1236, Icone="rbxassetid://12345678"},
    {Nome="Capacete", Preco=5000, Id=1237, Icone="rbxassetid://12345678"},
    {Nome="Ombro Direito", Preco=2500, Id=1238, Icone="rbxassetid://12345678"},
    {Nome="Ombro Esquerdo", Preco=2500, Id=1239, Icone="rbxassetid://12345678"},
    {Nome="Óculos", Preco=4500, Id=1240, Icone="rbxassetid://12345678"},
    {Nome="Cinto", Preco=3000, Id=1241, Icone="rbxassetid://12345678"}
}

-- Carregar itens comprados do atributo
local savedItens = player:GetAttribute("ItensComprados") or {}
for id,_ in pairs(savedItens) do
    itensComprados[id] = true
end

-- ================== FUNÇÕES ==================
local function atualizarLabels(acessorio)
    nALabel1.Text = acessorio.Nome
    nALabel2.Text = acessorio.Preco .. " R$"
    acessorioSelecionado = acessorio

    if itensComprados[acessorio.Id] then
        comprarButton.Text = "EQUIPAR"
    else
        comprarButton.Text = "COMPRAR"
    end
end

local function equiparItem(item)
    local char = player.Character
    if not char then return end

    if itemEquipped then
        local old = char:FindFirstChild(itemEquipped.Nome)
        if old then old:Destroy() end
    end

    itemEquipped = item
    local accessory = Instance.new("Accessory")
    accessory.Name = item.Nome
    accessory.Parent = char
end

-- ================== CRIAR QUADRADOS ==================
local quadradoSize = UDim2.new(0, 80, 0, 80)
local spacing = 10
local startX = 10
local startY = 290

for i, item in ipairs(acessorios) do
    local row = math.floor((i-1)/4)
    local col = (i-1) % 4

    local quadrado = Instance.new("Frame")
    quadrado.Name = "Quadrado"..i
    quadrado.Size = quadradoSize
    quadrado.Position = UDim2.new(0, startX + (quadradoSize.X.Offset + spacing) * col, 0, startY + (quadradoSize.Y.Offset + spacing) * row)
    quadrado.BackgroundColor3 = Color3.fromRGB(30,30,30)
    quadrado.BorderColor3 = Color3.fromRGB(0,255,0)
    quadrado.Parent = mainFrame

    local icone = Instance.new("ImageLabel")
    icone.Size = UDim2.new(1, -10, 1, -30)
    icone.Position = UDim2.new(0, 5, 0, 5)
    icone.BackgroundTransparency = 1
    icone.Image = item.Icone
    icone.Parent = quadrado

    local nomeLabel = Instance.new("TextLabel")
    nomeLabel.Size = UDim2.new(1, 0, 0, 25)
    nomeLabel.Position = UDim2.new(0, 0, 1, -25)
    nomeLabel.BackgroundTransparency = 1
    nomeLabel.Text = item.Nome
    nomeLabel.Font = Enum.Font.SourceSans
    nomeLabel.TextSize = 16
    nomeLabel.TextColor3 = Color3.new(1,1,1)
    nomeLabel.TextWrapped = true
    nomeLabel.TextXAlignment = Enum.TextXAlignment.Center
    nomeLabel.Parent = quadrado

    local botaoQuadrado = Instance.new("TextButton")
    botaoQuadrado.Size = UDim2.new(1,0,1,0)
    botaoQuadrado.Position = UDim2.new(0,0,0,0)
    botaoQuadrado.BackgroundTransparency = 1
    botaoQuadrado.Text = ""
    botaoQuadrado.Parent = quadrado
    botaoQuadrado.MouseButton1Click:Connect(function()
        atualizarLabels(item)
    end)
end

-- ================== EVENTOS BOTÕES ==================
comprarButton.MouseButton1Click:Connect(function()
    if not acessorioSelecionado then return end
    local money = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Money")
    if not money then return end
    local preco = acessorioSelecionado.Preco
    local id = acessorioSelecionado.Id

    if itensComprados[id] then
        equiparItem(acessorioSelecionado)
        print("Item equipado:", acessorioSelecionado.Nome)
    else
        if money.Value >= preco then
            money.Value = money.Value - preco
            itensComprados[id] = true
            player:SetAttribute("ItensComprados", itensComprados)
            comprarButton.Text = "EQUIPAR"
            print("Item comprado:", acessorioSelecionado.Nome)
        else
            print("Dinheiro insuficiente!")
        end
    end
end)

removerButton.MouseButton1Click:Connect(function()
    if itemEquipped then
        local char = player.Character
        local old = char:FindFirstChild(itemEquipped.Nome)
        if old then old:Destroy() end
        itemEquipped = nil
        print("Item removido")
    end
end)

-- Mostrar GUI
screenGui.Enabled = true