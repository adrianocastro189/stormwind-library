--[[
@covers Macro:__construct()
]]
function testMacroCanInstantiate()
    local macro = __:new('Macro', 'test-macro')

    lu.assertNotIsNil(macro)
    lu.assertEquals(macro.name, 'test-macro')
end

--[[
@covers Macro:setBody()
]]
function testMacroCanSetBody()
    local macro = __:new('Macro', 'test-macro')

    macro:setBody('test-body')

    lu.assertEquals(macro.body, 'test-body')
end