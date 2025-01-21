local gameId = game.PlaceId
local gameName = game:GetService("MarketplaceService"):GetProductInfo(gameId).Name

local function getGameName()
    return gameName
end

local function getGameId()
    return gameId
end

return {
    GetGameName = getGameName,
    GetGameId = getGameId,
}
