local motor = true
local neons = true
local fronleftdoors = false
local frontrightdoors = false
local backleftdoors = false
local backrightdoors = false
local trunk = false
local hood = false
local leftfrontwindows = true
local rightfrontwindows = true
local leftbackwindow = true
local rightbackwindow = true
local interiorlights = false
local frontlights = true
RegisterCommand("carmenu", function (src, args, raw)
	local player = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(player,false)	
	if (IsPedSittingInAnyVehicle(player)) then
    WarMenu.MenuOpen('carControl')
	else
		exports['b1g_notify']:Notify('false', _U('not_inveh'))
	end
end, false)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
		if IsControlJustReleased(1, 344) then
			local player = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsIn(player,false)	
				if (IsPedSittingInAnyVehicle(player)) then
    					WarMenu.OpenMenu('carControl')
				else
				exports['b1g_notify']:Notify('false', _U('not_inveh'))
				end
		end
		while (motor == false) do
			SetVehicleUndriveable(vehicle,true)
			Citizen.Wait(0)
		end
	end
end)

Citizen.CreateThread(function()
	WarMenu.CreateMenu('carControl', 'Car Control')
	WarMenu.CreateSubMenu('open_close', 'carControl', 'Open/Close')
	WarMenu.CreateSubMenu('windows', 'carControl', 'Windows')
	WarMenu.CreateSubMenu('lights', 'carControl', 'Lights')
	local player = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(player,false)
	while true do
		Citizen.Wait(0)
		if WarMenu.IsMenuOpened('carControl') then
			if WarMenu.Button('Engine') then
				if motor then
					motor = false
					SetVehicleEngineOn(vehicle, false, false, false)
				elseif not motor then
					motor = true
					SetVehicleEngineOn(vehicle, true, false, false)
				end
				WarMenu.Display()
			elseif WarMenu.MenuButton('Open/Close', 'open_close') then
			elseif WarMenu.MenuButton('Windows', 'windows') then
			elseif WarMenu.Button('Neons') then
					if neons then
						neons = false
						DisableVehicleNeonLights(vehicle, false, false, false)
					elseif not neons then
						neons = true
						DisableVehicleNeonLights(vehicle, true, false, false)
					end	
			elseif WarMenu.MenuButton('Lights', 'lights') then
			end
			WarMenu.Display()
		elseif WarMenu.IsMenuOpened('open_close') then
			if WarMenu.Button('Front Left Door') then
				if not fronleftdoors then
					fronleftdoors = true
					SetVehicleDoorOpen(vehicle, 0, false)
				elseif fronleftdoors then
					fronleftdoors = false
					SetVehicleDoorShut(vehicle, 0, false)
				end
			elseif WarMenu.Button('Front Right Door') then
				if not frontrightdoors then
					frontrightdoors = true
					SetVehicleDoorOpen(vehicle, 1, false)
				elseif frontrightdoors then
					frontrightdoors = false
					SetVehicleDoorShut(vehicle, 1, false)
				end
			elseif WarMenu.Button('Back Left Door') then
				if not backleftdoors then
					backleftdoors = true
					SetVehicleDoorOpen(vehicle, 2, false)
				elseif backleftdoors then
					backleftdoors = false
					SetVehicleDoorShut(vehicle, 2, false)
				end
			elseif WarMenu.Button('Back Right Door') then
				if not backrightdoors then
					backrightdoors = true
					SetVehicleDoorOpen(vehicle, 3, false)
				elseif backrightdoors then
					backrightdoors = false
					SetVehicleDoorShut(vehicle, 3, false)
				end
			elseif WarMenu.Button('Open All Doors') then
				fronleftdoors = true
				frontrightdoors = true
				backleftdoors = true
				backrightdoors = true
				trunk = true
				hood = true
				SetVehicleDoorOpen(vehicle, 0, false)
				SetVehicleDoorOpen(vehicle, 1, false)
				SetVehicleDoorOpen(vehicle, 2, false)
				SetVehicleDoorOpen(vehicle, 3, false)
				SetVehicleDoorOpen(vehicle, 4, false)
				SetVehicleDoorOpen(vehicle, 5, false)
			elseif WarMenu.Button('Close All Doors') then
				fronleftdoors = false
				frontrightdoors = false
				backleftdoors = false
				backrightdoors = false
				trunk = false
				hood = false
				SetVehicleDoorsShut(vehicle)
			elseif WarMenu.Button('Trunk') then
				if not trunk then
					trunk = true
					SetVehicleDoorOpen(vehicle, 5, false)
				elseif trunk then
					trunk = false
					SetVehicleDoorShut(vehicle, 5, false)
				end
			elseif WarMenu.Button('Hood') then
				if not hood then
					hood = true
					SetVehicleDoorOpen(vehicle, 4, false)
				elseif hood then
					hood = false
					SetVehicleDoorShut(vehicle, 4, false)
				end
			end
			WarMenu.Display()
		elseif WarMenu.IsMenuOpened('windows') then
			if WarMenu.Button('Left Front Window') then
				if not leftfrontwindows then
					leftfrontwindows = true
					RollUpWindow(vehicle, 0, false)
				elseif leftfrontwindows then
					leftfrontwindows = false
					RollDownWindow(vehicle, 0, false)
				end
			elseif WarMenu.Button('Right Front Window') then
				if not rightfrontwindows then
					rightfrontwindows = true
					RollUpWindow(vehicle, 1, false)
				elseif rightfrontwindows then
					rightfrontwindows = false
					RollDownWindow(vehicle, 1, false)
				end
			elseif WarMenu.Button('Left Back Window') then
				if not leftbackwindow then
					leftbackwindow = true
					RollUpWindow(vehicle, 2, false)
				elseif leftbackwindow then
					leftbackwindow = false
					RollDownWindow(vehicle, 2, false)
				end
			elseif WarMenu.Button('Right Back Window') then
				if not rightbackwindow then
					rightbackwindow = true
					RollUpWindow(vehicle, 3, false)
				elseif rightbackwindow then
					rightbackwindow = false
					RollDownWindow(vehicle, 3, false)
				end
			elseif WarMenu.Button('All Windows Down') then
				leftfrontwindows = true
				rightfrontwindows = true
				leftbackwindow = true
				rightbackwindow = true
				RollDownWindows(vehicle)
			elseif WarMenu.Button('All Windows Up') then
				leftfrontwindows = false
				rightfrontwindows = false
				leftbackwindow = false
				rightbackwindow = false
				RollUpWindow(vehicle, 0, false)
				RollUpWindow(vehicle, 1, false)
				RollUpWindow(vehicle, 2, false)
				RollUpWindow(vehicle, 3, false)
			end
			WarMenu.Display()
		elseif WarMenu.IsMenuOpened('lights') then
			if WarMenu.Button('Interior Lights') then
				if not interiorlights then
					interiorlights = true
					SetVehicleInteriorlight(vehicle, true)
				elseif interiorlights then
					interiorlights = false
					SetVehicleInteriorlight(vehicle, false)
				end
			elseif WarMenu.Button('Front Lights') then
				if not frontlights then
					frontlights = true
					SetVehicleLights(vehicle, true)
				elseif frontlights then
					frontlights = false
					SetVehicleLights(vehicle, false)
				end
			end
			WarMenu.Display()
		end
	end
end)