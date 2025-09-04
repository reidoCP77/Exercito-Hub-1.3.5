local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local gamepassId = 1436534092
local part = script.Parent -- Assume que o LocalScript está dentro da peça "name aq"

local player = Players.LocalPlayer

-- Função para atualizar a propriedade CanCollide da peça
local function updateCanCollide()
    local hasPass = false
    -- Verifica se o jogador possui a gamepass VIP
    local success, ownsPass = pcall(function()
        return MarketplaceService:User OwnsGamePassAsync(player.UserId, gamepassId)
    end)
    if success and ownsPass then
        hasPass = true
    end

    part.CanCollide = not hasPass
    part.Transparency = 1 -- Sempre transparente
end

-- Atualiza ao iniciar
updateCanCollide()

-- Opcional: Atualizar se o jogador comprar a gamepass durante o jogo
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(purchasedPlayer, purchasedPassId, wasPurchased)
    if purchasedPlayer == player and purchasedPassId == gamepassId and wasPurchased then
        updateCanCollide()
    end
end)
