local UDCore = exports['ud-core']:GetCoreObject()

RegisterServerEvent('ud-horserentals:RemoveMoneyDonkey')
AddEventHandler('ud-horserentals:RemoveMoneyDonkey', function()
    local src = source
    local player = UDCore.Functions.GetPlayer(src)
    local price = 10
    local money = player.Functions.GetMoney('cash')

    if money >= price then
    player.Functions.RemoveMoney('cash', price)
    end
end)

RegisterServerEvent('ud-horserentals:RemoveMoneyGreyovero')
AddEventHandler('ud-horserentals:RemoveMoneyGreyovero', function()
    local src = source
    local player = UDCore.Functions.GetPlayer(src)
    local price = 12
    local money = player.Functions.GetMoney('cash')

    if money >= price then
    player.Functions.RemoveMoney('cash', price)
    end
end)

