RegisterServerEvent("toggleHandOnHolster")
AddEventHandler("toggleHandOnHolster", function()
    local player = source
    local holsterStatus = GetPlayerHolsterStatus(player)
    if holsterStatus == "on" then
        SetPlayerHolsterStatus(player, "off")
    else
        SetPlayerHolsterStatus(player, "on")
    end
end)

function GetPlayerHolsterStatus(player)
    local holsterStatus = "off"
    if GetPedDrawableVariation(GetPlayerPed(player), 7) ~= 0 then
        holsterStatus = "on"
    end
    return holsterStatus
end

function SetPlayerHolsterStatus(player, status)
    local drawable, texture = 0, 0
    if status == "on" then
        drawable, texture = GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH")
    end
    SetPedComponentVariation(GetPlayerPed(player), 7, drawable, texture, 0)
end

RegisterServerEvent("player:setHolsterStatus")
AddEventHandler("player:setHolsterStatus", function(status)
    local source = source
    TriggerClientEvent("player:setHolsterStatus", source, status)
end)
