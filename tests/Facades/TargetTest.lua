--[[
@covers StormwindLibrary:getTarget()
]]
function testTargetCanGetTargetFacade()
    local target = __:getTarget()

    lu.assertNotIsNil(target)
end