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
    Environment constructor.
    ]]
    function Environment.__construct()
        return setmetatable({}, Environment)
    end
-- end of Environment

-- stores the current environment instance
self.environment = Environment.__construct()