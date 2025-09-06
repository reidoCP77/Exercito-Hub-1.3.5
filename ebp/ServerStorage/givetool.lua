local idgroup = 387273307
local Algema = game.ServerStorage.Algema
local Fal = game.ServerStorage.FAL
local M4A1 = game.ServerStorage.M4A1
local Prancheta = game.ServerStorage.Prancheta
local C = game.ServerStorage["[C] Continencia"]
local D = game.ServerStorage["[D] Descançar"]
local R = game.ServerStorage["[R] Render-se"]
local Bastao = game.ServerStorage.Bastao

local Divisoes = {
    "[BAC] Batalhão de Ações de Comandos",
    "[BFE] Batalhão de Forças Especiais",
    "[CIE] Centro de Inteligência do Exército",
    "[BPE] Batalhão da Polícia do Exército"
}

game.Players.PlayerAdded:Connect(function(Plr)
    local function giveItems()
        -- Itens baseados no rank
        if Plr:GetRankInGroup(idgroup) >= 8 then
            if not Plr.Backpack:FindFirstChild("Algema") then
                Algema:Clone().Parent = Plr.Backpack
            end
            if not Plr.Backpack:FindFirstChild("FAL") then
                Fal:Clone().Parent = Plr.Backpack
            end
            if not Plr.Backpack:FindFirstChild("M4A1") then
                M4A1:Clone().Parent = Plr.Backpack
            end
            if not Plr.Backpack:FindFirstChild("Prancheta") then
                Prancheta:Clone().Parent = Plr.Backpack
            end
        elseif Plr:GetRankInGroup(idgroup) >= 4 then
            if not Plr.Backpack:FindFirstChild("FAL") then
                Fal:Clone().Parent = Plr.Backpack
            end
            if not Plr.Backpack:FindFirstChild("M4A1") then
                M4A1:Clone().Parent = Plr.Backpack
            end
            if not Plr.Backpack:FindFirstChild("Prancheta") then
                Prancheta:Clone().Parent = Plr.Backpack
            end
        elseif Plr:GetRankInGroup(idgroup) >= 3 then
            if not Plr.Backpack:FindFirstChild("FAL") then
                Fal:Clone().Parent = Plr.Backpack
            end
        end

        -- Itens para todos os jogadores
        if not Plr.Backpack:FindFirstChild("[C] Continencia") then
            C:Clone().Parent = Plr.Backpack
        end
        if not Plr.Backpack:FindFirstChild("[D] Descançar") then
            D:Clone().Parent = Plr.Backpack
        end
        if not Plr.Backpack:FindFirstChild("[R] Render-se") then
            R:Clone().Parent = Plr.Backpack
        end

        -- Dar Bastão se o jogador estiver em alguma das divisões
        for _, div in ipairs(Divisoes) do
            if Plr.Team and Plr.Team.Name == div then
                if not Plr.Backpack:FindFirstChild("Bastão") then
                    Bastao:Clone().Parent = Plr.Backpack
                end
                break
            end
        end
    end

    Plr.CharacterAdded:Connect(giveItems)
    giveItems()
end)