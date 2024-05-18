lu = require('luaunit')

dofile('./dist/stormwind-library.lua')
StormwindLibrary = StormwindLibrary_v1_3_0

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
        -- this makes the Environment class to return the proper client flavor when
        -- running this test suite
        _G['TEST_ENVIRONMENT'] = true

        dofile('./tests/wow-mocks.lua')

        __ = StormwindLibrary.new({
            name = 'TestSuite'
        })
        __.output:setTestingMode()

        function dd(...) __.output:dd(...) end
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
dofile('./tests/Core/EnvironmentTest.lua')
dofile('./tests/Core/FactoryTest.lua')
dofile('./tests/Core/OutputTest.lua')

dofile('./tests/Facades/EventsTest.lua')
dofile('./tests/Facades/EventHandlers/PlayerLoginEventHandlerTest.lua')
dofile('./tests/Facades/EventHandlers/TargetEventHandlerTest.lua')
dofile('./tests/Facades/TargetTest.lua')
dofile('./tests/Facades/Tooltips/AbstractTooltipTest.lua')
dofile('./tests/Facades/Tooltips/ClassicTooltipTest.lua')
dofile('./tests/Facades/Tooltips/RetailTooltipTest.lua')

dofile('./tests/Models/ItemTest.lua')
dofile('./tests/Models/MacroTest.lua')
dofile('./tests/Models/RaidMarkerTest.lua')
dofile('./tests/Models/RealmTest.lua')
dofile('./tests/Models/PlayerTest.lua')

dofile('./tests/Support/ArrTest.lua')
dofile('./tests/Support/BoolTest.lua')
dofile('./tests/Support/StrTest.lua')

dofile('./tests/Views/Windows/WindowTest.lua')

lu.ORDER_ACTUAL_EXPECTED=false

os.exit(lu.LuaUnit.run())