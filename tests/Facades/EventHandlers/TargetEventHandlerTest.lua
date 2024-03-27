TestTargetEventHandler = {}
    -- @covers TargetEventHandler.lua
    function TestTargetEventHandler:testEventNamesAreSet()
        lu.assertEquals('PLAYER_TARGET', __.events.EVENT_NAME_PLAYER_TARGET)
        lu.assertEquals('PLAYER_TARGET_CHANGED', __.events.EVENT_NAME_PLAYER_TARGET_CHANGED)
        lu.assertEquals('PLAYER_TARGET_CLEAR', __.events.EVENT_NAME_PLAYER_TARGET_CLEAR)
    end

    -- @covers Events.eventStates.playerHadTarget
    function TestTargetEventHandler:testEventStates()
        lu.assertIsFalse(__.events.eventStates['playerHadTarget'])
    end

    -- @covers TargetEventHandler.lua
    function TestTargetEventHandler:testPlayerTargetChangeIsBeingWatched()
        lu.assertIsFunction(__.events.originalListeners['PLAYER_TARGET_CHANGED'])
    end

    -- @covers Events:playerTargetChangedListener()
    function TestTargetEventHandler:testPlayerTargetChangedListener()
        
    end
-- end of TestTargetEventHandler