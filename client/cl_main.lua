-- https://dz-security.live/discord/

local StaffCount = 0
local isRun = false

MaxPlayers = GetConvarInt('sv_maxclients', 32)

RegisterCommand('ys-scoreboard:open', function() Init() end, false)
RegisterKeyMapping('ys-scoreboard:open', 'Scoreboard : Open', 'keyboard', 'PAGEUP')

RegisterNetEvent('ys-scoreboard:open')
AddEventHandler('ys-scoreboard:open', function(Users, PlyNum, Staff)
    StaffCount = Staff
    SendNUIMessage({
        type = 'refresh',
        users = Users,
        plycount = PlyNum,
        staffcount = StaffCount,
        maxcount = MaxPlayers,
    })
    Live(Users, PlyNum, StaffCount)
end)

RegisterNetEvent('ys-scoreboard:live')
AddEventHandler('ys-scoreboard:live', function(Users, PlyNum, Staff)
    SendNUIMessage({
        type = 'live',
        users = Users,
        plycount = PlyNum,
        staffcount = Staff,
        maxcount = MaxPlayers,
    })
end)

function Live(Users, PlyNum, Staff)
    while isRun do
        TriggerServerEvent('ys-scoreboard:getPlayers', true)
        Wait(1500)
    end
end

Citizen.CreateThread(function()
    Citizen.Wait(100)
    TriggerServerEvent('ys-scoreboard:load')
end)

function Init()
    TriggerServerEvent('ys-scoreboard:getPlayers')
    TriggerScreenblurFadeIn(500)
    SetNuiFocus(true, true)
    isRun = true
end

RegisterNUICallback("close", function()
    TriggerScreenblurFadeOut(500)
    SetNuiFocus(false, false)
    isRun = false
end)

if MaxPlayers > 1250 then
    MaxPlayers = GetConvarInt('sv_maxclients', 32)
end
