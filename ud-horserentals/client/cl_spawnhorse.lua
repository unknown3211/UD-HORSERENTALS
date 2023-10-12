local UDCore = exports['ud-core']:GetCoreObject()

RegisterCommand('openhrmenu', function()
TriggerEvent('ud-horserentals:client:OpenMenu')
end)

Citizen.CreateThread(function()
    for horserental, v in pairs(Config.HorseRentalLocations) do
        exports['ud-core']:createPrompt(v.prompt, v.coords, UDCore.Shared.Keybinds['J'], 'Open ' .. v.name, {
            type = 'client',
            event = 'ud-horserentals:client:OpenMenu',
        })
        if v.showblip == true then
            local HorseRentalBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(HorseRentalBlip, GetHashKey(Config.HorseRentalBlip.blipSprite), true)
            SetBlipScale(HorseRentalBlip, Config.HorseRentalBlip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402,HorseRentalBlip, Config.HorseRentalBlip.blipName)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1)
        for horserentals, v in pairs(Config.HorseRentalLocations) do
            if v.showmarker == true then
                Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 215, 0, 155, false, false, false, 1, false, false, false)
            end
        end
    end
end)

RegisterNetEvent('ud-horserentals:client:OpenMenu', function()
    exports['ud-menu']:openMenu({
        {
            header = 'UD Horse Rentals',
            isMenuHeader = true,
        },
        {
            header = 'Rent Donkey',
            icon = "fas fa-cog",
            txt = 'Rent A Good Ole Donkey Mate $10',
            params = {
                event = "ud-horserentals:rentDonkey"
            }
        },
        {
            header = 'Rent Greyovero',
            icon = "fas fa-cog",
            txt = 'Rent A Good Ole Greyovero Mate $12',
            params = {
                event = "ud-horserentals:rentGreyovero"
            }
        },
    })
end)

RegisterNetEvent('ud-horserentals:rentDonkey')
AddEventHandler('ud-horserentals:rentDonkey', function()
   local ped = PlayerPedId()
   local horseModel = 'A_C_Donkey_01'

   local modelHash = GetHashKey(horseModel)

   if not IsModelInCdimage(modelHash) or not IsModelValid(modelHash) then
       return
   end

   RequestModel(modelHash)
   while not HasModelLoaded(modelHash) do
       Wait(500)
   end

   local spawnCoords = vector4(2685.97, -1437.26, 46.09, 310.31)
   local horse = CreatePed(modelHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnCoords.w, false, false)

   SetModelAsNoLongerNeeded(modelHash)
   Citizen.InvokeNative(0x283978A15512B2FE, horse, true)
   NetworkSetEntityInvisibleToNetwork(horse, false)

   TriggerServerEvent('ud-horserentals:RemoveMoneyDonkey')
   TriggerEvent('UDCore:Notify', 'Spawned Your Donkey', 'success')
end, false)


RegisterNetEvent('ud-horserentals:rentGreyovero')
AddEventHandler('ud-horserentals:rentGreyovero', function()
   local ped = PlayerPedId()
   local horseModel = 'A_C_Horse_AmericanPaint_Greyovero'

   local modelHash = GetHashKey(horseModel)

   if not IsModelInCdimage(modelHash) or not IsModelValid(modelHash) then
       return
   end

   RequestModel(modelHash)
   while not HasModelLoaded(modelHash) do
       Wait(500)
   end

   local spawnCoords = vector4(2685.97, -1437.26, 46.09, 310.31)
   local horse = CreatePed(modelHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnCoords.w, false, false)

   SetModelAsNoLongerNeeded(modelHash)
   Citizen.InvokeNative(0x283978A15512B2FE, horse, true)
   NetworkSetEntityInvisibleToNetwork(horse, false)

   TriggerServerEvent('ud-horserentals:RemoveMoneyGreyovero')
   TriggerEvent('UDCore:Notify', 'Spawned Your Greyovero', 'success')
end, false)