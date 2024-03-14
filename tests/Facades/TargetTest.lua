TestTarget = {}
    -- @covers StormwindLibrary:getTarget()
    function TestTarget:testCanGetTargetFacade()
        local target = __:getTarget()

        lu.assertNotIsNil(target)
    end
-- end of TestTarget