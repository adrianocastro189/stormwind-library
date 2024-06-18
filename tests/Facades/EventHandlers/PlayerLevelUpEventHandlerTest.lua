TestPlayerLevelUpEventHandler = BaseTestClass:new()
    -- @covers PlayerLevelUpEventHandler.lua
    function TestPlayerLevelUpEventHandler:testEventNameIsSet()
        lu.assertEquals('PLAYER_LEVEL_UP', __.events.EVENT_NAME_PLAYER_LEVEL_UP)
    end

    -- @covers PlayerLevelUpEventHandler.lua
    function TestPlayerLevelUpEventHandler:testPlayerLevelUpIsBeingWatched()
        __.currentPlayer = __:new('Player'):setLevel(1)

        lu.assertEquals(1, __.currentPlayer.level)

        __.events:handleOriginal(__, __.events.EVENT_NAME_PLAYER_LEVEL_UP, 2)

        lu.assertEquals(2, __.currentPlayer.level)
    end
-- end of TestPlayerLevelUpEventHandler