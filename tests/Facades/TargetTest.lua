-- @TODO: Move this test class to the new TestCase structure <2024.07.30>

TestTarget = BaseTestClass:new()
    -- @covers Target:getMark()
    function TestTarget:testGetMark()
        local execution = function(raidTargetIndex, expectedMark)
            GetRaidTargetIndex = function(unit)
                return raidTargetIndex
            end

            local target = __.target

            lu.assertEquals(expectedMark, target:getMark())
        end

        execution(nil, nil)
        execution(8, __.raidMarkers.skull)
    end

    -- @covers StormwindLibrary.target
    function TestTarget:testGetTargetFacade()
        local target = __.target

        lu.assertNotIsNil(target)
    end

    -- @covers Target:isMarked()
    function TestTarget:testIsMarked()
        local execution = function(mark, expectedIsMarked)
            local target = __.target

            target.getMark = function() return mark end

            lu.assertEquals(expectedIsMarked, target:isMarked())
        end

        execution(nil, false)
        execution(__.raidMarkers[1], true)
    end

    -- @covers Target:mark()
    function TestTarget:testMark()
        -- allows restoring the original SetRaidTarget function if needed
        local originalSetRaidTarget = SetRaidTarget

        local unitArg = nil
        local indexArg = nil
        SetRaidTarget = function(unit, index) 
            unitArg = unit
            indexArg = index
        end

        __.target:mark(__.raidMarkers.skull)

        lu.assertEquals('target', unitArg)
        lu.assertEquals(8, indexArg)

        -- restores the original SetRaidTarget function
        SetRaidTarget = originalSetRaidTarget
    end
-- end of TestTarget