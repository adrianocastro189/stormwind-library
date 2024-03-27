--[[
The Events class is a layer between World of Warcraft events and events
triggered by the Stormwind Library.

When using this library in an addon, it should focus on listening to the
library events, which are more detailed and have more mapped parameters.
]]
local Events = {}
    Events.__index = Events
    Events.__ = self
    self:addClass('Events', Events)

    --[[
    Events constructor.
    ]]
    function Events.__construct()
        local self = setmetatable({}, Events)

        -- a set of properties to store the current state of the events
        self.eventStates = {}

        -- the list of addon listeners to Stormwind Library events
        self.listeners = {}

        -- the list of library listeners to World of Warcraft events
        self.originalListeners = {}

        self:createFrame()

        return self
    end

    --[[
    Creates the events frame, which will be responsible for capturing
    all World of Warcraft events and forwarding them to the library
    handlers.
    ]]
    function Events:createFrame()
        self.eventsFrame = CreateFrame('Frame')
        self.eventsFrame:SetScript('OnEvent', function (source, event, ...)
            self:handleOriginal(source, event, ...)
        end)
    end

    --[[
    This is the main event handler method, which will capture all
    subscribed World of Warcraft events and forwards them to the library
    handlers that will later notify other subscribers.

    It's important to mention that addons shouldn't care about this
    method, which is an internal method to the Events class.
    ]]
    function Events:handleOriginal(source, event, ...)
        local callback = self.originalListeners[event]

        if callback then
            callback(...)
        end
    end
-- end of Events

self.events = self:new('Events')