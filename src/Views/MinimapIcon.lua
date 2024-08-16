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
    Decides whether this instance should proxy to the player's or the global
    configuration instance.

    By default, the minimap icon will proxy to the global configuration instance.
    ]]
    function MinimapIcon:config(...)
        if self.persistStateByPlayer then
            return self.__:playerConfig(...)
        end
        
        return self.__:config(...)
    end

    --[[--
    Creates the minimap icon visual components.
    ]]
    function MinimapIcon:create()
        if self.minimapIcon then
            return
        end

        self.minimapIcon = self:createIconFrame()

        self:createIconTexture()
        self:createIconOverlay()
        self:setAnglePositionOnCreation()
        self:setVisibilityOnCreation()
    end

    --[[--
    Creates and sets up a minimap icon frame.

    @treturn table The minimap icon frame created by CreateFrame
    ]]
    function MinimapIcon:createIconFrame()
        local minimapIcon = CreateFrame('Button', 'Minimap' .. self.id, Minimap)
        minimapIcon:RegisterForClicks('AnyUp')
        minimapIcon:SetFrameLevel(8)
        minimapIcon:SetFrameStrata('MEDIUM')
        minimapIcon:SetHighlightTexture('Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight')
        minimapIcon:SetScript('OnMouseDown', function (component, button)
            self:onMouseDown(button)
        end)
        minimapIcon:SetScript('OnUpdate', function()
            if self.isDragging and self:shouldMove() then
                self:onDrag()
            end
        end)
        minimapIcon:SetSize(31, 31)
        return minimapIcon
    end

    --[[--
    Creates an icon overlay for the minimap icon.

    @treturn table The minimap icon overlay texture created by CreateTexture
    ]]
    function MinimapIcon:createIconOverlay()
        local overlay = self.minimapIcon:CreateTexture(nil, 'OVERLAY')
        overlay:SetTexture('Interface\\Minimap\\MiniMap-TrackingBorder')
        overlay:SetSize(53, 53)
        overlay:SetPoint('TOPLEFT')
        return overlay
    end

    --[[--
    Creates and sets up the minimap icon texture, which is equivalent to saying that
    it creates the minimap icon itself.

    @treturn table The minimap icon texture created by CreateTexture
    ]]
    function MinimapIcon:createIconTexture()
        local iconTexture = self.minimapIcon:CreateTexture(nil, 'BACKGROUND')
        iconTexture:SetTexture(self.icon)
        iconTexture:SetSize(20, 20)
        iconTexture:SetPoint('CENTER', self.minimapIcon, 'CENTER')
        return iconTexture
    end

    --[[--
    Gets a minimap icon property using the library configuration instance.

    This method is used internally by the library to persist state. It's not meant
    to be called by addons.

    @local

    @tparam string key The property key

    @treturn any The property value
    ]]
    function MinimapIcon:getProperty(key)
        return self:config(self:getPropertyKey(key))
    end

    --[[--
    Gets the property key used by the minimap icon instance to persist its state
    using the library configuration instance.

    A property key is a result of the concatenation of a static prefix, this
    instance's id, and the key parameter.

    This method is used internally by the library to persist state. It's not meant
    to be called by addons.

    @local

    @tparam string key The property key

    @treturn string The property key used by the minimap icon instance to persist
                    its state using the library configuration instance
    ]]
    function MinimapIcon:getPropertyKey(key)
        return 'minimapIcon.' .. self.id .. '.' .. key
    end

    --[[--
    Hides the minimap icon.
    ]]
    function MinimapIcon:hide()
        self.minimapIcon:Hide()
    end

    --[[
    Determines whether the cursor is over the minimap icon.

    @treturn boolean Whether the cursor is over the minimap icon
    ]]
    function MinimapIcon:isCursorOver()
        -- gets the minimap icon effective scale
        local scale = self.minimapIcon:GetEffectiveScale()

        -- gets the minimap icon width and height based on the scale
        local width, height = self.minimapIcon:GetWidth() * scale, self.minimapIcon:GetHeight() * scale
        
        -- gets the cursor position using the World of Warcraft API
        local cx, cy = GetCursorPosition()

        -- gets the minimap icon position based on the scale
        local lx, ly = self.minimapIcon:GetLeft() * scale, self.minimapIcon:GetBottom() * scale
    
        -- checks if the cursor is over the minimap icon based on the boundaries
        return cx >= lx and cx <= lx + width and cy >= ly and cy <= ly + height
    end

    --[[--
    Determines if the minimap icon is persisting its state.

    A minimap icon is considered to be persisting its state if the library is
    created with a configuration set.

    @treturn boolean true if the minimap icon is persisting its state, false otherwise
    ]]
    function MinimapIcon:isPersistingState()
        return self.__:isConfigEnabled()
    end

    --[[--
    Executes when the minimap icon is being dragged for repositioning.

    @NOTE: It appears that math.atan2() is deprecated in environments with Lua 5.4,
           however, it's kept here considering that World of Warcraft doesn't use
           the latest Lua version. However, it's important to keep an eye on this
           method in the future.
    ]]
    function MinimapIcon:onDrag()
        local xpos, ypos = GetCursorPosition()
        local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom()
        local scale = UIParent:GetScale()

        xpos = xpos / scale - xmin - 70
        ypos = ypos / scale - ymin - 70

        local angle = math.atan2(ypos, xpos)

        self:updatePosition(angle)
    end

    --[[--
    Executes when the mouse enters the minimap icon.
    ]]
    function MinimapIcon:onEnter()
        -- @TODO: Implement in MI10 <2024.08.14>
    end

    --[[--
    Executes when the mouse leaves the minimap icon.
    ]]
    function MinimapIcon:onLeave()
        -- @TODO: Implement in MI11 <2024.08.14>
    end

    --[[--
    Executes when the mouse is pressed down on the minimap icon.
    ]]
    function MinimapIcon:onMouseDown(button)
        if button == 'LeftButton' and self:shouldMove() then
            self.isDragging = true
            GameTooltip:Hide()
        end
    end

    --[[--
    Executes when the mouse is released on the minimap icon.
    ]]
    function MinimapIcon:onMouseUp()
        -- @TODO: Implement in MI9 <2024.08.14>
    end

    --[[--
    Sets the minimap icon angle position on creation.

    This method is called when the minimap icon is created, and it sets the angle
    position to the first position set by the developer or the persisted
    position if it's found.

    This method shouldn't be called directly. It's considered a complement
    to the create() method.

    @local
    ]]
    function MinimapIcon:setAnglePositionOnCreation()
        local angle = self.firstAnglePosition or 225

        if self:isPersistingState() then
            angle = self:getProperty('anglePosition') or angle
        end

        self:updatePosition(angle)
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
    Sets a minimap icon property using the library configuration instance.

    This method is used internally by the library to persist  state. It's not meant
    to be called by addons.

    @local
    
    @tparam string key The property key
    @param any value The property value
    ]]
    function MinimapIcon:setProperty(key, value)
        self:config({
            [self:getPropertyKey(key)] = value
        })
    end

    --[[--
    Sets a minimap icon state property if it's persisting its state.

    This method is used internally by the library to persist  state. It's not meant
    to be called by addons.

    @local
    
    @tparam string key The property key
    @param any value The property value
    ]]
    function MinimapIcon:setPropertyIfPersistingState(key, value)
        if self:isPersistingState() then
            self:setProperty(key, value)
        end
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

    --[[--
    Sets the minimap icon visibility.

    This is the method to be called by addons to show or hide the minimap icon,
    instead of the local show() and hide(), considering that it not only controls
    the minimap icon visibility but also persists the state if persistence is
    enabled.

    @tparam boolean visible The visibility state

    @treturn Views.MinimapIcon The minimap icon instance, for method chaining
    --]]
    function MinimapIcon:setVisibility(visible)
        self.visible = visible

        if visible then self:show() else self:hide() end

        if self:isPersistingState() then self:setProperty('visibility', visible) end

        return self
    end

    --[[--
    Sets the minimap icon visibility on creation.

    This method is called when the minimap icon is created, and it sets the
    visibility to true (default) or the persisted state if it's found.

    This method shouldn't be called directly. It's considered a complement
    to the create() method.

    @local
    ]]
    function MinimapIcon:setVisibilityOnCreation()
        local visibility = true

        if self:isPersistingState() then
            local storedVisibility = self:getProperty('visibility')

            -- these conditionals are necessary so Lua doesn't consider falsy values
            -- as false, but as nil
            if storedVisibility ~= nil then
                visibility = self.__.bool:isTrue(storedVisibility)
            end
        end

        self:setVisibility(visibility)
    end

    --[[--
    Determines whether the minimap icon should move instead of being clicked.

    @treturn boolean Whether the minimap icon should move
    ]]
    function MinimapIcon:shouldMove()
        return IsShiftKeyDown()
    end

    --[[--
    Shows the minimap icon.
    ]]
    function MinimapIcon:show()
        self.minimapIcon:Show()
    end

    --[[--
    Calculates the minimap icon position based on the angle.

    When updating the position, the angle position will also be persisted if this
    instance is persisting its state. That guarantees that the icon will be in the
    same position when the player logs in again.

    @treturn Views.MinimapIcon The minimap icon instance, for method chaining
    ]]
    function MinimapIcon:updatePosition(angle)
        -- distance from the center of the minimap
        local radius = 80
        local x = math.cos(angle) * radius
        local y = math.sin(angle) * radius

        self.minimapIcon:SetPoint('CENTER', Minimap, 'CENTER', x, y)

        self:setPropertyIfPersistingState('anglePosition', angle)

        return self
    end
-- end of MinimapIcon