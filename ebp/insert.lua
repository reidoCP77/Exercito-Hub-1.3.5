-- Referências
local Players = game:GetService("Players")
local ChatService = game:GetService("Chat")

local Frame = script.Parent
local SubFrame = Frame:WaitForChild("Frame") -- o Frame que contém o TextBox
local TextBox = SubFrame:WaitForChild("TextBox") -- TextBox dentro do SubFrame
local BotaoAdd = Frame:WaitForChild("BotaoAdd")
local ScrollingFrame = Frame:WaitForChild("ScrollingFrame")

-- Configurações
local espacamento = 10
local alturaItem = 30

-- Função que reorganiza os itens após remover
local function reorganizarItens()
	local index = 0
	for _, item in ipairs(ScrollingFrame:GetChildren()) do
		if item:IsA("Frame") then
			index += 1
			item.Position = UDim2.new(0, 5, 0, (index - 1) * (alturaItem + espacamento))
		end
	end
end

-- Função para criar novo item
local function criarItem(texto)
	local posY = #ScrollingFrame:GetChildren() * (alturaItem + espacamento)

	-- Frame do item
	local item = Instance.new("Frame")
	item.Size = UDim2.new(0.95, 0, 0, alturaItem)
	item.Position = UDim2.new(0, 5, 0, posY)
	item.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	item.BorderSizePixel = 0
	item.Parent = ScrollingFrame
 
	-- Botão principal (com texto)
	local botao = Instance.new("TextButton")
	botao.Size = UDim2.new(0.8, -5, 1, 0)
	botao.Position = UDim2.new(0, 0, 0, 0)
	botao.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	botao.TextColor3 = Color3.fromRGB(255, 255, 255)
	botao.Font = Enum.Font.FredokaOne
	botao.TextSize = 16
	botao.Text = texto
	botao.Parent = item
 local UICorner = Instance.new("UICorner")
 UICorner.Parent = botao
	local remover = Instance.new("TextButton")
	remover.Size = UDim2.new(0.2, -5, 1, 0)
	remover.Position = UDim2.new(0.8, 5, 0, 0)
	remover.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
	remover.TextColor3 = Color3.fromRGB(255, 255, 255)
	remover.Font = Enum.Font.GothamBold
	remover.TextSize = 18
	remover.Text = "-"
	remover.Parent = item
 botao.BackgroundTransparency = 0
	-- Quando clicar no botão "-", remove o item
	remover.MouseButton1Click:Connect(function()
		item:Destroy()
		reorganizarItens()
	end)
 remover.BackgroundTransparency = 1
	-- pc
	botao.MouseButton1Click:Connect(function()
		local player = Players.LocalPlayer
		if player and player.Character and player.Character:FindFirstChild("Head") then
			ChatService:Chat(player.Character.Head, botao.Text, Enum.ChatColor.White)
		end
	end)
end

BotaoAdd.MouseButton1Click:Connect(function()
	local texto = TextBox.Text
	if texto ~= "" then
		criarItem(texto)
		TextBox.Text = "" -- limpa o campo
	end
end)