TestWindowPage = BaseTestClass:new()
    -- @covers WindowPage:__construct()
    function TestWindowPage:testConstruct()
        local instance = __:new('WindowPage', 'test-id')

        lu.assertNotIsNil(instance)
        lu.assertIsNil(instance.contentFrame)
        lu.assertEquals('test-id', instance.pageId)
    end

    -- @covers WindowPage:create()
    function TestWindowPage:testCreate()
        local instance = __:new('WindowPage', 'test-id')
        local createFrameInvokeCount = 0

        instance.createFrame = function()
            createFrameInvokeCount = createFrameInvokeCount + 1
            return {'test-frame'}
        end

        local result = instance:create()

        lu.assertEquals(instance, result)

        -- ensures that the page frame is cached and won't be created again
        result = instance:create()

        lu.assertEquals(instance, result)
        lu.assertEquals(1, createFrameInvokeCount)
        lu.assertNotIsNil(instance.contentFrame)
    end

    -- @covers WindowPage:createFrame()
    function TestWindowPage:testCreateFrame()
        local instance = __:new('WindowPage', 'test-id')
        local result = instance:createFrame()

        lu.assertNotIsNil(result)
    end

    -- @covers WindowPage:positionContentChildFrames()
    function TestWindowPage:testPositionContentChildFrames()
        local contentFrameHeight, pointsA, pointsB = nil, {}, {}

        local childFrameA = {
            GetHeight = function() return 10 end,
            SetParent = function(self, parent) self.parent = parent end,
            SetPoint = function(self, ...) table.insert(pointsA, {...}) end
        }
        local childFrameB = {
            GetHeight = function() return 20 end,
            SetParent = function(self, parent) self.parent = parent end,
            SetPoint = function(self, ...) table.insert(pointsB, {...}) end
        }

        local instance = __:new('WindowPage')
        instance.contentFrame = {
            SetHeight = function(self, height) contentFrameHeight = height end,
        }
        instance.contentChildren = {childFrameA, childFrameB}

        instance:positionContentChildFrames()

        lu.assertEquals(30, contentFrameHeight)
        lu.assertEquals({'TOPLEFT', instance.contentFrame, 'TOPLEFT', 0, 0}, pointsA[1])
        lu.assertEquals({'TOPRIGHT', instance.contentFrame, 'TOPRIGHT', 0, 0}, pointsA[2])
        lu.assertEquals({'TOPLEFT', childFrameA, 'BOTTOMLEFT', 0, 0}, pointsB[1])
        lu.assertEquals({'TOPRIGHT', childFrameA, 'BOTTOMRIGHT', 0, 0}, pointsB[2])
        lu.assertEquals(instance.contentFrame, childFrameA.parent)
    end

    -- @covers WindowPage:setContent()
    function TestWindowPage:testSetContent()
        local function execution(contentFrame, shouldCallPositionChildFrames)
            local positionContentChildFramesInvoked = false

            local instance = __:new('WindowPage')
            instance.contentFrame = contentFrame
            instance.positionContentChildFrames = function() positionContentChildFramesInvoked = true end
    
            local result = instance:setContent({'test-content'})
    
            lu.assertEquals(shouldCallPositionChildFrames, positionContentChildFramesInvoked)
            lu.assertEquals({'test-content'}, instance.contentChildren)
            lu.assertEquals(instance, result)
        end

        execution(nil, false)
        execution({'test-content-frame'}, true)
    end
-- end of TestWindowPage