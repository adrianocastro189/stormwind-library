-- list of callbacks to be invoked when the library is loaded
self.loadCallbacks = {}

--[[
Removes the callback loader and its properties.
]]
function self:destroyCallbackLoader()
    self.destroyCallbackLoader = nil
    self.invokeLoadCallbacks = nil
    self.loadCallbacks = nil
    self.onLoad = nil
end

--[[
Invokes all the callbacks that have been enqueued.
]]
function self:invokeLoadCallbacks()
    self.arr:each(self.loadCallbacks, function(callback)
        callback()
    end)

    self:destroyCallbackLoader()
end

--[[
Enqueues a callback function to be invoked when the library is loaded.

@tparam function callback The callback function to be invoked when the library is loaded
]]
function self:onLoad(callback)
    table.insert(self.loadCallbacks, callback)
end

-- invokes a local callback that won't be invoked in game
-- for testing purposes only
self:onLoad(function()
    if not self.environment:inGame() then
        self.callbacksInvoked = true
    end
end)