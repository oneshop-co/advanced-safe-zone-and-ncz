ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local zone = nil
local blip = nil

Citizen.CreateThread(function()
	Citizen.Wait(1)
	for _,new_zone in pairs(Config.safezone) do
		zone = AddBlipForRadius(new_zone.coords.x, new_zone.coords.y, new_zone.coords.z, new_zone.zone.radius)
		SetBlipSprite(zone, 9)
		SetBlipAlpha(zone, 100)
		SetBlipColour(zone, new_zone.zone.color)
		
		if (new_zone.blip.draw == true) then
			blip = AddBlipForCoord(new_zone.coords.x, new_zone.coords.y, new_zone.coords.z)
			SetBlipSprite(blip, new_zone.blip.id)
			SetBlipColour(blip, new_zone.blip.color)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(new_zone.blip.text)
			EndTextCommandSetBlipName(blip)
		end
		
	end
end)