lu = require('luaunit')

dofile('./dist/stormwind-library.lua')
StormwindLibrary = StormwindLibrary_v1_12_2

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

        function dd(...) __:dd(...) end
    end,

    -- guarantees that every test class inherits from this class by forcing
    -- the global library usages to throw an error if it's not set, so
    -- tests that miss inheriting from this class will fail
    tearDown = function()
        __ = nil
    end,
}

--[[
Allows test classes to create reusable test cases for one or multiple
scenarios.

It works by registering one test method per scenario, where the test method
is named after the test case name and the scenario name. Inspired by PHPUnit
data provider structure.
]]
TestCase = {}
    TestCase.__index = TestCase

    -- constructor
    function TestCase.new() return setmetatable({}, TestCase) end

    -- creates one test method per scenario
    function TestCase:register()
        self.scenarios = self.scenarios or {[''] = {}}
        for scenario, data in pairs(self.scenarios) do
            local methodName = 'test_' .. self.name .. (scenario ~= '' and (':' .. scenario) or '')
            if self.testClass[methodName] then error('Test method already exists: ' .. methodName) end
            self.testClass[methodName] = function()
                if type(data) == "function" then
                    data = data()
                end
                self.execution(data)
            end
        end
    end

    -- setters
    function TestCase:setExecution(value) self.execution = value return self end
    function TestCase:setName(value) self.name = value return self end
    function TestCase:setScenarios(value) self.scenarios = value return self end
    function TestCase:setTestClass(value) self.testClass = value return self end
-- end of TestCase

dofile('./tests/spies.lua')

dofile('./tests/Commands/CommandsTest.lua')
dofile('./tests/Commands/CommandsHandlerTest.lua')

dofile('./tests/Core/AddonPropertiesTest.lua')
dofile('./tests/Core/CallbackLoaderTest.lua')
dofile('./tests/Core/ConfigurationTest.lua')
dofile('./tests/Core/EnvironmentTest.lua')
dofile('./tests/Core/FactoryTest.lua')
dofile('./tests/Core/OutputTest.lua')
dofile('./tests/Core/VersionTest.lua')

dofile('./tests/Facades/EventsTest.lua')
dofile('./tests/Facades/EventHandlers/PlayerCombatStatusEventHandlerTest.lua')
dofile('./tests/Facades/EventHandlers/PlayerLevelUpEventHandlerTest.lua')
dofile('./tests/Facades/EventHandlers/PlayerLoginEventHandlerTest.lua')
dofile('./tests/Facades/EventHandlers/TargetEventHandlerTest.lua')
dofile('./tests/Facades/PetJournalTest.lua')
dofile('./tests/Facades/TargetTest.lua')
dofile('./tests/Facades/Tooltips/AbstractTooltipTest.lua')
dofile('./tests/Facades/Tooltips/ClassicTooltipTest.lua')
dofile('./tests/Facades/Tooltips/RetailTooltipTest.lua')

dofile('./tests/Factories/ItemFactoryTest.lua')

dofile('./tests/Models/ContainerTest.lua')
dofile('./tests/Models/InventoryTest.lua')
dofile('./tests/Models/ItemTest.lua')
dofile('./tests/Models/MacroTest.lua')
dofile('./tests/Models/RaidMarkerTest.lua')
dofile('./tests/Models/RealmTest.lua')
dofile('./tests/Models/PlayerTest.lua')

dofile('./tests/Support/ArrTest.lua')
dofile('./tests/Support/BoolTest.lua')
dofile('./tests/Support/StrTest.lua')
dofile('./tests/Support/IntervalTest.lua')

dofile('./tests/Views/ViewConstantsTest.lua')
dofile('./tests/Views/MinimapIconTest.lua')
dofile('./tests/Views/Windows/WindowPageTest.lua')
dofile('./tests/Views/Windows/WindowTest.lua')

lu.ORDER_ACTUAL_EXPECTED=false

os.exit(lu.LuaUnit.run())