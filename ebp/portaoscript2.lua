local TweenService = game:getService('TweenService')
local player = game.Players.LocalPlayer 
local team = player.Team

local soundId = "rbxassetid:/107152139239024" 
local sound = Instance.new("som do portão")
sound.SoundId = soundId
sound.Volume = 1 -- D
sound.Parent = game.Workspace.portao
local btn = script.Parent
local part = game:FindFirstChild('portao')
local teamName = playerTeam.Name

btn.Text = "Abrir Portão"
part.Color = Color3.fromRGB(0, 255, 0)

local teams = {
    "[BAC] Batalhão de Ações de Comandos",
    "[BFE] Batalhão de Forças Especiais", 
    "[BPE] Batalhão da Polícia do Exército",
    "[CIE] Centro de Inteligência do Exército", 
    "[OF] Oficiais",
    "[GD] Graduados"
}

local tweeninfo2 =  TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
local subida = part.Position + Vector3.new(0, 5, 0)
local tween2 = TweenService:Create(part, tweeninfo2, {Position = subida})

local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false)
local descida = part.Position - Vector3.new(0, 5, 0)
local tween = TweenService:Create(part, tweenInfo, {Position = descida})

if part then
   btn.mouseButton1Click:Connect(function()
        for _, team in ipairs(teams) do
            if team == teamName then
              btn.Color = Color3.new(1, 0, 0)
              tween:Play()
              sound:Play()
              task.wait(8)
              btn.Color = Color3.new(0, 1, 0)
              tween2:Play()
              sound:Play()
            end
        end
    end)
end
