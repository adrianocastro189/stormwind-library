TestEvents = {}
    -- @covers StormwindLibrary.events
    function TestEvents:testLibraryInstanceIsSet()
        local events = __.events

        lu.assertNotIsNil(events)
    end
-- end of TestEvents