TestEvents = {}
    -- @covers Events:handleOriginal
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
        lu.assertIsTable(events.originalListeners)
    end
-- end of TestEvents