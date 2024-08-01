-- @TODO: Move this test class to the new TestCase structure <2024.07.30>

TestViewConstants = BaseTestClass:new()
    -- @covers StormwindLibrary.viewConstants
    function TestViewConstants:testViewConstantsAreProtected()
        -- @NOTE: Having only one constant here is enough to test the protection
        --        so there's no need to test all of them
        lu.assertError(function() __.viewConstants.DEFAULT_BACKGROUND_TEXTURE = 'test' end)
    end

    -- @covers StormwindLibrary.viewConstants
    function TestViewConstants:testViewConstantsAreSet()
        lu.assertEquals('Interface/Tooltips/UI-Tooltip-Background', __.viewConstants.DEFAULT_BACKGROUND_TEXTURE)
    end
-- end of TestViewConstants