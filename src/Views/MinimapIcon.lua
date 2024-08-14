--[[--
MinimapIcon is responsible for handling all visual components of this kind of icon
that's one of the most important parts of any addon.

It aims to provide a simple way to create and manage the icon that will be displayed
on the minimap, allowing players to interact with it and providing callbacks for
clicks.

@classmod Views.MinimapIcon
]]
local MinimapIcon = {}
    MinimapIcon.__index = MinimapIcon
    MinimapIcon.__ = self
    self:addClass('MinimapIcon', MinimapIcon)

    --[[--
    MinimapIcon constructor.

    @tparam string id The unique identifier for this icon, or 'default' if none is provided
    ]]
    function MinimapIcon.__construct(id)
        local self = setmetatable({}, MinimapIcon)

        self.id = id or 'default'
        self.isDragging = false
        self.persistStateByPlayer = false

        return self
    end

    --[[--
    Creates the minimap icon visual components.
    ]]
    function MinimapIcon:create()
        -- @TODO: Implement in MI4 <2024.08.14>
        -- @TODO: Add @treturn if necessary <2024.08.14>
    end

    --[[--
    Sets the minimap icon angle position.

    @tparam number value The angle position in degrees

    @treturn Views.MinimapIcon The minimap icon instance, for method chaining

    @usage
        icon:setAnglePosition(85.5)
    ]]
    function MinimapIcon:setAnglePosition(value)
        self.anglePosition = value
        return self
    end

    --[[--
    Sets the minimap icon callback for left clicks.

    @tparam function value The callback function
    
    @treturn Views.MinimapIcon The minimap icon instance, for method chaining

    @usage
        icon:setCallbackOnLeftClick(function()
            print('Left click!')
        end)
    ]]
    function MinimapIcon:setCallbackOnLeftClick(value)
        self.callbackOnLeftClick = value
        return self
    end

    --[[--
    Sets the minimap icon callback for right clicks.

    @tparam function value The callback function
    
    @treturn Views.MinimapIcon The minimap icon instance, for method chaining

    @usage
        icon:setCallbackOnRightClick(function()
            print('Right click!')
        end)
    ]]
    function MinimapIcon:setCallbackOnRightClick(value)
        self.callbackOnRightClick = value
        return self
    end

    --[[--
    Sets the minimap icon first angle position.

    The first angle position is the position that the minimap icon will have when
    it's first created. If the player moves the icon and this instance is persisting
    its state, this property will be ignored.

    @tparam number value The first angle position in degrees

    @treturn Views.MinimapIcon The minimap icon instance, for method chaining

    @usage
        icon:setFirstAnglePosition(85.5)
    ]]
    function MinimapIcon:setFirstAnglePosition(value)
        self.firstAnglePosition = value
        return self
    end

    --[[--
    Sets the minimap icon image, which will be passed to the icon texture.

    @tparam string value The image path

    @treturn Views.MinimapIcon The minimap icon instance, for method chaining

    @usage
        icon:setImage('Interface\\Icons\\INV_Misc_QuestionMark')
    ]]
    function MinimapIcon:setIcon(value)
        self.icon = value
        return self
    end

    --[[--
    Sets the minimap icon instance to have its stated persisted in the player's
    configuration instead of the global one.

    @tparam boolean value Whether the minimap icon should persist its state by player

    @treturn Views.MinimapIcon The minimap icon instance, for method chaining

    @usage
        icon:setPersistStateByPlayer(true)
    ]]
    function MinimapIcon:setPersistStateByPlayer(value)
        self.persistStateByPlayer = value
        return self
    end

    --[[--
    Sets the minimap tooltip lines.

    If no lines are provided, the tooltip will be displayed with default information.

    @tparam string[] value The tooltip lines

    @treturn Views.MinimapIcon The minimap icon instance, for method chaining

    @usage
        icon:setTooltipLines({
            'Click to open settings',
            'Right click to show a panel',
            'Drag this icon to move',
        })
    ]]
    function MinimapIcon:setTooltipLines(value)
        self.tooltipLines = value
        return self
    end
-- end of MinimapIcon