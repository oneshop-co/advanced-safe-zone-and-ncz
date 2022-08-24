local PlayerData = {}
ESX       = nil 

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
	PlayerData.job = job
end)

-- if PlayerData.job ~= nil and PlayerData.job.name == Config.JobName then
-- 	DrawMarker(v.type, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.501, 1.5001, 0.5001, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
	
-- 	if dist <= 1.5 then
-- 	  ESX.ShowHelpNotification(_U('marker_do_txt'))

-- 	  if IsControlJustPressed(0, 38) then
-- 		TriggerServerEvent("esx_illegals:checkInventory")
-- 	  end
-- 	end
--   end

-- local nczzone = {
-- 	["Taxi"] = {x=898.58,y=-170.95,z=80.69,radius = 25.0},
-- }

local uwuMUIEeulamfacut = {laba = false,x=nil,y=nil,z=nil,radius=nil}

function coliziune(entitate)
	for _, lr in ipairs(GetActivePlayers()) do
		if(Vdist(GetEntityCoords(GetPlayerPed(lr)),uwuMUIEeulamfacut.x,uwuMUIEeulamfacut.y,uwuMUIEeulamfacut.z) <= uwuMUIEeulamfacut.radius) then
			SetEntityNoCollisionEntity(GetPlayerPed(lr),entitate,true)
		end
	end
end

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
        Citizen.Wait(0)
    end
	while true do
		Citizen.Wait(0)
		local jucatorimuie = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(jucatorimuie, true))
		if PlayerData.job ~= nil and PlayerData.job.name == "nojob" or PlayerData.job.name == "mechanic" or PlayerData.job.name == "taxi" or PlayerData.job.name == "ambulance" or PlayerData.job.name == "casino" or PlayerData.job.name == "fisherman" or PlayerData.job.name == "foodtruck" or PlayerData.job.name == "fueler" or PlayerData.job.name == "garbage" or PlayerData.job.name == "gopostal" or PlayerData.job.name == "lumberjack" or PlayerData.job.name == "moneytransfer" or PlayerData.job.name == "offambulance" or PlayerData.job.name == "offfbim" or PlayerData.job.name == "offmechanic" or PlayerData.job.name == "offtaxi" or PlayerData.job.name == "postal" or PlayerData.job.name == "reporter" or PlayerData.job.name == "slaughterer" or PlayerData.job.name == "tailor" or PlayerData.job.name == "vigne" then
			if(uwuMUIEeulamfacut.laba == false) then
				for i,v in pairs(Config.ncz) do
					if(Vdist(x,y,z,v.x,v.y,v.z) <= v.radius) then
						uwuMUIEeulamfacut.laba = true
						uwuMUIEeulamfacut.x,uwuMUIEeulamfacut.y,uwuMUIEeulamfacut.z,uwuMUIEeulamfacut.radius = v.x,v.y,v.z,v.radius
						SetCurrentPedWeapon(jucatorimuie,GetHashKey("WEAPON_UNARMED"),true)
						ClearPlayerWantedLevel(PlayerId())
					end
				end
			end
			if uwuMUIEeulamfacut.laba then
				NetworkSetFriendlyFireOption(true)
				DisableControlAction(2, 37, true)
				DisablePlayerFiring(jucatorimuie,true)
				DisableControlAction(0, 106, true)
				Draw3DText(x,y,z, "~c~[~r~NCZ~c~]", 0.8)

				coliziune(player)
				if(Vdist(x,y,z,uwuMUIEeulamfacut.x,uwuMUIEeulamfacut.y,uwuMUIEeulamfacut.z) > 1.0) then
					uwuMUIEeulamfacut.laba = false
					uwuMUIEeulamfacut.x,uwuMUIEeulamfacut.y,uwuMUIEeulamfacut.z,uwuMUIEeulamfacut.radius = nil,nil,nil,nil
					NetworkSetFriendlyFireOption(true)
					DisableControlAction(2, 37, false)
					DisablePlayerFiring(jucatorimuie,false)
					DisableControlAction(0, 106, false)
				end
			end
		end
	end
end)

function Draw3DText(x,y,z, text,scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString("~a~"..text)
        DrawText(0.4,0.5)
    end
end