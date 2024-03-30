TestMacro = {}
    -- @covers Macro:__construct()
    function TestMacro:testInstantiate()
        local macro = __:new('Macro', 'test-macro')

        lu.assertNotIsNil(macro)
        lu.assertEquals('test-macro', macro.name)
    end

    -- @covers Macro:setBody()
    function TestMacro:testSetBody()
        local macro = __:new('Macro', 'test-macro')

        macro:setBody('test-body')

        lu.assertEquals('test-body', macro.body)
    end
-- end of TestMacro