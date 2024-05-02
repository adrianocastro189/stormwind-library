--[[--
The Environment class is used by the library to determine whether it's
running in a specific World of Warcraft client or in a test suite.

Sometimes it's necessary to execute different code depending on the
available API resources, like functions and tables that are available in
Retail but not in Classic and vice versa.

Environment is alvo available to addons, but as long as they register
multiple versions of a class for each supported client, everything should
be transparent and no additional handling is required, not even asking
this class for the current client version.

Note: Environment is registered before the library Factory, which means
it can't be instantiated with library:new(). For any class that needs to
know the current environment, use the library.environment instance.

@classmod Core.Environment
]]
local Environment = {}
    Environment.__index = Environment
    Environment.__ = self

    --[[--
    Constants for the available clients and test suite.

    @table constants
    @field CLIENT_CLASSIC     The current World of Warcraft Classic client,
                              which includes TBC, WotLK, and Cataclysm, etc
    @field CLIENT_CLASSIC_ERA Classic SoD, Hardcore, and any other clients
                              that have no expansions
    @field CLIENT_RETAIL      The current World of Warcraft Retail client
    @field TEST_SUITE         The unit test suite, that executes locally
                              without any World of Warcraft client
    ]]
    Environment.constants = self.arr:freeze({
        CLIENT_CLASSIC     = 'classic',
        CLIENT_CLASSIC_ERA = 'classic-era',
        CLIENT_RETAIL      = 'retail',
        TEST_SUITE         = 'test-suite',
    })

    --[[--
    Environment constructor.
    ]]
    function Environment.__construct()
        return setmetatable({}, Environment)
    end

    --[[--
    Gets the World of Warcraft TOC version.

    @treturn string The client's TOC version
    ]]
    function Environment:getTocVersion()
    -- @TODO: Implement this method in EN3 <2024.05.02>
    end
-- end of Environment

-- stores the current environment instance
self.environment = Environment.__construct()