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
    Handles the event fired from the game when a tooltip is shown.

    If the tooltip is consistent and represents a tooltip instance, this
    method notifies the library event system so subscribers can act upon it
    regardless of the client version.

    @local

    @tparam GameTooltip tooltip The tooltip that was shown
    ]]
    function AbstractTooltip:onItemTooltipShow(tooltip)
        if tooltip == GameTooltip then
            -- @TODO: Collect more information from items <2024.05.03>
            local item = self.__
                :new('Item')
                :setName(tooltip:GetItem())

            self.__.events:notify('ITEM_TOOLTIP_SHOWN', item)
        end
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