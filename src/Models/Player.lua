--[[--
The Player class is a model that maps player information.

Just like any other model, it's used to standardize the way addons interact 
with data related to players.

This model will grow over time as new features are implemented in the
library.

@TODO: Make this model extend Unit when the Unit model is implemented <2024.05.06>

@classmod Models.Player
]]
local Player = {}
    Player.__index = Player
    Player.__ = self
    self:addClass('Player', Player)

    --[[--
    Player constructor.
    ]]
    function Player.__construct()
        return setmetatable({}, Player)
    end

    --[[--
    Gets the current player information.

    This method acts as a constructor for the Player model and should not be
    called in a player object instance. Consider this a static builder
    method.

    @treturn Models.Player a new Player object with the current player's information
    ]]
    function Player.getCurrentPlayer()
        return Player.__construct()
            :setName(UnitName('player'))
            :setGuid(UnitGUID('player'))
            :setRealm(self:getClass('Realm'):getCurrentRealm())
    end

    --[[--
    Sets the Player GUID.

    @TODO: Move this method to Unit when the Unit model is implemented <2024.05.06>

    @tparam string value the Player's GUID

    @treturn Models.Player self
    ]]
    function Player:setGuid(value)
        self.guid = value
        return self
    end

    --[[--
    Sets the Player name.

    @TODO: Move this method to Unit when the Unit model is implemented <2024.05.06>

    @tparam string value the Player's name

    @treturn Models.Player self
    ]]
    function Player:setName(value)
        self.name = value
        return self
    end

    --[[--
    Sets the Player realm.

    It's most likely that a player realm will be the same realm as the
    player is logged in, but it's possible to have a player from a different
    realm, especially in Retail, where Blizzard allows players from other
    realms to share the same place or group.

    @tparam Models.Realm value the Player's realm

    @treturn Models.Player self
    ]]
    function Player:setRealm(value)
        self.realm = value
        return self
    end
-- end of Player

-- stores the current player information for easy access
self.currentPlayer = Player.getCurrentPlayer()