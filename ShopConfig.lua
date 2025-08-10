-- ShopConfig (ModuleScript in ReplicatedStorage) - COMPLETE WITH ALL NEW FEATURES
return {
	-- ═══════════════════════════════════════════════════════════════
	-- DEBUG SETTINGS
	-- ═══════════════════════════════════════════════════════════════
	Debug = {
		Enabled = false,
		ShowClientDebug = true,
		ShowServerDebug = true,
		ShowLeaderstatsDebug = false,
		ShowBoostDebug = false,
		ShowShopDebug = true,
		ShowZoneDebug = false,
		ShowRebirthDebug = false,
		ShowNotificationDebug = false
	},

	-- ═══════════════════════════════════════════════════════════════
	-- SOUND CONFIGURATION
	-- ═══════════════════════════════════════════════════════════════
	Sounds = {
		-- UI Sounds
		ButtonHover = "rbxassetid://10066931761",
		ButtonClick = "rbxassetid://7593297942",
		TabSwitch = "rbxassetid://12222183",

		-- Purchase Sounds
		PurchaseSuccess = "rbxassetid://3454671965",
		PurchaseFail = "rbxassetid://2390695935",
		AlreadyOwned = "rbxassetid://9066167010",

		-- Shop Sounds
		ShopOpen = "rbxassetid://2084290015",
		ShopClose = "rbxassetid://8904888220",

		-- Poop Sounds
		PoopSpawn = "rbxassetid://98112849852832",

		-- Notification Sounds
		GiftReceived = "rbxassetid://1839997929",
		NotificationShow = "rbxassetid://133071738727579",

		-- Rebirth Sounds
		RebirthSuccess = "rbxassetid://3454671965",
		RebirthFail = "rbxassetid://2390695935",

		-- Zone Sounds
		ZoneEnter = "rbxassetid://12222253",
		ZoneExit = "rbxassetid://12222152",
		ZoneRestricted = "rbxassetid://9066167010",

		-- Luck Sounds
		LuckTrigger = "rbxassetid://3454671965",
		MegaLuckTrigger = "rbxassetid://1839997929",

		-- Auto Poop Sound
		AutoPoopTick = "rbxassetid://98112849852832",

		-- Volume Settings
		Volumes = {
			UI = 0.5,
			Purchase = 0.7,
			Shop = 0.7,
			Poop = 0.8,
			Notification = 0.6,
			Rebirth = 0.8,
			Zone = 0.5,
			Luck = 0.6,
			AutoPoop = 0.3
		}
	},

	-- ═══════════════════════════════════════════════════════════════
	-- ZONES CONFIGURATION (ENHANCED WITH VIP ZONE)
	-- ═══════════════════════════════════════════════════════════════
	Zones = {
		["Zone1"] = {
			Name = "Poop Sky Island",
			RequiredPoopsPooped = 200,  
			Multiplier = 2,
			UnlockMessage = "🎉 You've unlocked the Poop Sky Island! 2x earnings!",
			Description = "A floating island made of poop with 2x earnings!"
		},
		["Zone2"] = {
			Name = "Toilet Sky Island", 
			RequiredPoopsPooped = 600,   
			Multiplier = 3,
			UnlockMessage = "🎉 You've unlocked the Toilet Sky Island! 3x earnings!",
			Description = "A magical toilet island with 3x earnings!"
		},
		["Zone3"] = {
			Name = "Great Poop Mountain",
			RequiredPoopsPooped = 1500, 
			Multiplier = 5,
			UnlockMessage = "🎉 You've unlocked the Great Poop Mountain! 5x earnings!",
			Description = "The legendary mountain of poop with 5x earnings!"
		},
		["Zone4"] = {
			Name = "VIP Zone",
			RequiredPoopsPooped = 0,
			Multiplier = 8,
			UnlockMessage = "🌟 Welcome to the exclusive VIP Zone! 8x earnings!",
			Description = "Exclusive VIP zone with 8x earnings!",
			IsVIP = true,
			RequiredGamepass = "VIPZone",
			UIColor = Color3.fromRGB(255, 215, 0),
			ChatEmoji = "👑"
		}
	},

	-- ═══════════════════════════════════════════════════════════════
	-- PORTAL SYSTEM CONFIGURATION
	-- ═══════════════════════════════════════════════════════════════
	Portals = {
		Effects = {
			TeleportSoundId = "rbxassetid://12222183",
			RequirementNotMetSound = "rbxassetid://9066167010",
			Volume = 0.6,
			CooldownTime = 2,
			FadeDuration = 0.3
		},

		PortalConfigs = {
			["Zone1Portal"] = {
				DestinationZone = "Zone1",
				RequirementType = "PoopsPooped",
				RequirementAmount = 350,
				RequirementMessage = "You need 350 poops pooped to enter Zone 1!",
				Enabled = true
			},

			["Zone2Portal"] = {
				DestinationZone = "Zone2",
				RequirementType = "PoopsPooped",
				RequirementAmount = 750,
				RequirementMessage = "You need 750 poops pooped to enter Zone 2!",
				Enabled = true
			},

			["Zone3Portal"] = {
				DestinationZone = "Zone3",
				RequirementType = "PoopsPooped",
				RequirementAmount = 1500,
				RequirementMessage = "You need 1500 poops pooped to enter Zone 3!",
				Enabled = true
			},

			["VIPPortal"] = {
				DestinationZone = "Zone4",
				RequirementType = "None", -- VIP zone uses gamepass requirement
				RequirementAmount = 0,
				RequirementMessage = "VIP Zone Access Required!",
				Enabled = true
			},

			["MainMapPortal"] = {
				DestinationZone = "MainMap",
				RequirementType = "None",
				RequirementAmount = 0,
				RequirementMessage = "",
				Enabled = true
			},

			-- ZONE ARRIVAL PORTALS (Return to MainMap)
			["Zone1PortalArrive"] = {
				DestinationZone = "MainMap",
				RequirementType = "None",
				RequirementAmount = 0,
				RequirementMessage = "",
				Enabled = true
			},

			["Zone2PortalArrive"] = {
				DestinationZone = "MainMap",
				RequirementType = "None",
				RequirementAmount = 0,
				RequirementMessage = "",
				Enabled = true
			},

			["Zone3PortalArrive"] = {
				DestinationZone = "MainMap",
				RequirementType = "None",
				RequirementAmount = 0,
				RequirementMessage = "",
				Enabled = true
			},

			["Zone4PortalArrive"] = {
				DestinationZone = "MainMap",
				RequirementType = "None",
				RequirementAmount = 0,
				RequirementMessage = "",
				Enabled = true
			}
		}
	},

	-- OTHER SECTIONS WOULD CONTINUE HERE...
	-- (I'm only showing the essential parts for the fixes)

	-- Default configurations
	DefaultPoop = "Poop",
	StartingPooBucks = 0,
	StartingPoopsPooped = 0,
	StartingRebirths = 0
}