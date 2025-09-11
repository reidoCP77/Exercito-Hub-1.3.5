local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- Variáveis
local screenGui = player:WaitForChild("PlayerGui"):WaitForChild("ArmarioGUI")
local comprarButton = screenGui.MainFrame.RightTopFrame.ComprarButton
local nALabel1 = screenGui.MainFrame.RightTopFrame.NALabel1
local nALabel2 = screenGui.MainFrame.RightTopFrame.NALabel2

local acessorioSelecionado = nil
local itensComprados = {} -- vai armazenar IDs dos itens comprados
local itemEquipped = nil

-- Função para atualizar labels e selecionar acessório
local function atualizarLabels(acessorio)
nALabel1.Text = acessorio.Nome
nALabel2.Text = acessorio.Preco .. " R$"
acessorioSelecionado = acessorio

-- Verifica se o item já foi comprado if itensComprados[acessorio.Id] then comprarButton.Text = "EQUIPAR" else comprarButton.Text = "COMPRAR" end 

end
-- Equipar item no personagem
local function equiparItem(item)
-- Exemplo: colocar no Torso
local char = player.Character
if not char then return end

-- Remover item equipado anterior if itemEquipped and itemEquipped.Model then local old = char:FindFirstChild(itemEquipped.Nome) if old then old:Destroy() end end itemEquipped = item -- Criar modelo do acessório (exemplo simples) local accessory = Instance.new("Accessory") accessory.Name = item.Nome -- Você pode colocar um MeshPart ou decal no accessory accessory.Parent = char 

end
-- Carregar itens comprados do atributo
local savedItens = player:GetAttribute("ItensComprados") or {}
for id,_ in pairs(savedItens) do
itensComprados[id] = true
end

