
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- setup
local TIMEZONE_OFFSET_HOURS = 0 -- Sp
local UPDATE_INTERVAL = 1

local function pad(n)
	return tostring(n):len() == 1 and ("0" .. tostring(n)) or tostring(n)
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SPTimeGUI"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 1000
screenGui.Parent = playerGui
local timeLabel = Instance.new("TextLabel")
timeLabel.Name = "TimeOnly"
timeLabel.Size = UDim2.new(0, 120, 0, 40)
timeLabel.Position = UDim2.new(1, -140, 0, 20)  

timeLabel.AnchorPoint = Vector2.new(0, 0)
timeLabel.BackgroundTransparency = 1                -- t(h:m/s)
timeLabel.BorderSizePixel = 0
timeLabel.Text = "--:--"
timeLabel.Font = Enum.Font.GothamBold
timeLabel.TextSize = 28
timeLabel.TextScaled = false
timeLabel.TextXAlignment = Enum.TextXAlignment.Center
timeLabel.TextYAlignment = Enum.TextYAlignment.Center
timeLabel.TextColor3 = Color3.fromRGB(255,255,255)
timeLabel.Parent = screenGui
timeLabel.ZIndex = 1001

-- UTC+0
local function currentUtcTimestamp()
	local now = os.time()
	local ok, utcTable = pcall(function() return os.date("!*t", now) end)
	if ok and utcTable then
		return os.time(utcTable)
	else
		return now
	end
end

-- bgl foda q atualiza
 local function updateClock()
	local utc = currentUtcTimestamp()
	local spTimestamp = utc + (TIMEZONE_OFFSET_HOURS * 3600)
	local spTable = os.date("*t", spTimestamp)

	local hour = spTable.hour
	local min = spTable.min

	timeLabel.Text = string.format("%s:%s", pad(hour), pad(min))
end

updateClock()
local accumulated = 0
local conn
conn = RunService.Heartbeat:Connect(function(dt)
	accumulated = accumulated + dt
	if accumulated >= UPDATE_INTERVAL then
		accumulated = accumulated - UPDATE_INTERVAL
		updateClock()
	end
end)

player.AncestryChanged:Connect(function()
	if not player:IsDescendantOf(game) and conn then
		conn:Disconnect()
		conn = nil
	end
end)