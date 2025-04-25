
ESX = exports["es_extended"]:getSharedObject()

local lastFlashTime = 0

-- Blips
Citizen.CreateThread(function()
    for _, cam in pairs(Config.SpeedCameras) do
        if cam.showBlip then
            local blip = AddBlipForCoord(cam.coords)
            SetBlipSprite(blip, 135)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.65)
            SetBlipColour(blip, 1)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(cam.blipLabel or "Blitzer")
            EndTextCommandSetBlipName(blip)
        end
    end
end)

-- Überwachung
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local speed = GetEntitySpeed(player) * 3.6

        for _, cam in pairs(Config.SpeedCameras) do
            local dist = #(coords - cam.coords)
            if dist < Config.Radius and speed > cam.speedLimit then
                local now = GetGameTimer()
                if now - lastFlashTime > 5000 then
                    local vehicle = GetVehiclePedIsIn(player, false)
                    if vehicle ~= 0 then
                        local driver = GetPedInVehicleSeat(vehicle, -1)
                        if driver == player then
                            lastFlashTime = now
                            TriggerServerEvent('esx_speedcamera:flash', cam.fineAmount, speed)
                            TriggerEvent('esx_speedcamera:flashEffect')
                        end
                    end
                end
            end
        end
    end
end)

-- Effekt + Sound
RegisterNetEvent('esx_speedcamera:flashEffect')
AddEventHandler('esx_speedcamera:flashEffect', function()
    StartScreenEffect("SwitchShortNeutralIn", 0, false)
    SendNUIMessage({ type = "playFlashSound" })
    Citizen.Wait(200)
    StopScreenEffect("SwitchShortNeutralIn")
end)
