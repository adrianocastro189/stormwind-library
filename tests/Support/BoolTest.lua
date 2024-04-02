TestBool = {}
    -- @covers StormwindLibrary.bool
    function TestBool:testBoolInstanceIsSet()
        local bool = __.bool

        lu.assertNotIsNil(bool)
    end
-- end of TestBool