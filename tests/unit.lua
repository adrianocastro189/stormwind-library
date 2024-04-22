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
StormwindLibrary = StormwindLibrary_v1_1_0

--[[
This is a base test class that sets up the library before each test.

Every test class should inherit from this class to have the library set up
before each test. That way, mocking the library on tests won't affect the
results of other tests.

The setUp() method is expected to be called before each test.
]]
BaseTestClass = {
    new = function(self)
        local instance = {}
        setmetatable(instance, self)
        self.__index = self
        return instance
    end,
    
    setUp = function()
        __ = StormwindLibrary.new({
            name = 'TestSuite'
        })
        __.output:setTestingMode()

        dd = __.output.dd
    end,

    -- guarantees that every test class inherits from this class by forcing
    -- the global library usages to throw an error if it's not set, so
    -- tests that miss inheriting from this class will fail
    tearDown = function()
        __ = nil
    end,
}

dofile('./tests/Commands/CommandsTest.lua')
dofile('./tests/Commands/CommandsHandlerTest.lua')

dofile('./tests/Core/AddonPropertiesTest.lua')
dofile('./tests/Core/ConfigurationTest.lua')
dofile('./tests/Core/FactoryTest.lua')
dofile('./tests/Core/OutputTest.lua')

dofile('./tests/Facades/EventsTest.lua')
dofile('./tests/Facades/EventHandlers/PlayerLoginEventHandlerTest.lua')
dofile('./tests/Facades/EventHandlers/TargetEventHandlerTest.lua')
dofile('./tests/Facades/TargetTest.lua')

dofile('./tests/Models/MacroTest.lua')
dofile('./tests/Models/RaidMarkerTest.lua')

dofile('./tests/Support/ArrTest.lua')
dofile('./tests/Support/BoolTest.lua')
dofile('./tests/Support/StrTest.lua')

lu.ORDER_ACTUAL_EXPECTED=false

os.exit(lu.LuaUnit.run())