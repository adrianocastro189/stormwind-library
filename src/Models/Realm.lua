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
    Instantiates a new Realm object with the current realm's information.

    This method acts as a constructor for the Realm model and should not be
    called in a realm object instance. Consider this a static builder
    method.

    @treturn Models.Realm a new Realm object with the current realm's information
    ]]
    function Realm.getCurrentRealm()
        local realm = Realm.__construct()

        realm:setName(GetRealmName())

        return realm
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