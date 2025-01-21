local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local function getGameName()
    return gameName
end

return {
    GetGameName = getGameName,
}
