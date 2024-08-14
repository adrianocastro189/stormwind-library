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
    :setExecution(function()
        -- @TODO: Implement in MI4 <2024.08.14>
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

-- @covers MinimapIcon:hide()
TestCase.new()
    :setName('hide')
    :setTestClass(TestMinimapIcon)
    :setExecution(function()
        -- @TODO: Implement in MI2 <2024.08.14>
    end)
    :register()

-- @covers MinimapIcon:isCursorOver()
TestCase.new()
    :setName('isCursorOver')
    :setTestClass(TestMinimapIcon)
    :setExecution(function()
        -- @TODO: Implement in MI6 <2024.08.14>
    end)
    :register()

-- @covers MinimapIcon:onDrag()
TestCase.new()
    :setName('onDrag')
    :setTestClass(TestMinimapIcon)
    :setExecution(function()
        -- @TODO: Implement in MI7 <2024.08.14>
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
    :setExecution(function()
        -- @TODO: Implement in MI8 <2024.08.14>
    end)
    :register()

-- @covers MinimapIcon:onMouseUp()
TestCase.new()
    :setName('onMouseUp')
    :setTestClass(TestMinimapIcon)
    :setExecution(function()
        -- @TODO: Implement in MI9 <2024.08.14>
    end)
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

-- @covers MinimapIcon:show()
TestCase.new()
    :setName('show')
    :setTestClass(TestMinimapIcon)
    :setExecution(function()
        -- @TODO: Implement in MI2 <2024.08.14>
    end)
    :register()

-- @covers MinimapIcon:setAnglePosition()
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
        ['setAnglePosition'] = {
            setter = 'setAnglePosition',
            property = 'anglePosition',
            value = 85.5,
        },
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
        -- @TODO: Implement in MI2 <2024.08.14>
    end)
    :register()

-- @covers MinimapIcon:updatePosition()
TestCase.new()
    :setName('updatePosition')
    :setTestClass(TestMinimapIcon)
    :setExecution(function()
        -- @TODO: Implement in MI5 <2024.08.14>
    end)
    :register()
-- end of TestMinimapIcon