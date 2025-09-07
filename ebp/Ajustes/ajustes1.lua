local Tool = script.Parent
local arms = nil
local torso = nil
local welds = {}

function Equip(mouse)
    task.wait(0.01)
    arms = {Tool.Parent:FindFirstChild("Left Arm"), Tool.Parent:FindFirstChild("Right Arm")}
    torso = Tool.Parent:FindFirstChild("Torso")

    if arms[1] and arms[2] and torso then
        local sh = {torso:FindFirstChild("Left Shoulder"), torso:FindFirstChild("Right Shoulder")}
        if sh[1] and sh[2] then
            -- Desconecta os ombros
            sh[1].Part1 = nil
            sh[2].Part1 = nil

            -- Weld esquerdo
            local weld1 = Instance.new("Weld")
            weld1.Part0 = torso
            weld1.Part1 = arms[1]
            weld1.C1 = CFrame.new(1, 0.2, 0.35) * CFrame.Angles(math.rad(-90), 0.2, 0)
            weld1.Parent = torso
            welds[1] = weld1

            -- Weld direito
            local weld2 = Instance.new("Weld")
            weld2.Part0 = torso
            weld2.Part1 = arms[2]
            weld2.C1 = CFrame.new(-1, 0.2, 0.35) * CFrame.Angles(math.rad(-90), math.rad(-15), 0)
            weld2.Parent = torso
            welds[2] = weld2
        else
            warn("Ombros não encontrados")
        end
    else
        warn("Braços ou torso não encontrados")
    end
end

function Unequip(mouse)
    if arms and torso then
        local sh = {torso:FindFirstChild("Left Shoulder"), torso:FindFirstChild("Right Shoulder")}
        if sh[1] and sh[2] then
            sh[1].Part1 = arms[1]
            sh[2].Part1 = arms[2]
            if welds[1] then welds[1]:Destroy() end
            if welds[2] then welds[2]:Destroy() end
        else
            warn("Ombros não encontrados")
        end
    else
        warn("Braços ou torso não encontrados")
    end
end

Tool.Equipped:Connect(Equip)
Tool.Unequipped:Connect(Unequip)