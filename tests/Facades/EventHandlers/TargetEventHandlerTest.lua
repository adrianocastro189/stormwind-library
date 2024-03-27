TestTargetEventHandler = {}
    -- @covers TargetEventHandler.lua
    function TestTargetEventHandler:testEventNamesAreSet()
        lu.assertEquals('PLAYER_TARGET', __.events.EVENT_NAME_PLAYER_TARGET)
        lu.assertEquals('PLAYER_TARGET_CHANGED', __.events.EVENT_NAME_PLAYER_TARGET_CHANGED)
        lu.assertEquals('PLAYER_TARGET_CLEAR', __.events.EVENT_NAME_PLAYER_TARGET_CLEAR)
    end
-- end of TestTargetEventHandler