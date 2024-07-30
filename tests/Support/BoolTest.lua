-- @TODO: Move this test class to the new TestCase structure <2024.07.30>

TestBool = BaseTestClass:new()
    -- @covers StormwindLibrary.bool
    function TestBool:testBoolInstanceIsSet()
        local bool = __.bool

        lu.assertNotIsNil(bool)
    end

    -- @covers Bool:isTrue()
    function TestBool:testIsTrue()
        local bool = __.bool

        lu.assertTrue(bool:isTrue(1))
        lu.assertTrue(bool:isTrue("1"))
        lu.assertTrue(bool:isTrue('1'))
        lu.assertTrue(bool:isTrue("true"))
        lu.assertTrue(bool:isTrue(true))
        lu.assertTrue(bool:isTrue("yes"))

        lu.assertFalse(bool:isTrue(0))
        lu.assertFalse(bool:isTrue("0"))
        lu.assertFalse(bool:isTrue("false"))
        lu.assertFalse(bool:isTrue(false))
        lu.assertFalse(bool:isTrue("no"))
        lu.assertFalse(bool:isTrue(nil))
    end
-- end of TestBool