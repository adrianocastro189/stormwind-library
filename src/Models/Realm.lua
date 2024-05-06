--[[--
The Realm class is a model that maps realms also known as servers.

Just like any other model, it's used to standardize the way addons interact 
with realm information.

This model will grow over time as new features are implemented in the
library.

@classmod Models.Realm
]]
local Realm = {}
    Realm.__index = Realm
    Realm.__ = self
    self:addClass('Realm', Realm)

    --[[--
    Realm constructor.
    ]]
    function Realm.__construct()
        return setmetatable({}, Realm)
    end

    --[[--
    Sets the Realm name.

    @tparam string value the Realm's name

    @treturn Models.Realm self
    ]]
    function Realm:setName(value)
        self.name = value
        return self
    end
-- end of Realm