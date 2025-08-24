local button = script.Parent
local peca = workspace:WaitForChild("coloque o nome da peça (portão)")

local TIMES_PERMITIDOS = {
    "[G] Graduados",
    "[BAC] Batalhão de Ações de Comandos", 
    "[CIE] Centro de Inteligência do Exército",
    "[BFE] Batalhão de Forças Especiais",
    "[BPE] Batalhão da Polícia do Exército"
}

local DISTANCIA_DESCIDA = 10
local TEMPO_ANIMACAO = 1.0
local TEMPO_FECHAR = 5
local TEMPO_MENSAGEM = 3

local isAberto = false
local isAnimando = false
local posicaoOriginal

local function suavizar(t)
    return t * t * (3 - 2 * t)
end

local function animarPeca(posicaoAlvo, duracao)
    if isAnimando then return end
    isAnimando = true
    local posicaoInicial = peca.Position
    local tempoInicio = tick()
    while tick() - tempoInicio < duracao do
        local progresso = (tick() - tempoInicio) / duracao
        local progressoSuavizado = suavizar(progresso)
        peca.Position = posicaoInicial:Lerp(posicaoAlvo, progressoSuavizado)
        task.wait()
    end
    peca.Position = posicaoAlvo
    isAnimando = false
end

local function jogadorTemPermissao(jogador)
    if not jogador or not jogador.Team then
        return false
    end
    local nomeTimeJogador = jogador.Team.Name
    for _, nomeTimePermitido in ipairs(TIMES_PERMITIDOS) do
        if nomeTimeJogador == nomeTimePermitido then
            return true
        end
    end
    return false
end

local function abrirPeca()
    if isAberto or isAnimando then return end
    isAberto = true
    button.BrickColor = BrickColor.new("Bright red")
    local posicaoAlvo = posicaoOriginal - Vector3.new(0, DISTANCIA_DESCIDA, 0)
    animarPeca(posicaoAlvo, TEMPO_ANIMACAO)
    task.delay(TEMPO_FECHAR, function()
        fecharPeca()
    end)
end

local function fecharPeca()
    if not isAberto or isAnimando then return end
    animarPeca(posicaoOriginal, TEMPO_ANIMACAO)
    isAberto = false
    button.BrickColor = BrickColor.new("Lime green")
end

local function mostrarMensagem(jogador, mensagem)
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(6, 0, 2, 0)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.Adornee = button
    billboard.AlwaysOnTop = true

    local texto = Instance.new("TextLabel")
    texto.Size = UDim2.new(1, 0, 1, 0)
    texto.Text = mensagem
    texto.TextColor3 = Color3.new(1, 0, 0)
    texto.BackgroundTransparency = 1
    texto.TextScaled = true
    texto.Font = Enum.Font.SourceSansBold
    texto.Parent = billboard

    local playerGui = jogador:FindFirstChildOfClass("PlayerGui")
    if playerGui then
        billboard.Parent = playerGui
    else
        billboard.Parent = workspace
    end

    task.delay(TEMPO_MENSAGEM, function()
        if billboard then
            billboard:Destroy()
        end
    end)
end

local function configurarInicial()
    posicaoOriginal = peca.Position
    button.BrickColor = BrickColor.new("Lime green")
    button.Material = Enum.Material.Neon
    button.CanCollide = true
    if not button:FindFirstChild("ClickDetector") then
        local clickDetector = Instance.new("ClickDetector")
        clickDetector.Parent = button
    end
end

local function conectarEventos()
    local clickDetector = button:FindFirstChild("ClickDetector")
    clickDetector.MouseClick:Connect(function(jogador)
        if isAnimando then return end
        if jogadorTemPermissao(jogador) then
            abrirPeca()
        else
            mostrarMensagem(jogador, "Você não tem permissão para abrir!")
        end
    end)
end

configurarInicial()
conectarEventos()

local function criarTimesAutomaticamente()
    local teamsService = game:GetService("Teams")
    for _, nomeTime in ipairs(TIMES_PERMITIDOS) do
        if not teamsService:FindFirstChild(nomeTime) then
            local novoTime = Instance.new("Team")
            novoTime.Name = nomeTime
            novoTime.TeamColor = BrickColor.random()
            novoTime.AutoAssignable = false
            novoTime.Parent = teamsService
        end
    end
end

-- criarTimesAutomaticamente()
