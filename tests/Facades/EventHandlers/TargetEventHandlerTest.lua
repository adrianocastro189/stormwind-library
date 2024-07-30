-- @TODO: Move this test class to the new TestCase structure <2024.07.30>

TestTargetEventHandler = BaseTestClass:new()
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
        local function execution(playerHadTarget, playerHasTarget, expectedEvent, expectedPlayerHadTargetState)
            local targetMock = __:new('Target')
            targetMock.hasTarget = function() return playerHasTarget end
            __.target = targetMock

            local events = __.events

            events.eventStates.playerHadTarget = playerHadTarget

            local expectedEventWasFired = false

            events:listen(expectedEvent, function () expectedEventWasFired = true end)

            events:playerTargetChangedListener()

            lu.assertIsTrue(expectedEventWasFired)
            lu.assertEquals(expectedPlayerHadTargetState, events.eventStates.playerHadTarget)
        end

        execution(false, true, 'PLAYER_TARGET', true)
        execution(true, true, 'PLAYER_TARGET_CHANGED', true)
        execution(true, false, 'PLAYER_TARGET_CLEAR', false)
    end
-- end of TestTargetEventHandler