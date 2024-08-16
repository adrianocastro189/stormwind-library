TestMinimapIcon = BaseTestClass:new()

-- @covers MinimapIcon:__construct()
TestCase.new()
    :setName('__construct')
    :setTestClass(TestMinimapIcon)
    :setExecution(function(data)
        local instance = __:new('MinimapIcon', data.id)
        lu.assertNotNil(instance)
        lu.assertEquals(data.expectedId, instance.id)
        lu.assertIsFalse(instance.isDragging)
        lu.assertIsFalse(instance.persistStateByPlayer)
    end)
    :setScenarios({
        ['no id provided'] = {
            id = nil,
            expectedId = 'default'
        },
        ['id provided'] = {
            id = 'test-id',
            expectedId = 'test-id'
        },
    })
    :register()

-- @covers MinimapIcon:config()
TestCase.new()
    :setName('config')
    :setTestClass(TestMinimapIcon)
    :setExecution(function(data)
        local instance = __:new('MinimapIcon')
        instance.persistStateByPlayer = data.persistStateByPlayer

        instance.__ = Spy.new(__)
            :mockMethod('config', function () return 'config' end)
            :mockMethod('playerConfig', function () return 'playerConfig' end)

        local result = instance:config('test-arg-1', 'test-arg-2')

        lu.assertEquals(data.expectedMethod, result)

        instance.__:getMethod(data.expected):assertCalledOnceWith('test-arg-1', 'test-arg-2')
    end)
    :setScenarios({
        ['persistStateByPlayer is false'] = {
            persistStateByPlayer = false,
            expected = 'config',
            expectedMethod = 'config',
        },
        ['persistStateByPlayer is true'] = {
            persistStateByPlayer = true,
            expected = 'playerConfig',
            expectedMethod = 'playerConfig',
        },
    })
    :register()

-- @covers MinimapIcon:create()
TestCase.new()
    :setName('create')
    :setTestClass(TestMinimapIcon)
    :setExecution(function(data)
        local instance = Spy
            .new(__:new('MinimapIcon'))
            :mockMethod('createIconFrame', function () return 'created-icon-frame' end)
            :mockMethod('createIconTexture')
            :mockMethod('createIconOverlay')
            :mockMethod('setAnglePositionOnCreation')
            :mockMethod('setVisibilityOnCreation')

        instance.minimapIcon = data.minimapIcon

        instance:create()

        lu.assertEquals(data.expectedMinimapIcon, instance.minimapIcon)

        instance:getMethod('createIconFrame'):assertCalledOrNot(data.localMethodsCalled)
        instance:getMethod('createIconTexture'):assertCalledOrNot(data.localMethodsCalled)
        instance:getMethod('createIconOverlay'):assertCalledOrNot(data.localMethodsCalled)
        instance:getMethod('setAnglePositionOnCreation'):assertCalledOrNot(data.localMethodsCalled)
        instance:getMethod('setVisibilityOnCreation'):assertCalledOrNot(data.localMethodsCalled)
    end)
    :setScenarios({
        ['minimapIcon exists'] = {
            minimapIcon = 'minimap-icon',
            expectedMinimapIcon = 'minimap-icon',
            localMethodsCalled = false,
        },
        ['minimapIcon does not exist'] = {
            minimapIcon = nil,
            expectedMinimapIcon = 'created-icon-frame',
            localMethodsCalled = true,
        },
    })
    :register()

-- @covers MinimapIcon:createIconFrame()
TestCase.new()
    :setName('createIconFrame')
    :setTestClass(TestMinimapIcon)
    :setExecution(function ()
        local instance = __:new('MinimapIcon')

        local frameSpy = Spy
            .new({})
            :mockMethod('RegisterForClicks')
            :mockMethod('SetScript')
            :mockMethod('SetFrameLevel')
            :mockMethod('SetFrameStrata')
            :mockMethod('SetHighlightTexture')
            :mockMethod('SetSize')

        CreateFrame = function () return frameSpy end

        local result = instance:createIconFrame()

        lu.assertEquals(frameSpy, result)

        frameSpy:getMethod('RegisterForClicks'):assertCalledOnceWith('AnyUp')
        frameSpy:getMethod('SetScript'):assertCalledNTimes(3)
        frameSpy:getMethod('SetFrameLevel'):assertCalledOnceWith(8)
        frameSpy:getMethod('SetFrameStrata'):assertCalledOnceWith('MEDIUM')
        frameSpy:getMethod('SetHighlightTexture'):assertCalledOnceWith('Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight')
        frameSpy:getMethod('SetSize'):assertCalledOnceWith(31, 31)
    end)
    :register()

-- @covers MinimapIcon:createIconOverlay()
TestCase.new()
    :setName('createIconOverlay')
    :setTestClass(TestMinimapIcon)
    :setExecution(function ()
        local instance = __:new('MinimapIcon')

        local textureSpy = Spy
            .new({})
            :mockMethod('SetTexture')
            :mockMethod('SetSize')
            :mockMethod('SetPoint')

        instance.minimapIcon = Spy
            .new({})
            :mockMethod('CreateTexture', function () return textureSpy end)

        local result = instance:createIconOverlay()

        lu.assertEquals(textureSpy, result)

        textureSpy:getMethod('SetTexture'):assertCalledOnceWith('Interface\\Minimap\\MiniMap-TrackingBorder')
        textureSpy:getMethod('SetSize'):assertCalledOnceWith(53, 53)
        textureSpy:getMethod('SetPoint'):assertCalledOnceWith('TOPLEFT')
    end)
    :register()

-- @covers MinimapIcon:createIconTexture()
TestCase.new()
    :setName('createIconTexture')
    :setTestClass(TestMinimapIcon)
    :setExecution(function ()
        local instance = __
            :new('MinimapIcon')
            :setIcon('icon')

        local textureSpy = Spy
            .new({})
            :mockMethod('SetTexture')
            :mockMethod('SetSize')
            :mockMethod('SetPoint')

        instance.minimapIcon = Spy
            .new({})
            :mockMethod('CreateTexture', function () return textureSpy end)

        local result = instance:createIconTexture()

        lu.assertEquals(textureSpy, result)

        textureSpy:getMethod('SetTexture'):assertCalledOnceWith('icon')
        textureSpy:getMethod('SetSize'):assertCalledOnceWith(20, 20)
        textureSpy:getMethod('SetPoint'):assertCalledOnceWith('CENTER', instance.minimapIcon, 'CENTER')
    end)
    :register()

-- @covers MinimapIcon:getProperty()
TestCase.new()
    :setName('getProperty')
    :setTestClass(TestMinimapIcon)
    :setExecution(function()
        local instance = Spy.new(__:new('MinimapIcon'))
            :mockMethod('config', function () return 'test-config' end)
            :mockMethod('getPropertyKey', function () return 'test-property-key' end)

        lu.assertEquals('test-config', instance:getProperty('test-key'))

        instance:getMethod('config'):assertCalledOnceWith('test-property-key')
        instance:getMethod('getPropertyKey'):assertCalledOnceWith('test-key')
    end)
    :register()

-- @covers MinimapIcon:getPropertyKey()
TestCase.new()
    :setName('getPropertyKey')
    :setTestClass(TestMinimapIcon)
    :setExecution(function()
        local instance = __:new('MinimapIcon')

        lu.assertEquals('minimapIcon.default.test-key', instance:getPropertyKey('test-key'))
    end)
    :register()

-- @covers MinimapIcon:getTooltipLines()
TestCase.new()
    :setName('getTooltipLines')
    :setTestClass(TestMinimapIcon)
    :setExecution(function(data)
        local instance = __:new('MinimapIcon')

        instance.tooltipLines = data.tooltipLines

        lu.assertEquals(data.expected, instance:getTooltipLines())
    end)
    :setScenarios({
        ['tooltip lines exist'] = {
            tooltipLines = {'line-1', 'line-2'},
            expected = {'line-1', 'line-2'},
        },
        ['tooltip lines do not exist'] = {
            tooltipLines = nil,
            expected = {
                'TestSuite',
                'Hold SHIFT and drag with the left mouse button to move this icon',
            },
        },
    })
    :register()

-- @covers MinimapIcon:hide()
-- @covers MinimapIcon:show()
TestCase.new()
    :setName('hide and show')
    :setTestClass(TestMinimapIcon)
    :setExecution(function(data)
        local instance = __:new('MinimapIcon')

        instance.minimapIcon = Spy
            .new({})
            :mockMethod('Hide')
            :mockMethod('Show')

        instance[data.method](instance)

        instance.minimapIcon:getMethod(data.expected):assertCalledOnce()
    end)
    :setScenarios({
        ['hide'] = {
            method = 'hide',
            expected = 'Hide',
        },
        ['show'] = {
            method = 'show',
            expected = 'Show',
        },
    })
    :register()

-- @covers MinimapIcon:isCursorOver()
TestCase.new()
    :setName('isCursorOver')
    :setTestClass(TestMinimapIcon)
    :setExecution(function(data)
        local instance = __:new('MinimapIcon')

        instance.minimapIcon = Spy
            .new({})
            :mockMethod('GetBottom', function () return data.minimapBottom end)
            :mockMethod('GetEffectiveScale', function () return 1.0 end)
            :mockMethod('GetHeight', function () return data.height end)
            :mockMethod('GetLeft', function () return data.left end)
            :mockMethod('GetWidth', function () return data.width end)
            
        _G['GetCursorPosition'] = function () return data.cursorX, data.cursorY end

        lu.assertEquals(data.expected, instance:isCursorOver())
    end)
    :setScenarios({
        ['cursor is over'] = {
            cursorX = 0,
            cursorY = 0,
            height = 31,
            left = 0,
            minimapBottom = 0,
            width = 31,
            expected = true,
        },
        ['cursor is not over'] = {
            cursorX = 100,
            cursorY = 100,
            height = 31,
            left = 0,
            minimapBottom = 0,
            width = 31,
            expected = false,
        },
    })
    :register()

-- @covers MinimapIcon:isPersistingState()
TestCase.new()
    :setName('isPersistingState')
    :setTestClass(TestMinimapIcon)
    :setExecution(function()
        local instance = __:new('MinimapIcon')
        
        instance.__ = Spy
            .new(__)
            :mockMethod('isConfigEnabled', function () return true end)
                
        lu.assertIsTrue(instance:isPersistingState())
    end)
    :register()

-- @covers MinimapIcon:maybeInvokeCallbacks()
TestCase.new()
    :setName('maybeInvokeCallbacks')
    :setTestClass(TestMinimapIcon)
    :setExecution(function(data)
        local instance = Spy
            .new(__:new('MinimapIcon'))
            :mockMethod('isCursorOver', function () return data.isCursorOver end)
        
        instance.callbackOnLeftClickInvoked = false
        instance.callbackOnRightClickInvoked = false
        instance.callbackOnLeftClick = function () instance.callbackOnLeftClickInvoked = true end
        instance.callbackOnRightClick = function () instance.callbackOnRightClickInvoked = true end

        instance:maybeInvokeCallbacks(data.button)

        lu.assertEquals(data.expectedCallbackOnLeftClickInvoked, instance.callbackOnLeftClickInvoked)
        lu.assertEquals(data.expectedCallbackOnRightClickInvoked, instance.callbackOnRightClickInvoked)
    end)
    :setScenarios({
        ['left button, cursor is not over'] = {
            button = 'LeftButton',
            isCursorOver = false,
            expectedCallbackOnLeftClickInvoked = false,
            expectedCallbackOnRightClickInvoked = false,
        },
        ['right button, cursor is not over'] = {
            button = 'RightButton',
            isCursorOver = false,
            expectedCallbackOnLeftClickInvoked = false,
            expectedCallbackOnRightClickInvoked = false,
        },
        ['left button, cursor is over'] = {
            button = 'LeftButton',
            isCursorOver = true,
            expectedCallbackOnLeftClickInvoked = true,
            expectedCallbackOnRightClickInvoked = false,
        },
        ['right button, cursor is over'] = {
            button = 'RightButton',
            isCursorOver = true,
            expectedCallbackOnLeftClickInvoked = false,
            expectedCallbackOnRightClickInvoked = true,
        },
    })
    :register()

-- @covers MinimapIcon:onDrag()
TestCase.new()
    :setName('onDrag')
    :setTestClass(TestMinimapIcon)
    :setExecution(function()
        _G['GetCursorPosition'] = function () return 10, 10 end
        _G['Minimap'] = Spy
            .new({})
            :mockMethod('GetLeft', function () return 5 end)
            :mockMethod('GetBottom', function () return 5 end)
        _G['UIParent'] = Spy
            .new({})
            :mockMethod('GetScale', function () return 1.0 end)
        
        local instance = Spy
            .new(__:new('MinimapIcon'))
            :mockMethod('updatePosition')
        
        instance:onDrag()

        -- must replicate the math.atan2 call due to imprecision when comparing with
        -- hardcoded float values
        instance:getMethod('updatePosition'):assertCalledOnceWith(math.atan2(-65, -65))
    end)
    :register()

-- @covers MinimapIcon:onEnter()
TestCase.new()
    :setName('onEnter')
    :setTestClass(TestMinimapIcon)
    :setExecution(function()
        -- @TODO: Implement in MI10 <2024.08.14>
    end)
    :register()

-- @covers MinimapIcon:onLeave()
TestCase.new()
    :setName('onLeave')
    :setTestClass(TestMinimapIcon)
    :setExecution(function()
        -- @TODO: Implement in MI11 <2024.08.14>
    end)
    :register()

-- @covers MinimapIcon:onMouseDown()
TestCase.new()
    :setName('onMouseDown')
    :setTestClass(TestMinimapIcon)
    :setExecution(function(data)
        local instance = Spy
            .new(__:new('MinimapIcon'))
            :mockMethod('shouldMove', function () return data.shouldMove end)

        _G['GameTooltip'] = Spy
            .new()
            :mockMethod('Hide')
        
        instance:onMouseDown(data.button)

        lu.assertEquals(data.expectedIsDragging, instance.isDragging)
        GameTooltip:getMethod('Hide'):assertCalledOrNot(data.expectedIsDragging)
    end)
    :setScenarios({
        ['left click, should move'] = {
            button = 'LeftButton',
            shouldMove = true,
            expectedIsDragging = true,
        },
        ['left click, should not move'] = {
            button = 'LeftButton',
            shouldMove = false,
            expectedIsDragging = false,
        },
        ['right click'] = {
            button = 'RightButton',
            shouldMove = false,
            expectedIsDragging = false,
        },
    })
    :register()

-- @covers MinimapIcon:onMouseUp()
TestCase.new()
    :setName('onMouseUp')
    :setTestClass(TestMinimapIcon)
    :setExecution(function(data)
        local instance = Spy
            .new(__:new('MinimapIcon'))
            :mockMethod('maybeInvokeCallbacks')
        
        instance.isDragging = data.isDragging

        instance:onMouseUp(data.button)

        lu.assertEquals(data.expectedIsDragging, instance.isDragging)

        if data.shouldInvokeCallbacks then
            instance:getMethod('maybeInvokeCallbacks'):assertCalledOnceWith(data.button)
            return
        end

        instance:getMethod('maybeInvokeCallbacks'):assertNotCalled()
    end)
    :setScenarios({
        ['is not dragging'] = {
            button = 'LeftButton',
            isDragging = false,
            expectedIsDragging = false,
            shouldInvokeCallbacks = true,
        },
        ['is dragging'] = {
            button = 'LeftButton',
            isDragging = true,
            expectedIsDragging = false,
            shouldInvokeCallbacks = false,
        },
    })
    :register()

-- @covers MinimapIcon:onUpdate()
TestCase.new()
    :setName('onUpdate')
    :setTestClass(TestMinimapIcon)
    :setExecution(function(data)
        local instance = Spy
            .new(__:new('MinimapIcon'))
            :mockMethod('shouldMove', function () return data.shouldMove end)
            :mockMethod('onDrag')

        instance.isDragging = data.isDragging

        instance:onUpdate()

        instance:getMethod('onDrag'):assertCalledOrNot(data.expectedOnDragCalled)
    end)
    :setScenarios({
        ['is dragging only'] = {
            isDragging = true,
            shouldMove = false,
            expectedOnDragCalled = false,
        },
        ['should move only'] = {
            isDragging = false,
            shouldMove = true,
            expectedOnDragCalled = false,
        },
        ['is dragging and should move'] = {
            isDragging = true,
            shouldMove = true,
            expectedOnDragCalled = true,
        },
        ['neither is dragging nor should move'] = {
            isDragging = false,
            shouldMove = false,
            expectedOnDragCalled = false,
        },
    })
    :register()

-- @covers MinimapIcon:setAnglePositionOnCreation()
TestCase.new()
    :setName('setAnglePositionOnCreation')
    :setTestClass(TestMinimapIcon)
    :setExecution(function(data)
        local instance = Spy
            .new(__:new('MinimapIcon'))
            :mockMethod('isPersistingState', function () return data.isPersistingState end)
            :mockMethod('getProperty', function () return data.anglePositionProperty end)
            :mockMethod('updatePosition')
        
        instance.firstAnglePosition = data.firstAnglePosition

        instance:setAnglePositionOnCreation()

        instance:getMethod('updatePosition'):assertCalledOnceWith(data.expectedAngle)
    end)
    :setScenarios({
        ['not persisting state'] = {
            isPersistingState = false,
            firstAnglePosition = 85.5,
            anglePositionProperty = 1,
            expectedAngle = 85.5,
        },
        ['not persisting state and no first position'] = {
            isPersistingState = false,
            firstAnglePosition = nil,
            anglePositionProperty = 1,
            expectedAngle = 225,
        },
        ['persisting state'] = {
            isPersistingState = true,
            firstAnglePosition = 85.5,
            anglePositionProperty = 1,
            expectedAngle = 1,
        },
        ['persisting state but state has no angle'] = {
            isPersistingState = true,
            firstAnglePosition = 85.5,
            anglePositionProperty = nil,
            expectedAngle = 85.5,
        },
    })
    :register()

-- @covers MinimapIcon:setProperty()
TestCase.new()
    :setName('setProperty')
    :setTestClass(TestMinimapIcon)
    :setExecution(function()
        local instance = Spy
            .new(__:new('MinimapIcon'))
            :mockMethod('config')
            :mockMethod('getPropertyKey', function () return 'property-key' end)

        instance:setProperty('key', 'value')

        instance:getMethod('getPropertyKey'):assertCalledOnceWith('key')
        instance:getMethod('config'):assertCalledOnceWith({['property-key'] = 'value'})
    end)
    :register()

-- @covers MinimapIcon:setPropertyIfPersistingState()
TestCase.new()
    :setName('setPropertyIfPersistingState')
    :setTestClass(TestMinimapIcon)
    :setExecution(function(data)
        local instance = Spy
            .new(__:new('MinimapIcon'))
            :mockMethod('isPersistingState', function () return data.isPersistingState end)
            :mockMethod('setProperty')

        instance:setPropertyIfPersistingState('key', 'value')

        instance:getMethod('isPersistingState'):assertCalledOnce()
        
        if data.isPersistingState then
            instance:getMethod('setProperty'):assertCalledOnceWith('key', 'value')
            return
        end
        instance:getMethod('setProperty'):assertNotCalled()
    end)
    :setScenarios({
        ['persisting state'] = {
            isPersistingState = true,
        },
        ['not persisting state'] = {
            isPersistingState = false,
        },
    })
    :register()

-- @covers MinimapIcon:setCallbackOnLeftClick()
-- @covers MinimapIcon:setCallbackOnRightClick()
-- @covers MinimapIcon:setFirstAnglePosition()
-- @covers MinimapIcon:setIcon()
-- @covers MinimapIcon:setPersistStateByPlayer()
-- @covers MinimapIcon:setTooltipLines()
TestCase.new()
    :setName('setters')
    :setTestClass(TestMinimapIcon)
    :setExecution(function(data)
        local instance = __:new('MinimapIcon')

        instance[data.setter](instance, data.value)

        lu.assertEquals(data.value, instance[data.property])
    end)
    :setScenarios({
        ['setCallbackOnLeftClick'] = {
            setter = 'setCallbackOnLeftClick',
            property = 'callbackOnLeftClick',
            value = function() print('Left click!') end,
        },
        ['setCallbackOnRightClick'] = {
            setter = 'setCallbackOnRightClick',
            property = 'callbackOnRightClick',
            value = function() print('Right click!') end,
        },
        ['setFirstAnglePosition'] = {
            setter = 'setFirstAnglePosition',
            property = 'firstAnglePosition',
            value = 85.5,
        },
        ['setIcon'] = {
            setter = 'setIcon',
            property = 'icon',
            value = 'test-icon',
        },
        ['setPersistStateByPlayer'] = {
            setter = 'setPersistStateByPlayer',
            property = 'persistStateByPlayer',
            value = true,
        },
        ['setTooltipLines'] = {
            setter = 'setTooltipLines',
            property = 'tooltipLines',
            value = {'test-line-1', 'test-line-2'},
        },
    })
    :register()

-- @covers MinimapIcon:setVisibility()
TestCase.new()
    :setName('setVisibility')
    :setTestClass(TestMinimapIcon)
    :setExecution(function(data)
        local instance = Spy
            .new(__:new('MinimapIcon'))
            :mockMethod('hide')
            :mockMethod('isPersistingState', function () return data.isPersistingState end)
            :mockMethod('setProperty')
            :mockMethod('show')
        
        local result = instance:setVisibility(data.visible)

        lu.assertEquals(instance, result)
        lu.assertEquals(data.visible, instance.visible)

        instance:getMethod('hide'):assertCalledOrNot(not data.visible)
        instance:getMethod('show'):assertCalledOrNot(data.visible)
        instance:getMethod('isPersistingState'):assertCalledOnce()

        if data.isPersistingState then
            instance:getMethod('setProperty'):assertCalledOnceWith('visibility', data.visible)
            return
        end
        
        instance:getMethod('setProperty'):assertNotCalled()
    end)
    :setScenarios({
        ['visible'] = {
            visible = true,
            isPersistingState = false,
        },
        ['not visible'] = {
            visible = false,
            isPersistingState = false,
        },
        ['visible and persisting state'] = {
            visible = true,
            isPersistingState = true,
        },
        ['not visible and persisting state'] = {
            visible = false,
            isPersistingState = true,
        },
    })
    :register()

-- @covers MinimapIcon:setVisibilityOnCreation()
TestCase.new()
    :setName('setVisibilityOnCreation')
    :setTestClass(TestMinimapIcon)
    :setExecution(function(data)
        local instance = Spy
            .new(__:new('MinimapIcon'))
            :mockMethod('isPersistingState', function () return data.isPersistingState end)
            :mockMethod('getProperty', function () return data.visibilityProperty end)
            :mockMethod('setVisibility')
        
        instance:setVisibilityOnCreation()

        instance:getMethod('setVisibility'):assertCalledOnceWith(data.expectedVisibility)
    end)
    :setScenarios({
        ['not persisting state'] = {
            isPersistingState = false,
            visibilityProperty = nil,
            expectedVisibility = true,
        },
        ['persisting state, nil state'] = {
            isPersistingState = true,
            visibilityProperty = nil,
            expectedVisibility = true,
        },
        ['persisting state, false state'] = {
            isPersistingState = true,
            visibilityProperty = false,
            expectedVisibility = false,
        },
        ['persisting state, true state'] = {
            isPersistingState = true,
            visibilityProperty = true,
            expectedVisibility = true,
        },
    })
    :register()

-- @covers MinimapIcon:shouldMove()
TestCase.new()
    :setName('shouldMove')
    :setTestClass(TestMinimapIcon)
    :setExecution(function(data)
        IsShiftKeyDown = function() return data.isShiftKeyDown end

        local instance = __:new('MinimapIcon')

        lu.assertEquals(data.isShiftKeyDown, instance:shouldMove())
    end)
    :setScenarios({
        ['shift key down'] = {
            isShiftKeyDown = true,
        },
        ['shift key up'] = {
            isShiftKeyDown = false,
        },
    })
    :register()

-- @covers MinimapIcon:updatePosition()
TestCase.new()
    :setName('updatePosition')
    :setTestClass(TestMinimapIcon)
    :setExecution(function()
        _G['Minimap'] = 'minimap'

        local instance = Spy
            .new(__:new('MinimapIcon'))
            :mockMethod('setPropertyIfPersistingState')

        instance.minimapIcon = Spy
            .new({})
            :mockMethod('SetPoint')

        local result = instance:updatePosition(90)

        lu.assertEquals(instance, result)

        instance.minimapIcon
            :getMethod('SetPoint')
            -- must replicate the math.cos and math.sin calls due to imprecision when
            -- comparing with hardcoded float values
            :assertCalledOnceWith('CENTER', Minimap, 'CENTER', math.cos(90) * 80, math.sin(90) * 80)
        
        instance:getMethod('setPropertyIfPersistingState'):assertCalledOnceWith('anglePosition', 90)
    end)
    :register()
-- end of TestMinimapIcon