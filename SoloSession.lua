-- Solo Server Switcher

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local PlaceId = game.PlaceId
local JobId = game.JobId
local LocalPlayer = Players.LocalPlayer

local function notify(title, text)
    print(title .. ": " .. text)
end

local function findSoloServer()
    if syn and syn.request then -- Check for exploit specific function
        local servers = {}
        local req = syn.request({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId)})
        local body = HttpService:JSONDecode(req.Body)

        if body and body.data then
            for i, v in ipairs(body.data) do
                if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers then
                    if v.playing == 0 then -- Found a server with no players
                        table.insert(servers, 1, v.id) -- Add it to the beginning of the table, increasing its priority
                    end
                end
            end
        end
		
		if #servers > 0 then
            -- Teleport to the first server in the list (which will be a solo server if one was found)
            TeleportService:TeleportToPlaceInstance(PlaceId, servers[1], LocalPlayer)
            notify("Solo Server Found", "Teleporting to a solo server...")
        else
            notify("Solo Server Search", "No solo server found. Trying again...")
			wait(5)
			findSoloServer()
        end
    elseif game:HttpGetAsync then -- Check for default httprequest
		local servers = {}
        local req = game:HttpGetAsync(string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId))
        local body = HttpService:JSONDecode(req)

        if body and body.data then
            for i, v in ipairs(body.data) do
                if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers then
                    if v.playing == 0 then -- Found a server with no players
                        table.insert(servers, 1, v.id) -- Add it to the beginning of the table, increasing its priority
                    end
                end
            end
        end
		
		if #servers > 0 then
            -- Teleport to the first server in the list (which will be a solo server if one was found)
            TeleportService:TeleportToPlaceInstance(PlaceId, servers[1], LocalPlayer)
            notify("Solo Server Found", "Teleporting to a solo server...")
        else
            notify("Solo Server Search", "No solo server found. Trying again...")
			wait(5)
			findSoloServer()
        end
	else
        notify("Incompatible Exploit", "Your exploit does not support this command (missing HTTP request function)")
    end
end

-- Initiate the solo server search
findSoloServer()
