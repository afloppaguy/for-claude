-- ZoneUIClient (LocalScript in StarterPlayerScripts)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Get ShopConfig
local ShopConfig = require(ReplicatedStorage:WaitForChild("ShopConfig"))

-- Debug system
local function debugPrint(message)
	if ShopConfig.Debug.Enabled and ShopConfig.Debug.ShowClientDebug then
		print("[ZONE UI]: " .. message)
	end
end

-- Wait for RemoteEvents
local ZoneEnteredEvent = ReplicatedStorage:WaitForChild("ZoneEnteredEvent", 10)
local ZoneExitedEvent = ReplicatedStorage:WaitForChild("ZoneExitedEvent", 10)
local VIPZoneAccessEvent = ReplicatedStorage:WaitForChild("VIPZoneAccessEvent", 10)

if not ZoneEnteredEvent or not ZoneExitedEvent then
	warn("Zone events not found!")
	return
end

-- Create Zone Multiplier GUI
local function createZoneMultiplierGUI()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "ZoneMultiplierGui"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Parent = playerGui

	local frame = Instance.new("Frame")
	frame.Name = "MultiplierFrame"
	frame.Size = UDim2.new(0, 250, 0, 60)
	frame.Position = UDim2.new(0.5, -125, 0, 20) -- Top center
	frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	frame.BackgroundTransparency = 0.3
	frame.BorderSizePixel = 0
	frame.Visible = false
	frame.Parent = screenGui

	-- Add corner rounding
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = frame

	-- Add stroke
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Color = Color3.fromRGB(255, 255, 255)
	stroke.Transparency = 0.7
	stroke.Parent = frame

	-- Zone name label
	local zoneLabel = Instance.new("TextLabel")
	zoneLabel.Name = "ZoneLabel"
	zoneLabel.Size = UDim2.new(1, 0, 0.6, 0)
	zoneLabel.Position = UDim2.new(0, 0, 0, 0)
	zoneLabel.BackgroundTransparency = 1
	zoneLabel.Text = "Zone Name"
	zoneLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	zoneLabel.TextSize = 16
	zoneLabel.Font = Enum.Font.GothamBold
	zoneLabel.TextXAlignment = Enum.TextXAlignment.Center
	zoneLabel.Parent = frame

	-- Multiplier label
	local multiplierLabel = Instance.new("TextLabel")
	multiplierLabel.Name = "MultiplierLabel"
	multiplierLabel.Size = UDim2.new(1, 0, 0.4, 0)
	multiplierLabel.Position = UDim2.new(0, 0, 0.6, 0)
	multiplierLabel.BackgroundTransparency = 1
	multiplierLabel.Text = "2x Earnings"
	multiplierLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
	multiplierLabel.TextSize = 14
	multiplierLabel.Font = Enum.Font.Gotham
	multiplierLabel.TextXAlignment = Enum.TextXAlignment.Center
	multiplierLabel.Parent = frame

	return frame, zoneLabel, multiplierLabel
end

local multiplierFrame, zoneLabel, multiplierLabel = createZoneMultiplierGUI()

-- Animation functions
local function showMultiplierUI(zoneName, multiplier, isVIP)
	-- Update text
	zoneLabel.Text = zoneName or "Unknown Zone"
	multiplierLabel.Text = multiplier .. "x Earnings"
	
	-- Set VIP colors if applicable
	if isVIP then
		zoneLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- Gold
		multiplierLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- Gold
		multiplierFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 0) -- Dark gold background
	else
		zoneLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- White
		multiplierLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Green
		multiplierFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
	end
	
	-- Show with animation
	multiplierFrame.Visible = true
	multiplierFrame.Size = UDim2.new(0, 0, 0, 0)
	multiplierFrame.Position = UDim2.new(0.5, 0, 0, 20)
	
	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local tween = TweenService:Create(multiplierFrame, tweenInfo, {
		Size = UDim2.new(0, 250, 0, 60),
		Position = UDim2.new(0.5, -125, 0, 20)
	})
	tween:Play()
	
	debugPrint("Showing zone multiplier UI: " .. zoneName .. " (" .. multiplier .. "x)")
end

local function hideMultiplierUI()
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
	local tween = TweenService:Create(multiplierFrame, tweenInfo, {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0.5, 0, 0, 20)
	})
	tween:Play()
	
	tween.Completed:Connect(function()
		multiplierFrame.Visible = false
	end)
	
	debugPrint("Hiding zone multiplier UI")
end

-- Handle zone events
ZoneEnteredEvent.OnClientEvent:Connect(function(zoneKey, multiplier, success)
	debugPrint("Zone entered event: " .. tostring(zoneKey) .. ", success: " .. tostring(success))
	
	if success and zoneKey and multiplier then
		local zoneConfig = ShopConfig.Zones[zoneKey]
		if zoneConfig then
			showMultiplierUI(zoneConfig.Name, multiplier, zoneConfig.IsVIP)
			
			-- Play zone enter sound
			local enterSound = Instance.new("Sound")
			enterSound.SoundId = ShopConfig.Sounds.ZoneEnter
			enterSound.Volume = ShopConfig.Sounds.Volumes.Zone
			enterSound.Parent = workspace
			enterSound:Play()
			enterSound.Ended:Connect(function()
				enterSound:Destroy()
			end)
		end
	else
		-- Show error message if failed
		if not success then
			debugPrint("Zone entry failed: " .. tostring(multiplier)) -- multiplier contains error message when failed
		end
	end
end)

ZoneExitedEvent.OnClientEvent:Connect(function()
	debugPrint("Zone exited event")
	hideMultiplierUI()
	
	-- Play zone exit sound
	local exitSound = Instance.new("Sound")
	exitSound.SoundId = ShopConfig.Sounds.ZoneExit
	exitSound.Volume = ShopConfig.Sounds.Volumes.Zone
	exitSound.Parent = workspace
	exitSound:Play()
	exitSound.Ended:Connect(function()
		exitSound:Destroy()
	end)
end)

-- Handle VIP zone events
if VIPZoneAccessEvent then
	VIPZoneAccessEvent.OnClientEvent:Connect(function(eventType, data)
		debugPrint("VIP Zone event: " .. eventType)
		
		if eventType == "entered" and data then
			-- Show special VIP notification
			debugPrint("VIP Zone entered: " .. (data.zoneName or "VIP Zone"))
			
			-- The regular zone entered event will handle the multiplier UI
			-- This could be used for additional VIP-specific effects
			
		elseif eventType == "exited" and data then
			debugPrint("VIP Zone exited: " .. (data.zoneName or "VIP Zone"))
			
			-- The regular zone exited event will handle hiding the UI
		end
	end)
end

-- Auto-hide multiplier UI after 10 seconds (optional)
spawn(function()
	while true do
		wait(10)
		if multiplierFrame.Visible then
			-- Check if player is still in a zone by making a remote call
			local success, zoneData = pcall(function()
				local GetPlayerZoneRemote = ReplicatedStorage:FindFirstChild("GetPlayerZone")
				if GetPlayerZoneRemote then
					return GetPlayerZoneRemote:InvokeServer()
				end
				return nil
			end)
			
			-- If player is no longer in a zone, hide the UI
			if not success or not zoneData then
				hideMultiplierUI()
			end
		end
	end
end)

debugPrint("ZoneUIClient initialized successfully!")