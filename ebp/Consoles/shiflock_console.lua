local Players = game:GetService("Players")
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local CAMERA_OFFSET_ON = Vector3.new(1.5, 0, 0)
local CAMERA_OFFSET_OFF = Vector3.new(0, 0, 0)

local ACTION_NAME = "ToggleConsoleShiftLock"
local shiftLockOn = false

local humanoid, hrp
local rsConn

local function setRotationFollowCamera(enabled)
	if rsConn then rsConn:Disconnect() rsConn = nil end
	if not enabled then return end
	rsConn = RunService.RenderStepped:Connect(function()
		if not hrp or not hrp.Parent or not humanoid or humanoid.Health <= 0 then return end
		local camCF = camera.CFrame
		local look = Vector3.new(camCF.LookVector.X, 0, camCF.LookVector.Z)
		if look.Magnitude < 1e-3 then return end
		hrp.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + look.Unit)
	end)
end

local function applyShiftLock(on)
	shiftLockOn = on
	if humanoid then
		humanoid.AutoRotate = not on
		humanoid.CameraOffset = on and CAMERA_OFFSET_ON or CAMERA_OFFSET_OFF
	end
	setRotationFollowCamera(on)
end

local function onCharacterAdded(char)
	humanoid = char:WaitForChild("Humanoid")
	hrp = char:WaitForChild("HumanoidRootPart")
	applyShiftLock(shiftLockOn)
end

local function bindAction()
	ContextActionService:BindAction(
		ACTION_NAME,
		function(_, state)
			if state ~= Enum.UserInputState.Begin then return end
			applyShiftLock(not shiftLockOn)
		end,
		false,
		Enum.KeyCode.ButtonX
	)
end

if player.Character then onCharacterAdded(player.Character) end
player.CharacterAdded:Connect(onCharacterAdded)
bindAction()