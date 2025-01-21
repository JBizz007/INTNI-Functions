local MarketplaceService = game:GetService("MarketplaceService")
local placeId = game.PlaceId

local function getGameName(placeId)
    local success, productInfo = pcall(function()
        return MarketplaceService:GetProductInfo(placeId, Enum.InfoType.Asset)
    end)

    if success then
        return productInfo.Name
    else
        warn("Error getting game name:", productInfo)
        return nil
    end
end

local gameName = getGameName(placeId)

if gameName then
    print("Game Name:", gameName)
else
    print("Failed to get game name.")
end
