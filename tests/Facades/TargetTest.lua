TestTarget = BaseTestClass:new()
    -- @covers StormwindLibrary.target
    function TestTarget:testGetTargetFacade()
        local target = __.target

        lu.assertNotIsNil(target)
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