TestPlayerCombatStatusEventHandler = BaseTestClass:new()
    -- @covers PlayerCombatStatusEventHandler.lua
    function TestPlayerCombatStatusEventHandler:testEventNamesAreSet()
        lu.assertEquals('PLAYER_ENTERED_COMBAT', __.events.EVENT_NAME_PLAYER_ENTERED_COMBAT)
        lu.assertEquals('PLAYER_LEFT_COMBAT', __.events.EVENT_NAME_PLAYER_LEFT_COMBAT)
    end

    -- @covers PlayerCombatStatusEventHandler.lua
    function TestPlayerCombatStatusEventHandler:testRegenEventsAreBeingWatched()
        local events = __.events

        local listenerMock = {
            enteredCombatEventBroadcasted = false,
            leftCombatEventBroadcasted = false
        }

        events:listen(events.EVENT_NAME_PLAYER_ENTERED_COMBAT, function ()
            listenerMock.enteredCombatEventBroadcasted = true
        end)

        events:listen(events.EVENT_NAME_PLAYER_LEFT_COMBAT, function ()
            listenerMock.leftCombatEventBroadcasted = true
        end)

        lu.assertIsFalse(listenerMock.enteredCombatEventBroadcasted)
        lu.assertIsFalse(listenerMock.leftCombatEventBroadcasted)

        events:handleOriginal(nil, 'PLAYER_REGEN_DISABLED')

        lu.assertIsTrue(listenerMock.enteredCombatEventBroadcasted)
        lu.assertIsFalse(listenerMock.leftCombatEventBroadcasted)

        events:handleOriginal(nil, 'PLAYER_REGEN_ENABLED')

        lu.assertIsTrue(listenerMock.enteredCombatEventBroadcasted)
        lu.assertIsTrue(listenerMock.leftCombatEventBroadcasted)
    end
-- end of TestPlayerLevelUpEventHandler