-- @TODO: Move this test class to the new TestCase structure <2024.07.30>

TestEvents = BaseTestClass:new()
    -- @covers Events:createFrame()
    function TestEvents:testCreateFrame()
        local events = __:new('Events')

        lu.assertNotIsNil(events.eventsFrame)
        lu.assertNotIsNil(events.eventsFrame.scripts['OnEvent'])
        lu.assertIsFunction(events.eventsFrame.scripts['OnEvent'])
    end

    -- @covers Events:handleOriginal()
    function TestEvents:testHandleOriginal()
        local events = __:new('Events')

        local callbackInvoked = false
        local callback = function (param) callbackInvoked = param end

        events:handleOriginal(nil, 'test-event', 'test-arg')

        lu.assertIsFalse(callbackInvoked)

        events.originalListeners['test-event'] = callback

        events:handleOriginal(nil, 'test-event', 'test-arg')

        lu.assertEquals('test-arg', callbackInvoked)
    end

    -- @covers StormwindLibrary.events
    function TestEvents:testLibraryInstanceIsSet()
        local events = __.events

        lu.assertNotIsNil(events)
        lu.assertNotIsNil(events.eventsFrame)

        lu.assertIsTable(events.eventStates)
        lu.assertIsTable(events.listeners)
        lu.assertIsTable(events.originalListeners)
    end

    -- @covers Events:listen()
    function TestEvents:testListen()
        local events = __:new('Events')

        local callback = function () end

        events:listen('test-event', callback)

        lu.assertEquals(callback, events.listeners['test-event'][1])
    end

    -- @covers Events:listenOriginal()
    function TestEvents:testListenOriginal()
        local events = __:new('Events')

        local callback = function () end

        events:listenOriginal('test-event', callback)

        lu.assertEquals(callback, events.originalListeners['test-event'])
        lu.assertTrue(__.arr:inArray(events.eventsFrame.events, 'test-event'))
    end

    -- @covers Events:notify()
    function TestEvents:testNotify()
        local events = __:new('Events')

        local arg1, arg2 = nil, nil
        local callback = function (param1, param2)
            arg1 = param1
            arg2 = param2
        end

        events:listen('test-event', callback)

        events:notify('test-event', 'test-arg-1', 'test-arg-2')

        lu.assertEquals('test-arg-1', arg1)
        lu.assertEquals('test-arg-2', arg2)
    end
-- end of TestEvents