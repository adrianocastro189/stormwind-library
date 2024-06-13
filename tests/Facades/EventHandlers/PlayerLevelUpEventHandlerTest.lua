TestPlayerLevelUpEventHandler = BaseTestClass:new()
    -- @covers PlayerLevelUpEventHandler.lua
    function TestPlayerLevelUpEventHandler:testEventNameIsSet()
        lu.assertEquals('PLAYER_LEVEL_UP', __.events.EVENT_NAME_PLAYER_LEVEL_UP)
    end

    -- @covers PlayerLevelUpEventHandler.lua
    function TestPlayerLevelUpEventHandler:testPlayerLevelUpIsBeingWatched()
        lu.assertIsFunction(__.events.originalListeners['PLAYER_LEVEL_UP'])
    end
-- end of TestPlayerLevelUpEventHandler