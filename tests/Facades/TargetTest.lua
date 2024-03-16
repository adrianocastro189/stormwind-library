TestTarget = {}
    -- @covers StormwindLibrary:getTarget()
    function TestTarget:testGetTargetFacade()
        local target = __.target

        lu.assertNotIsNil(target)

        lu.assertNotIsNil(target.MARKER_CIRCLE)
        lu.assertNotIsNil(target.MARKER_DIAMOND)
        lu.assertNotIsNil(target.MARKER_MOON)
        lu.assertNotIsNil(target.MARKER_REMOVE)
        lu.assertNotIsNil(target.MARKER_SKULL)
        lu.assertNotIsNil(target.MARKER_SQUARE)
        lu.assertNotIsNil(target.MARKER_STAR)
        lu.assertNotIsNil(target.MARKER_TRIANGLE)
        lu.assertNotIsNil(target.MARKER_X)

        lu.assertIsTable(target.markers)
    end

    -- @covers StormwindLibrary:getTargetMarkIndex()
    function TestTarget:testGetTargetMarkIndex()
        local target = __.target

        local function execution(targetNameOrIndex, expectedIndex)
            lu.assertEquals(expectedIndex, target:getTargetMarkIndex(targetNameOrIndex))
        end

        execution(-1, nil)
        for i = 0, 8 do execution(i, i) end
        execution(9, nil)

        execution('remove', 0)
        execution('star', 1)
        execution('circle', 2)
        execution('diamond', 3)
        execution('triangle', 4)
        execution('moon', 5)
        execution('square', 6)
        execution('x', 7)
        execution('skull', 8)
        execution('invalid', nil)

        execution(target.MARKER_REMOVE, 0)
        execution(target.MARKER_STAR, 1)
        execution(target.MARKER_CIRCLE, 2)
        execution(target.MARKER_DIAMOND, 3)
        execution(target.MARKER_TRIANGLE, 4)
        execution(target.MARKER_MOON, 5)
        execution(target.MARKER_SQUARE, 6)
        execution(target.MARKER_X, 7)
        execution(target.MARKER_SKULL, 8)
    end
    
    -- @covers Target:mark()
    function TestTarget:testMark()
        -- allows restoring the original SetRaidTarget function if needed
        local originalSetRaidTarget = SetRaidTarget

        local setRaidTargetInvoked = false
        SetRaidTarget = function() setRaidTargetInvoked = true end

        local function execution(markNameOrIndex, shouldMark)
            setRaidTargetInvoked = false

            local target = __.target
            target:mark(markNameOrIndex)

            lu.assertEquals(shouldMark, setRaidTargetInvoked)
        end

        execution(-1, false)
        execution(0, true)
        for i = 0, 8 do execution(i, true) end
        execution(9, false)

        -- restores the original SetRaidTarget function
        SetRaidTarget = originalSetRaidTarget
    end
-- end of TestTarget