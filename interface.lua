-- GUI para Exército Brasileiro Hub v1.2.1
local ArmyHub = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Header = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local Tabs = Instance.new("Frame")
local TeleportTab = Instance.new("TextButton")
local CreditsTab = Instance.new("TextButton")
local AutoTab = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")
local TeleportContent = Instance.new("Frame")
local AllianceShop = Instance.new("TextButton")
local CreditsContent = Instance.new("Frame")
local Dev1 = Instance.new("TextLabel")
local Dev2 = Instance.new("TextLabel")
local AutoContent = Instance.new("Frame")
local AutoTorreButton = Instance.new("TextButton")

-- Propriedades da GUI principal
ArmyHub.Name = "ArmyHub"
ArmyHub.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ArmyHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame principal
MainFrame.Name = "MainFrame"
MainFrame.Parent = ArmyHub
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 400) -- Aumentado

-- Cabeçalho
Header.Name = "Header"
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Header.BorderSizePixel = 0
Header.Size = UDim2.new(1, 0, 0, 30)

MainFrame.Active = true
Header.Active = true
MainFrame.Draggable = true

-- Título
Title.Name = "Title"
Title.Parent = Header
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 5, 0, 0)
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Exército Brasileiro Hub v1.2.1"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14.0
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Botão Fechar
CloseButton.Name = "CloseButton"
CloseButton.Parent = Header
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(0.9, 0, 0, 0)
CloseButton.Size = UDim2.new(0.1, 0, 1, 0)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14.0

-- Botão Minimizar
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = Header
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Position = UDim2.new(0.8, 0, 0, 0)
MinimizeButton.Size = UDim2.new(0.1, 0, 1, 0)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 14.0

-- Barra de abas
Tabs.Name = "Tabs"
Tabs.Parent = MainFrame
Tabs.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Tabs.BorderSizePixel = 0
Tabs.Position = UDim2.new(0, 0, 0, 30)
Tabs.Size = UDim2.new(1, 0, 0, 30)

-- Aba Teleporte
TeleportTab.Name = "TeleportTab"
TeleportTab.Parent = Tabs
TeleportTab.BackgroundTransparency = 1
TeleportTab.Size = UDim2.new(0.333, 0, 1, 0)
TeleportTab.Font = Enum.Font.GothamBold
TeleportTab.Text = "Teleporte"
TeleportTab.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportTab.TextSize = 14.0

-- Aba Créditos
CreditsTab.Name = "CreditsTab"
CreditsTab.Parent = Tabs
CreditsTab.BackgroundTransparency = 1
CreditsTab.Position = UDim2.new(0.333, 0, 0, 0)
CreditsTab.Size = UDim2.new(0.333, 0, 1, 0)
CreditsTab.Font = Enum.Font.GothamBold
CreditsTab.Text = "Créditos"
CreditsTab.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditsTab.TextSize = 14.0

-- Aba Automação
AutoTab.Name = "AutoTab"
AutoTab.Parent = Tabs
AutoTab.BackgroundTransparency = 1
AutoTab.Position = UDim2.new(0.666, 0, 0, 0)
AutoTab.Size = UDim2.new(0.333, 0, 1, 0)
AutoTab.Font = Enum.Font.GothamBold
AutoTab.Text = "Automação"
AutoTab.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoTab.TextSize = 14.0

-- Frame de conteúdo
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ContentFrame.BorderSizePixel = 0
ContentFrame.Position = UDim2.new(0, 0, 0, 60)
ContentFrame.Size = UDim2.new(1, 0, 1, -60)

-- Conteúdo Teleporte
TeleportContent.Name = "TeleportContent"
TeleportContent.Parent = ContentFrame
TeleportContent.BackgroundTransparency = 1
TeleportContent.Size = UDim2.new(1, 0, 1, 0)
TeleportContent.Visible = true

-- Botão Loja da Aliança
AllianceShop.Name = "AllianceShop"
AllianceShop.Parent = TeleportContent
AllianceShop.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AllianceShop.BorderSizePixel = 0
AllianceShop.Position = UDim2.new(0.1, 0, 0.1, 0)
AllianceShop.Size = UDim2.new(0.8, 0, 0.2, 0)
AllianceShop.Font = Enum.Font.GothamBold
AllianceShop.Text = "Loja da Aliança"
AllianceShop.TextColor3 = Color3.fromRGB(255, 255, 255)
AllianceShop.TextSize = 14.0

-- Conteúdo Créditos
CreditsContent.Name = "CreditsContent"
CreditsContent.Parent = ContentFrame
CreditsContent.BackgroundTransparency = 1
CreditsContent.Size = UDim2.new(1, 0, 1, 0)
CreditsContent.Visible = false

-- Creditos Dev 1
Dev1.Name = "Dev1"
Dev1.Parent = CreditsContent
Dev1.BackgroundTransparency = 1
Dev1.Position = UDim2.new(0.1, 0, 0.2, 0)
Dev1.Size = UDim2.new(0.8, 0, 0.1, 0)
Dev1.Font = Enum.Font.Gotham
Dev1.Text = "- Dev yurizing139"
Dev1.TextColor3 = Color3.fromRGB(255, 255, 255)
Dev1.TextSize = 14.0
Dev1.TextXAlignment = Enum.TextXAlignment.Left

-- Creditos Dev 2
Dev2.Name = "Dev2"
Dev2.Parent = CreditsContent
Dev2.BackgroundTransparency = 1
Dev2.Position = UDim2.new(0.1, 0, 0.3, 0)
Dev2.Size = UDim2.new(0.8, 0, 0.1, 0)
Dev2.Font = Enum.Font.Gotham
Dev2.Text = "- Dev GabrielBStar2"
Dev2.TextColor3 = Color3.fromRGB(255, 255, 255)
Dev2.TextSize = 14.0
Dev2.TextXAlignment = Enum.TextXAlignment.Left

-- Conteúdo Automação
AutoContent.Name = "AutoContent"
AutoContent.Parent = ContentFrame
AutoContent.BackgroundTransparency = 1
AutoContent.Size = UDim2.new(1, 0, 1, 0)
AutoContent.Visible = false

-- Botão Auto Torre v3
AutoTorreButton.Name = "AutoTorreButton"
AutoTorreButton.Parent = AutoContent
AutoTorreButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AutoTorreButton.BorderSizePixel = 0
AutoTorreButton.Position = UDim2.new(0.1, 0, 0.1, 0)
AutoTorreButton.Size = UDim2.new(0.8, 0, 0.2, 0)
AutoTorreButton.Font = Enum.Font.GothamBold
AutoTorreButton.Text = "Auto Torre v3"
AutoTorreButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoTorreButton.TextSize = 14.0

-- Código executado ao clicar no botão Auto Torre v3
AutoTorreButton.Activated:Connect(function()
    loadstring(game:HttpGet("colocar aq"))()
end)

-- Lógica da GUI
local function toggleTab(selectedTab)
    -- Resetar cores
    TeleportTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    CreditsTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    AutoTab.TextColor3 = Color3.fromRGB(255, 255, 255)

    -- Esconder todos os conteúdos
    TeleportContent.Visible = false
    CreditsContent.Visible = false
    AutoContent.Visible = false

    -- Ativar o conteúdo correto
    selectedTab.TextColor3 = Color3.fromRGB(0, 100, 0)
    if selectedTab == TeleportTab then
        TeleportContent.Visible = true
    elseif selectedTab == CreditsTab then
        CreditsContent.Visible = true
    elseif selectedTab == AutoTab then
        AutoContent.Visible = true
    end
end

-- Troca de abas
TeleportTab.Activated:Connect(function()
    toggleTab(TeleportTab)
end)

CreditsTab.Activated:Connect(function()
    toggleTab(CreditsTab)
end)

AutoTab.Activated:Connect(function()
    toggleTab(AutoTab)
end)

-- Fechar GUI
CloseButton.Activated:Connect(function()
    ArmyHub:Destroy()
end)

-- Minimizar GUI
MinimizeButton.Activated:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Teleporte Loja da Aliança
AllianceShop.Activated:Connect(function()
    local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(Vector3.new(-922.120949609375, 49.01183319091797, 578.9318237304688))
        end
    end
end)