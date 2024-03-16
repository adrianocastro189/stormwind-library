--[[
The macro class maps macro information and allow in game macro updates.
]]
local Macro = {}
    Macro.__index = Macro
    Macro.__ = self
    self:addClass('Macro', Macro)

    --[[
    Macro constructor.

    @tparam string name the macro's name
    ]]
    function Macro.__construct(name)
        local self = setmetatable({}, Macro)

        self.name = name

        -- defaults
        self:setIcon("INV_Misc_QuestionMark")

        return self
    end

    --[[
    Determines whether this macro exists.

    @treturn boolean
    ]]
    function Macro:exists()
        return GetMacroIndexByName(self.name) > 0
    end

    --[[
    Saves the macro, returning the macro id.

    If the macro, identified by its name, doesn't exist yet, it will be created.

    It's important to mention that this whole Macro class can have weird
    behavior if it tries to save() a macro with dupicated names. Make sure this
    method is called for unique names.

    Future implementations may fix this issue, but as long as it uses unique
    names, this model will work as expected.

    @treturn integer the macro id
    ]]
    function Macro:save()
        if self:exists() then
            return EditMacro(self.name, self.name, self.icon, self.body)
        end

        return CreateMacro(self.name, self.icon, self.body)
    end

    --[[
    Sets the macro body.

    The macro's body is the code that will be executed when the macro's
    triggered.

    If the value is an array, it's considered a multiline body, and lines will
    be separated by a line break.

    @tparam array<string>|string value the macro's body

    @return self
    ]]
    function Macro:setBody(value)
        self.body = self.__.arr:implode('\n', value)
        return self
    end

    --[[
    Sets the macro icon.

    @tparam integer|string value the macro's icon texture id

    @return self
    ]]
    function Macro:setIcon(value)
        self.icon = value
        return self
    end

    --[[
    Sets the macro name.

    This is the macro's identifier, which means the one World of Warcraft API
    will use when accessing the game's macro.

    @tparam string value the macro's name

    @return self
    ]]
    function Macro:setName(value)
        self.name = value
        return self
    end
-- end of Macro