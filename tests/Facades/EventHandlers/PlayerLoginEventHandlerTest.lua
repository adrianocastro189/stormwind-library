-- @TODO: Move this test class to the new TestCase structure <2024.07.30>

TestPlayerLoginEventHandler = BaseTestClass:new()
    -- @covers PlayerLoginEventHandler.lua
    function TestPlayerLoginEventHandler:testEventNameIsSet()
        lu.assertEquals('PLAYER_LOGIN', __.events.EVENT_NAME_PLAYER_LOGIN)
    end

    -- @covers PlayerLoginEventHandler.lua
    function TestPlayerLoginEventHandler:testPlayerLoginIsBeingWatched()
        lu.assertIsFunction(__.events.originalListeners['PLAYER_LOGIN'])
    end
-- end of TestPlayerLoginEventHandler