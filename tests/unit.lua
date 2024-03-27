lu = require('luaunit')

-- World of Warcraft Mocks
-- @TODO: Move this to a separate file <2024.03.26>
CreateFrame = function ()
    local mockFrame = {
        ['events'] = {},
        ['scripts'] = {},
    }
    mockFrame.RegisterEvent = function (self, event) table.insert(self.events, event) end
    mockFrame.SetScript = function (self, script, callback) self.scripts[script] = callback end
    return mockFrame
end
-- End

dofile('./dist/stormwind-library.lua')
StormwindLibrary = StormwindLibrary_v0_0_7
function newLibrary() return StormwindLibrary.new({
    name = 'TestSuite'
}) end
__ = newLibrary()

dofile('./tests/Commands/CommandsTest.lua')
dofile('./tests/Commands/CommandsHandlerTest.lua')

dofile('./tests/Core/AddonPropertiesTest.lua')
dofile('./tests/Core/FactoryTest.lua')
dofile('./tests/Core/OutputTest.lua')

dofile('./tests/Facades/EventsTest.lua')
dofile('./tests/Facades/EventHandlers/PlayerLoginEventHandlerTest.lua')
dofile('./tests/Facades/EventHandlers/TargetEventHandlerTest.lua')
dofile('./tests/Facades/TargetTest.lua')

dofile('./tests/Models/MacroTest.lua')
dofile('./tests/Models/RaidMarkerTest.lua')

dofile('./tests/Support/ArrTest.lua')
dofile('./tests/Support/StrTest.lua')

lu.ORDER_ACTUAL_EXPECTED=false

os.exit(lu.LuaUnit.run())