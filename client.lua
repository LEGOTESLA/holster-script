Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 74) then -- 74 is the virtual key code for the "H" key
            TriggerEvent("toggleHandOnHolster")
        end
    end
end)

function DisplayHolsterStatus(status)
    local label = "Holster: Off"
    if status == "on" then
        label = "Holster: On"
    end
    DisplayText(label, 0.5, 0.95)
end

function SetPlayerHolsterStatus(player, status)
    local drawable, texture = 0, 0
    if status == "on" then
        drawable, texture = GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH")
    end
    SetPedComponentVariation(GetPlayerPed(player), 7, drawable, texture, 0)
    DisplayHolsterStatus(status)
end

function SetPlayerHolsterStatus(player, status)
    local drawable, texture = 0, 0
    if status == "on" then
        drawable, texture = GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH")
        TaskPlayAnim(GetPlayerPed(player), "reaction@intimidation@1h", "intro", 8.0, 1.0, -1, 50, 0, false, false, false)
    else
        TaskPlayAnim(GetPlayerPed(player), "reaction@intimidation@1h", "outro", 8.0, 1.0, -1, 50, 0, false, false, false)
    end
    SetPedComponentVariation(GetPlayerPed(player), 7, drawable, texture, 0)
    DisplayHolsterStatus(status)
end

function SetPlayerHolsterStatus(player, status)
    local drawable, texture = 0, 0
    if status == "on" then
        drawable, texture = GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH")
        TaskPlayAnim(GetPlayerPed(player), "reaction@intimidation@1h", "intro", 8.0, 1.0, -1, 50, 0, false, false, false)
        PlaySoundFrontend(-1, "WEAPON_HOLSTER", "HUD_FRONTEND_WEAPONS_MENU_SOUNDSET", false)
    else
        TaskPlayAnim(GetPlayerPed(player), "reaction@intimidation@1h", "outro", 8.0, 1.0, -1, 50, 0, false, false, false)
        PlaySoundFrontend(-1, "WEAPON_UNHOLSTER", "HUD_FRONTEND_WEAPONS_MENU_SOUNDSET", false)
    end
    SetPedComponentVariation(GetPlayerPed(player), 7, drawable, texture, 0)
    DisplayHolsterStatus(status)
end

RegisterKeyMapping("toggle_holster", "Toggle Hand on Holster", "keyboard", "t")

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, GetHashKey("toggle_holster")) then
            if holster_status == "off" then
                holster_status = "on"
            else
                holster_status = "off"
            end
            SetPlayerHolsterStatus(GetPlayerServerId(PlayerId()), holster_status)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if holster_status ~= last_holster_status then
            TriggerServerEvent("player:setHolsterStatus", holster_status)
            last_holster_status = holster_status
        end
    end
end)
