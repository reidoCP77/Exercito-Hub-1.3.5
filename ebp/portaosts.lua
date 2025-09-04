-- LocalScript dentro do botão GUI
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- CONFIG
local GROUP_ID = 1234567 -- coloque o ID do seu grupo
local RANK_MIN = 7

-- Objetos
local player = Players.LocalPlayer
local button = script.Parent
local porta = workspace:WaitForChild("Portao") -- peça do portão
local botao = workspace:WaitForChild("Botao") -- peça física do botão

-- Posições
local posInicial = CFrame.new(40.947, 15.575, -943.484)
local posFinal = CFrame.new(40.99, 11.548, -928.118)

-- Controle
local aberto = false
local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

-- Função que alterna o portão
local function toggleGate()
	local rank = player:GetRankInGroup(GROUP_ID)
	if rank >= RANK_MIN then
		if aberto then
			-- SUBIR
			local tween = TweenService:Create(porta, tweenInfo, {CFrame = posInicial})
			tween:Play()
			botao.Color = Color3.fromRGB(255, 255, 255) -- branco
			aberto = false
		else
			-- DESCER
			local tween = TweenService:Create(porta, tweenInfo, {CFrame = posFinal})
			tween:Play()
			botao.Color = Color3.fromRGB(255, 0, 0) -- vermelho
			aberto = true
		end
	else
		warn("Você não tem rank suficiente para abrir o portão.")
	end
end

-- 📱 Mobile (botão GUI)
button.MouseButton1Click:Connect(toggleGate)

-- ⌨️ PC (tecla Z) e 🎮 Console (tecla X)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	-- PC - tecla Z
	if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Z then
		toggleGate()
	end
	
	-- Console - botão X
	if input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonX then
		toggleGate()
	end
end)