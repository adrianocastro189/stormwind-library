--[[--
Abstract base class for tooltips.

It provides ways to interact with the game's tooltip system, but it's
abstract in a way that addons should work with the concrete classes that
inherit from this one, instantiated by the factory.

@classmod Facades.AbstractTooltip
]]
local AbstractTooltip = {}
    AbstractTooltip.__index = AbstractTooltip
    AbstractTooltip.__ = self

    -- AbstractTooltip is meant to be inherited by other classes and should
    -- not be instantiated directly, only for testing purposes
    self:addClass('AbstractTooltip', AbstractTooltip, self.environment.constants.TEST_SUITE)

    --[[--
    AbstractTooltip constructor.
    ]]
    function AbstractTooltip.__construct()
        return setmetatable({}, AbstractTooltip)
    end

    --[[--
    Registers all tooltip handlers in game.

    This method should be implemented by the concrete classes that inherit
    from this one, as the way tooltips are handled may vary from one version
    of the game to another.
    ]]
    function AbstractTooltip:registerTooltipHandlers()
        error('This is an abstract method and should be implemented by this class inheritances')
    end
-- end of AbstractTooltip