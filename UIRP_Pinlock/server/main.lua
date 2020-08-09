ESX				= nil
local DoorInfo	= {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('UIRP_Pinlock:updateState')
AddEventHandler('UIRP_Pinlock:updateState', function(doorID, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(doorID) ~= 'number' then
		print(('UIRP_Pinlock: %s didn\'t send a number!'):format(xPlayer.identifier))
		return
	end

	-- make each door a table, and clean it when toggled
	DoorInfo[doorID] = {}

	-- assign information
	DoorInfo[doorID].state = state
	DoorInfo[doorID].doorID = doorID

	TriggerClientEvent('UIRP_Pinlock:setState', -1, doorID, state)
end)

ESX.RegisterServerCallback('UIRP_Pinlock:getDoorInfo', function(source, cb)
	cb(DoorInfo, #DoorInfo)
end)