TestCallbackLoader = BaseTestClass:new()

TestCase.new()
    :setName('onLoad')
    :setTestClass(TestCallbackLoader)
    :setExecution(function()
        lu.assertIsTrue(__.callbacksInvoked)

        lu.assertIsNil(__.destroyCallbackLoader)
        lu.assertIsNil(__.invokeLoadCallbacks)
        lu.assertIsNil(__.loadCallbacks)
        lu.assertIsNil(__.onLoad)
    end)
    :register()
-- end of TestCallbackLoader