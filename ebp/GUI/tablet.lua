local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local DataStoreService = game:GetService("DataStoreService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local tablet = player:WaitForChild("PlayerGui"):WaitForChild("Tablet")
local mainFrame = tablet:WaitForChild("MainFrame")
local background = mainFrame:WaitForChild("Background")
mainFrame.Active = true
mainFrame.Draggable = true
local pages = background:WaitForChild("Pages")
local customCommandsPage = pages:WaitForChild("CustomCommands")
local buttonsFrame = customCommandsPage:WaitForChild("Buttons")
local commandTextBox = buttonsFrame:WaitForChild("TextBox")
local plusBtn = buttonsFrame:WaitForChild("Plus")
local commandsScrollingFrame = customCommandsPage:WaitForChild("ScrollingFrame")
local RemoteChatSouls = ReplicatedStorage:FindFirstChild("RemoteChatSouls")
if not commandsScrollingFrame:FindFirstChild("UIListLayout") then
local layout = Instance.new("UIListLayout")
layout.Name = "UIListLayout"
layout.Parent = commandsScrollingFrame
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 5)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
end
if not commandsScrollingFrame:FindFirstChild("UIPadding") then
local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 8)
padding.PaddingBottom = UDim.new(0, 8)
padding.PaddingLeft = UDim.new(0, 5)
padding.PaddingRight = UDim.new(0, 5)
padding.Parent = commandsScrollingFrame
end
local comandosSalvos = {}
local isLoading = false
local isSaving = false
local customCommandsDataStore
local dataStoreEnabled = false
local function salvarComandos()
if isSaving then
return
end
isSaving = true
if dataStoreEnabled and customCommandsDataStore then
spawn(function()
local success, errorMessage = pcall(function()
local dataToSave = {
commands = comandosSalvos,
timestamp = os.time(),
playerName = player.Name
}
customCommandsDataStore:SetAsync(player.UserId, dataToSave)
end)
isSaving = false
end)
else
isSaving = false
end
end
local function carregarComandos()
if isLoading then
return
end
isLoading = true
if dataStoreEnabled and customCommandsDataStore then
spawn(function()
local success, data = pcall(function()
return customCommandsDataStore:GetAsync(player.UserId)
end)
if success and data and type(data) == "table" and data.commands then
comandosSalvos = data.commands
for _, comando in ipairs(comandosSalvos) do
criarElementoComando(comando, false)
end
else
comandosSalvos = {}
end
isLoading = false
end)
else
comandosSalvos = {}
isLoading = false
end
end
local function enviarMensagemBalao(msg)
if RemoteChatSouls then
RemoteChatSouls:FireServer(msg)
else
print(msg)
end
end
function criarElementoComando(textoComando, salvarAgora)
if salvarAgora == nil then salvarAgora = true end
for , child in ipairs(commandsScrollingFrame:GetChildren()) do
if child.Name:find("ComandoContainer") and child:FindFirstChild("ComandoLabel") then
if child.ComandoLabel.Text == textoComando then
return
end
end
end
local comandoContainer = Instance.new("Frame")
comandoContainer.Name = "ComandoContainer" .. tostring(math.floor(tick()*1000))
comandoContainer.Parent = commandsScrollingFrame
comandoContainer.Size = UDim2.new(1, -10, 0, 40)
comandoContainer.BackgroundTransparency = 1
comandoContainer.BorderSizePixel = 0

local comandoLabel = Instance.new("TextButton") comandoLabel.Name = "ComandoLabel" comandoLabel.Parent = comandoContainer comandoLabel.Size = UDim2.new(1, -45, 1, 0) comandoLabel.Position = UDim2.new(0, 0, 0, 0) comandoLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45) comandoLabel.BackgroundTransparency = 0.2 comandoLabel.BorderSizePixel = 0 comandoLabel.Text = textoComando comandoLabel.TextColor3 = Color3.fromRGB(255, 255, 255) comandoLabel.TextScaled = true comandoLabel.TextWrapped = true comandoLabel.Font = Enum.Font.SourceSans comandoLabel.TextXAlignment = Enum.TextXAlignment.Left comandoLabel.AutoButtonColor = false local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, 8) corner.Parent = comandoLabel local padding = Instance.new("UIPadding") padding.PaddingLeft = UDim.new(0, 12) padding.PaddingRight = UDim.new(0, 12) padding.PaddingTop = UDim.new(0, 6) padding.PaddingBottom = UDim.new(0, 6) padding.Parent = comandoLabel local removeBtn = Instance.new("TextButton") removeBtn.Name = "RemoveBtn" removeBtn.Parent = comandoContainer removeBtn.Size = UDim2.new(0, 35, 1, 0) removeBtn.Position = UDim2.new(1, -40, 0, 0) removeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) removeBtn.BackgroundTransparency = 0.2 removeBtn.BorderSizePixel = 0 removeBtn.Text = "✕" removeBtn.TextColor3 = Color3.fromRGB(255, 255, 255) removeBtn.TextScaled = true removeBtn.Font = Enum.Font.SourceSansBold removeBtn.AutoButtonColor = true local removeBtnCorner = Instance.new("UICorner") removeBtnCorner.CornerRadius = UDim.new(0, 8) removeBtnCorner.Parent = removeBtn comandoLabel.MouseButton1Click:Connect(function() 	enviarMensagemBalao(textoComando) 	comandoLabel.BackgroundTransparency = 0.5 	wait(0.1) 	comandoLabel.BackgroundTransparency = 0.2 end) removeBtn.MouseButton1Click:Connect(function() 	for i, comando in ipairs(comandosSalvos) do 		if comando == textoComando then 			table.remove(comandosSalvos, i) 			break 		end 	end 	comandoContainer:Destroy() 	if salvarAgora then 		salvarComandos() 	end end) comandoLabel.MouseEnter:Connect(function() 	comandoLabel.BackgroundTransparency = 0.1 end) comandoLabel.MouseLeave:Connect(function() 	comandoLabel.BackgroundTransparency = 0.2 end) 

end
local function adicionarComandoCustomizado()
local textoComando = commandTextBox.Text:gsub("^%s*(.-)%s*$", "%1")
if textoComando == "" then
return
end
if #textoComando > 200 then
return
end
for _, comando in ipairs(comandosSalvos) do
if comando == textoComando then
return
end
end
table.insert(comandosSalvos, textoComando)
criarElementoComando(textoComando, true)
salvarComandos()
commandTextBox.Text = ""
end
plusBtn.MouseButton1Click:Connect(adicionarComandoCustomizado)
commandTextBox.FocusLost:Connect(function(enterPressed)
if enterPressed then
adicionarComandoCustomizado()
end
end)
spawn(function()
wait(3)
carregarComandos()
end)
spawn(function()
while true do
wait(10)
if #comandosSalvos > 0 and not isSaving then
salvarComandos()
end
end
end)
Players.PlayerRemoving:Connect(function(leavingPlayer)
if leavingPlayer == player and #comandosSalvos > 0 then
salvarComandos()
end
end)
local appsPage = pages:WaitForChild("Apps")
local loginPage = pages:WaitForChild("Login")
local connectBtn = loginPage:WaitForChild("Connect")
local leaveBtn = loginPage:FindFirstChild("Leave")
local playerNameLabel = loginPage:FindFirstChild("PlayerName")
local reportsPage = pages:FindFirstChild("Reports")
local recrutamentoBtn, treinamentoBtn, reportTextBox
if reportsPage then
recrutamentoBtn = reportsPage:FindFirstChild("Recrutamento")
treinamentoBtn = reportsPage:FindFirstChild("Treinamento")
reportTextBox = reportsPage:FindFirstChild("TextBox")
end
local rulesPage = pages:WaitForChild("Rules")
local scrollingFrame = rulesPage:WaitForChild("ScrollingFrame")
local rulesModule = tablet.MainFrame.TabletHandler:FindFirstChild("Rules")
local regrasOriginais = require(rulesModule)
local pontosJogadores = {}
local groupId = 387273307 -- ID DO SEU GRUPO AQUI
local function getCargoCompleto(playerObj)
local rank = playerObj:GetRankInGroup(groupId)
local role = playerObj:GetRoleInGroup(groupId)
if rank == 0 then
return "Guest"
else
return role
end
end
local function processarRegras(playerObj)
local regrasProcessadas = {}
local patente = getCargoCompleto(playerObj)
local nome = "@" .. playerObj.Name
for i, regra in ipairs(regrasOriginais) do
local regraProcessada = regra
regraProcessada = string.gsub(regraProcessada, "%[PATENTE%]", patente)
regraProcessada = string.gsub(regraProcessada, "%[NOME%]", nome)
table.insert(regrasProcessadas, regraProcessada)
end
return regrasProcessadas
end
local function preencherRegras()
for _, child in ipairs(scrollingFrame:GetChildren()) do
if child:IsA("TextButton") and child.Name:match("^Regra%d+$") then
child:Destroy()
end
end
local template = scrollingFrame:FindFirstChild("RegraTemplate")
if template then
template.Visible = false
end
local regrasProcessadas = processarRegras(player)
local totalRegras = #regrasProcessadas
local alturaRegra = 60
local espacamentoExtra = 20
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, (totalRegras * alturaRegra) + espacamentoExtra)
for i, regra in ipairs(regrasProcessadas) do
local novaRegra = Instance.new("TextButton")
novaRegra.Name = "Regra" .. i
novaRegra.Parent = scrollingFrame
novaRegra.Size = UDim2.new(0.95, 0, 0, 50)
novaRegra.Position = UDim2.new(0.025, 0, 0, (i-1) * alturaRegra + 10)
novaRegra.AnchorPoint = Vector2.new(0, 0)
novaRegra.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
novaRegra.BackgroundTransparency = 0.2
novaRegra.BorderSizePixel = 0
novaRegra.Text = regra
novaRegra.TextColor3 = Color3.fromRGB(255, 255, 255)
novaRegra.TextScaled = true
novaRegra.TextWrapped = true
novaRegra.Font = Enum.Font.SourceSans
novaRegra.TextXAlignment = Enum.TextXAlignment.Left
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 25)
corner.Parent = novaRegra
local padding = Instance.new("UIPadding")
padding.PaddingLeft = UDim.new(0, 15)
padding.PaddingRight = UDim.new(0, 15)
padding.PaddingTop = UDim.new(0, 8)
padding.PaddingBottom = UDim.new(0, 8)
padding.Parent = novaRegra
novaRegra.MouseButton1Click:Connect(function()
enviarMensagemBalao(regra)
end)
novaRegra.MouseEnter:Connect(function()
novaRegra.BackgroundTransparency = 0.1
end)
novaRegra.MouseLeave:Connect(function()
novaRegra.BackgroundTransparency = 0.2
end)
end
end
local function getDataHora()
local now = os.date("*t")
return string.format("%02d/%02d/%04d às %02d:%02d", now.day, now.month, now.year, now.hour, now.min)
end
local function obterParticipantesPontuacao()
local participantes = {}
local aprovados = {}
for nomeJogador, pontos in pairs(pontosJogadores) do
if pontos and pontos > 0 then
table.insert(participantes, nomeJogador .. " - " .. pontos .. " pontos")
if pontos >= 5 then
table.insert(aprovados, nomeJogador)
end
end
end
return participantes, aprovados
end
local function gerarRelatorioAlistamento()
local patente = getCargoCompleto(player)
local dataHora = getDataHora()
local participantes, aprovados = obterParticipantesPontuacao()
local participantesTexto = ""
for i, participante in ipairs(participantes) do
participantesTexto = participantesTexto .. participante .. "\n"
end
if participantesTexto == "" then
participantesTexto = "[NENHUM PARTICIPANTE REGISTRADO]"
end
local aprovadosTexto = ""
for i, aprovado in ipairs(aprovados) do
aprovadosTexto = aprovadosTexto .. aprovado .. "\n"
end
if aprovadosTexto == "" then
aprovadosTexto = "[NENHUM APROVADO]"
end
local relatorio = string.format([[> ⌠ RELATÓRIO DE ALISTAMENTO ⌡

─────────────────────────────
• Tutor: %s (%s)
• Função: %s
• Auxiliares: [INSERIR AUXILIARES]
─────────────────────────────
Participantes e Pontuação:
%s
Aprovados:
%s
─────────────────────────────
Data e hora: %s
• Comprovações: Imagens.
─────────────────────────────]], player.Name, player.Name, patente, participantesTexto, aprovadosTexto, dataHora)
return relatorio
end
local function gerarRelatorioPromocao()
local patente = getCargoCompleto(player)
local dataHora = getDataHora()
local participantes, aprovados = obterParticipantesPontuacao()
local participantesTexto = ""
for i, participante in ipairs(participantes) do
participantesTexto = participantesTexto .. participante .. "\n"
end
if participantesTexto == "" then
participantesTexto = "[NENHUM PARTICIPANTE REGISTRADO]"
end
local promovidosTexto = ""
for i, promovido in ipairs(aprovados) do
promovidosTexto = promovidosTexto .. promovido .. "\n"
end
if promovidosTexto == "" then
promovidosTexto = "[NENHUM PROMOVIDO]"
end
local relatorio = string.format([[> ⌠ RELATÓRIO DE PROMOÇÃO ⌡
─────────────────────────────
• Aplicador(a): %s (%s)
• Função do tutor: %s
• Auxiliares: [INSERIR AUXILIARES]
─────────────────────────────
• Participantes:
%s
• Promovidos:
%s
─────────────────────────────
• Função antiga: [INSERIR FUNÇÃO ANTIGA]
• Nova função: [INSERIR NOVA FUNÇÃO]
• Nova CDP: [INSERIR CDP]
─────────────────────────────
Data e hora: %s]], player.Name, player.Name, patente, participantesTexto, promovidosTexto, dataHora)
return relatorio
end
local function showPage(pageToShow)
for _, page in ipairs(pages:GetChildren()) do
if page:IsA("GuiObject") then
page.Visible = (page == pageToShow)
end
end
if pageToShow == rulesPage then
preencherRegras()
end
end
showPage(loginPage)
if playerNameLabel then
playerNameLabel.Text = "@" .. player.Name
end
connectBtn.MouseButton1Click:Connect(function()
showPage(appsPage)
end)
if leaveBtn then
leaveBtn.MouseButton1Click:Connect(function()
mainFrame.Visible = false
end)
end
if recrutamentoBtn and reportTextBox then
recrutamentoBtn.MouseButton1Click:Connect(function()
local relatorio = gerarRelatorioAlistamento()
reportTextBox.Text = relatorio
end)
end
if treinamentoBtn and reportTextBox then
treinamentoBtn.MouseButton1Click:Connect(function()
local relatorio = gerarRelatorioPromocao()
reportTextBox.Text = relatorio
end)
end
for , appBtn in ipairs(appsPage.Frame:GetChildren()) do
if appBtn:IsA("ImageButton") then
appBtn.MouseButton1Click:Connect(function()
local page = pages:FindFirstChild(appBtn.Name)
if page and page:IsA("ImageLabel") then
showPage(page)
end
end)
end
end
for , page in ipairs(pages:GetChildren()) do
if page:IsA("ImageLabel") then
local backBtn = page:FindFirstChild("Back")
if backBtn and (backBtn:IsA("TextButton") or backBtn:IsA("ImageButton")) then
backBtn.MouseButton1Click:Connect(function()
showPage(appsPage)
end)
end
end
end
local pontuationPage = pages:WaitForChild("Pontuation")
local pontuationScroll = pontuationPage:WaitForChild("ScrollingFrame")
local pontuationCleanBtn = pontuationPage:FindFirstChild("Clean")
local pontuationBackBtn = pontuationPage:FindFirstChild("Back")
local function getCargo(playerObj)
local rank = playerObj:GetRankInGroup(groupId)
if rank == 0 then
return "[CI] Cidadão"
elseif rank == 1 then
return "[AP] Aprendiz"
elseif rank == 2 then
return "[AS] Associado"
end
return "[?] Desconhecido"
end
local function adicionarJogador(playerObj)
if pontuationScroll:FindFirstChild("Player"..playerObj.Name) then return end
local ficha = Instance.new("Frame")
ficha.Name = "Player"..playerObj.Name
ficha.Parent = pontuationScroll
ficha.BackgroundColor3 = Color3.fromRGB(35,35,35)
ficha.BackgroundTransparency = 0.3
ficha.BorderSizePixel = 0
ficha.Size = UDim2.new(0.97, 0, 0, 40)
ficha.AnchorPoint = Vector2.new(0.5,0)
ficha.Position = UDim2.new(0.5,0,0,0)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,8)
corner.Parent = ficha
local avatar = Instance.new("ImageLabel")
avatar.Name = "Avatar"
avatar.Parent = ficha
avatar.BackgroundTransparency = 1
avatar.Size = UDim2.new(0, 28, 0, 28)
avatar.Position = UDim2.new(0, 6, 0.5, -14)
avatar.ScaleType = Enum.ScaleType.Fit
local success, thumb = pcall(function()
return Players:GetUserThumbnailAsync(playerObj.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
end)
avatar.Image = success and thumb or ""
local dados = Instance.new("Frame")
dados.Name = "Dados"
dados.Parent = ficha
dados.BackgroundTransparency = 1
dados.Size = UDim2.new(0.43, 0, 1, 0)
dados.Position = UDim2.new(0, 36, 0, 0)
local nameLabel = Instance.new("TextLabel")
nameLabel.Name = "PlayerName"
nameLabel.Parent = dados
nameLabel.BackgroundTransparency = 1
nameLabel.Size = UDim2.new(1, 0, 0.52, 0)
nameLabel.Position = UDim2.new(0, 0, 0, 0)
nameLabel.Text = playerObj.Name
nameLabel.TextColor3 = Color3.fromRGB(230,230,230)
nameLabel.Font = Enum.Font.SourceSansSemibold
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
nameLabel.TextScaled = true
nameLabel.TextWrapped = true
local cargoLabel = Instance.new("TextLabel")
cargoLabel.Name = "Cargo"
cargoLabel.Parent = dados
cargoLabel.BackgroundTransparency = 1
cargoLabel.Size = UDim2.new(1, 0, 0.48, 0)
cargoLabel.Position = UDim2.new(0, 0, 0.52, 0)
cargoLabel.Text = getCargo(playerObj)
cargoLabel.TextColor3 = Color3.fromRGB(180,180,180)
cargoLabel.Font = Enum.Font.SourceSans
cargoLabel.TextXAlignment = Enum.TextXAlignment.Left
cargoLabel.TextScaled = true
cargoLabel.TextWrapped = true
local controles = Instance.new("Frame")
controles.Name = "Controles"
controles.Parent = ficha
controles.BackgroundTransparency = 1
controles.Size = UDim2.new(0.52, 0, 1, 0)
controles.Position = UDim2.new(0.47, 0, 0, 0)
local layout = Instance.new("UIListLayout")
layout.Parent = controles
layout.FillDirection = Enum.FillDirection.Horizontal
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Padding = UDim.new(0, 2)
local function makeButton(txt, color, txtColor)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 20, 0, 20)
btn.Text = txt
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 14
btn.BackgroundColor3 = color
btn.TextColor3 = txtColor or Color3.new(1,1,1)
btn.AutoButtonColor = true
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1,0)
corner.Parent = btn
return btn
end
local btnMenos = makeButton("-", Color3.fromRGB(200,50,50))
btnMenos.Name = "BtnMenos"
btnMenos.Parent = controles
local pontos = Instance.new("TextLabel")
pontos.Name = "Pontos"
pontos.Parent = controles
pontos.Size = UDim2.new(0, 20, 0, 20)
pontos.Text = tostring(pontosJogadores[playerObj.Name] or 0)
pontos.TextColor3 = Color3.fromRGB(255,255,255)
pontos.BackgroundTransparency = 1
pontos.Font = Enum.Font.SourceSansBold
pontos.TextSize = 14
pontos.TextXAlignment = Enum.TextXAlignment.Center
pontos.TextScaled = true
pontos.TextWrapped = true
local btnMais = makeButton("+", Color3.fromRGB(44, 150, 44))
btnMais.Name = "BtnMais"
btnMais.Parent = controles
local btnRemover = makeButton("X", Color3.fromRGB(110, 44, 44), Color3.new(1,0.3,0.3))
btnRemover.Name = "BtnRemover"
btnRemover.Parent = controles
if pontosJogadores[playerObj.Name] == nil then
pontosJogadores[playerObj.Name] = 0
end
btnMais.MouseButton1Click:Connect(function()
pontosJogadores[playerObj.Name] = pontosJogadores[playerObj.Name] + 1
pontos.Text = tostring(pontosJogadores[playerObj.Name])
end)
btnMenos.MouseButton1Click:Connect(function()
pontosJogadores[playerObj.Name] = pontosJogadores[playerObj.Name] - 1
pontos.Text = tostring(pontosJogadores[playerObj.Name])
end)
btnRemover.MouseButton1Click:Connect(function()
ficha:Destroy()
pontosJogadores[playerObj.Name] = nil
end)
end
mouse.Button1Down:Connect(function()
if not pontuationPage.Visible then return end
local target = mouse.Target
if target and target.Parent then
local plr = Players:GetPlayerFromCharacter(target.Parent)
if plr and plr ~= player then
adicionarJogador(plr)
end
end
end)
if pontuationCleanBtn then
pontuationCleanBtn.MouseButton1Click:Connect(function()
for , v in pairs(pontuationScroll:GetChildren()) do
if v:IsA("Frame") and v.Name:sub(1,7) == "Player" then
v:Destroy()
end
end
for k in pairs(pontosJogadores) do
pontosJogadores[k] = nil
end
end)
end
if pontuationBackBtn then
pontuationBackBtn.MouseButton1Click:Connect(function()
showPage(appsPage)
end)
end
if not pontuationScroll:FindFirstChild("UIListLayout") then
local layout = Instance.new("UIListLayout")
layout.Parent = pontuationScroll
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 4)
end
local notesPage = pages:WaitForChild("Notes")
local notesTextBox = notesPage:WaitForChild("TextBox")
local notesBackBtn = notesPage:FindFirstChild("Back")
local notesClearBtn = notesPage:FindFirstChild("Clear")
local notesSaveBtn = notesPage:FindFirstChild("Save")
local notesClickEnabled = false
local function updateNotesClickState()
notesClickEnabled = notesPage.Visible
end
notesPage:GetPropertyChangedSignal("Visible"):Connect(updateNotesClickState)
local function adicionarJogadorNotes(playerObj)
local cargo = getCargo(playerObj)
local dataHora = os.date("%H:%M")
local infoJogador = string.format("[%s] %s - %s", dataHora, playerObj.Name, cargo)
if notesTextBox.Text == "" then
notesTextBox.Text = infoJogador
else
notesTextBox.Text = notesTextBox.Text .. "\n" .. infoJogador
end
end
mouse.Button1Down:Connect(function()
local target = mouse.Target
if target and target.Parent then
local plr = Players:GetPlayerFromCharacter(target.Parent)
if plr and plr ~= player then
if pontuationPage.Visible then
adicionarJogador(plr)
end
if notesClickEnabled and notesPage.Visible then
adicionarJogadorNotes(plr)
end
end
end
end)
if notesBackBtn then
notesBackBtn.MouseButton1Click:Connect(function()
showPage(appsPage)
end)
end
scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
if not scrollingFrame:FindFirstChild("UIListLayout") then
    local layout = Instance.new("UIListLayout")
    layout.Parent = scrollingFrame
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 10)
end
if notesClearBtn then
notesClearBtn.MouseButton1Click:Connect(function()
notesTextBox.Text = ""
end)
end
if notesSaveBtn then
notesSaveBtn.MouseButton1Click:Connect(function()
local textoNotas = notesTextBox.Text
if textoNotas ~= "" then
enviarMensagemBalao("📝 Anotações: " .. textoNotas:sub(1, 100) .. (textoNotas:len() > 100 and "..." or ""))
end
end)
end
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local function debugPrint(...)
end
local tablet = player.PlayerGui:WaitForChild("Tablet")
local timerPage = tablet.MainFrame.Background.Pages.Timer
local previewFrame = timerPage.Preview
local minutesTextBox = previewFrame.Minutes
local startBtn = timerPage.Start
local function formatarTempo(segundos)
segundos = math.max(0, math.floor(segundos))
local mins = math.floor(segundos / 60)
local secs = segundos % 60
local res = string.format("%02d:%02d", mins, secs)
return res
end
local function parseTempo(str)
    str = tostring(str):gsub("%s", "")
    if str:find(":") then
        local mm, ss = str:match("^(%d+):(%d+)$")
        mm, ss = tonumber(mm), tonumber(ss)
        if mm and ss then
            return mm * 60 + ss
        end
    end
    local num = tonumber(str)
    if num then
        return num * 60 -- minutos convertidos em segundos
    end
    return 0
end
local timerAtivo = false
local tempoRestante = 0
local conexaoTimer = nil
local valorOriginal = ""
local function setEditable(edit)
minutesTextBox.TextEditable = edit
minutesTextBox.ClearTextOnFocus = edit
if edit then
minutesTextBox.Font = Enum.Font.SourceSans
minutesTextBox.TextScaled = false
else
minutesTextBox.Font = Enum.Font.SourceSansBold
minutesTextBox.TextScaled = true
end
end
local function iniciarTimer()
local texto = minutesTextBox.Text
local segundos = parseTempo(texto)
if not segundos or segundos <= 0 or segundos > 3600 then
minutesTextBox.Text = "00:00"
return
end
tempoRestante = segundos
timerAtivo = true
valorOriginal = texto
setEditable(false)
minutesTextBox.Text = formatarTempo(tempoRestante)
startBtn.Text = "Parar"
startBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
if conexaoTimer then conexaoTimer:Disconnect() end
conexaoTimer = RunService.Heartbeat:Connect(function(dt)
if not timerAtivo then return end
tempoRestante = tempoRestante - dt
if tempoRestante > 0 then
minutesTextBox.Text = formatarTempo(tempoRestante)
else
minutesTextBox.Text = "00:00"
timerAtivo = false
startBtn.Text = "Iniciar temporizador"
startBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
if conexaoTimer then conexaoTimer:Disconnect() end
task.wait(1)
minutesTextBox.Text = ""
setEditable(true)
end
end)
end
local function pararTimer()
timerAtivo = false
if conexaoTimer then conexaoTimer:Disconnect() end
startBtn.Text = "Iniciar temporizador"
startBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
minutesTextBox.Text = valorOriginal
setEditable(true)
end
startBtn.MouseButton1Click:Connect(function()
if timerAtivo then
pararTimer()
else
iniciarTimer()
end
end)
minutesTextBox.FocusLost:Connect(function(enterPressed)
if enterPressed and not timerAtivo then
iniciarTimer()
end
end)
minutesTextBox.PlaceholderText = "Minutos ou MM:SS"
minutesTextBox.Text = ""
setEditable(true)
startBtn.Text = "Iniciar temporizador"
startBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)