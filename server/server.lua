local Core = exports[Config.frame]:GetCoreObject()
local Player = Core.Functions.GetPlayer(source)
local PlayerData = {}


-- [ Code ] --

RegisterNetEvent("server:set-walkstyle", function(Style)
    local src = source
	local Player = Core.Functions.GetPlayer(src)
	PlayerData = Player
	local WalkStyle = Player.PlayerData.metadata["walkingstyle"]
	if WalkStyle ~= Style then
		Player.Functions.SetMetaData('walkingstyle', Style)
	end
end)