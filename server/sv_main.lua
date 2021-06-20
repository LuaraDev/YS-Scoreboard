-- https://dz-security.live/discord/

local Users = {}
local Players = {}

RegisterNetEvent('ys-scoreboard:load')
AddEventHandler('ys-scoreboard:load', function()
    local src = source
    for k,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifier = v
            local first = identifier:gsub("discord:", "")
            identifier = first
        end
    end

    if identifier ~= nil then
        local identifierArgs = identifier
        local Finalidentifier = identifierArgs:gsub("discord:", "")
        identifier = tonumber(Finalidentifier)
        PerformHttpRequest("https://discordapp.com/api/guilds/" .. DZ.GuildID .. "/members/"..identifier, function(error, result, header)
            local result = json.decode(result)
            local url = "https://cdn.discordapp.com/avatars/"..result["user"]["id"].."/"..result["user"]["avatar"].."?size=128"
            local username = result["user"]["username"].."#"..result["user"]["discriminator"]
            Users[src] = {id = src, avatar = url, name = username}
        end, "GET", "", {["Content-type"] = "application/json", ["Authorization"] = "Bot " .. DZ.DiscordBotToken})
    else
      Users[src] = {id = src, avatar = "https://discordapp.com/assets/7c8f476123d28d103efe381543274c25.png", name = GetPlayerName(src)}
    end
end)

AddEventHandler('playerDropped', function()
    Users[source] = nil
end)

RegisterNetEvent('ys-scoreboard:getPlayers')
AddEventHandler('ys-scoreboard:getPlayers', function(live)
    local src = source
    local data = {}
    local PlayerNum = GetNumPlayerIndices()
    local StaffNum = 0

    for k,v in pairs(Users) do
	    table.insert(data, {image = v.avatar, name = v.name, ping = GetPlayerPing(v.id), Players = #GetPlayers()})
        TriggerEvent("es:getPlayerFromId", k, function(user)
            if user.getGroup() ~= "user" then
                StaffNum = StaffNum + 1
            end
        end)
    end

    if live then
        TriggerClientEvent('ys-scoreboard:live', src, data, PlayerNum, StaffNum)
    else
        TriggerClientEvent('ys-scoreboard:open', src, data, PlayerNum, StaffNum)
    end
end)
