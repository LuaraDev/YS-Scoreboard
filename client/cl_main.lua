local StaffCount = 0
local isRun = false

RegisterNetEvent('ys-scoreboard:open')
AddEventHandler('ys-scoreboard:open', function(Users, PlyNum, Staff)
    StaffCount = Staff

    SendNUIMessage({
        type = 'refresh',
        users = Users,
        plycount = PlyNum,
        staffcount = StaffCount,
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
    })
end)

function Live(Users, PlyNum, Staff)
    while isRun do
        TriggerServerEvent('ys-scoreboard:liveMode')
        Wait(1500)
    end
end


Citizen.CreateThread(function()
    Citizen.Wait(100)
    TriggerServerEvent('ys-scoreboard:load')
end)

Citizen.CreateThread(function()
    Wait(500)
    while true do
        if IsControlJustPressed(0, 10) and not isRun then
            Init()
        end

        Wait(1)
    end
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
