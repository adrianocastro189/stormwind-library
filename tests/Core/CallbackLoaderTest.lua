-- @TODO: Move this test class to the new TestCase structure <2024.07.30>

TestCallbackLoader = BaseTestClass:new()
    -- @covers CallbackLoader.lua
    function TestCallbackLoader:testOnLoad()
        lu.assertIsTrue(__.callbacksInvoked)

        lu.assertIsNil(__.destroyCallbackLoader)
        lu.assertIsNil(__.invokeLoadCallbacks)
        lu.assertIsNil(__.loadCallbacks)
        lu.assertIsNil(__.onLoad)
    end
-- end of TestCallbackLoader