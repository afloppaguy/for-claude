-- Function to check if player meets portal requirements
local function canUsePortal(player, portalConfig)
	if portalConfig.RequirementType == "None" then
		-- Special check for VIP zone
		if portalConfig.DestinationZone == "Zone4" then
			-- Check if player has VIP gamepass
			if _G.ZoneSystem and _G.ZoneSystem.HasRequiredGamepass then
				if not _G.ZoneSystem.HasRequiredGamepass(player, "VIPZone") then
					return false, "VIP Zone Access Required! Purchase the VIP gamepass to enter."
				end
			else
				-- Fallback check
				if _G.ShopPlayerData and _G.ShopPlayerData[player] and _G.ShopPlayerData[player].OwnedGamepasses then
					if not table.find(_G.ShopPlayerData[player].OwnedGamepasses, "VIPZone") then
						return false, "VIP Zone Access Required! Purchase the VIP gamepass to enter."
					end
				else
					return false, "VIP Zone Access Required! Purchase the VIP gamepass to enter."
				end
			end
		end
		return true, "Access granted"
	end

	local playerValue = getPlayerRequirementValue(player, portalConfig.RequirementType)
	local required = portalConfig.RequirementAmount

	if playerValue >= required then
		return true, "Access granted"
	else
		return false, portalConfig.RequirementMessage or "Requirements not met"
	end
end