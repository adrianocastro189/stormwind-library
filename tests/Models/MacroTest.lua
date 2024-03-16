TestMacro = {}
    -- @covers Macro:__construct()
    function TestMacro:testCanInstantiate()
        local macro = __:new('Macro', 'test-macro')

        lu.assertNotIsNil(macro)
        lu.assertEquals('test-macro', macro.name)
    end

    -- @covers Macro:setBody()
    function TestMacro:testCanSetBody()
        local macro = __:new('Macro', 'test-macro')

        macro:setBody('test-body')

        lu.assertEquals('test-body', macro.body)
    end
-- end of TestMacro