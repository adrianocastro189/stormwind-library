--[[--
The Events class is a layer between World of Warcraft events and events
triggered by the Stormwind Library.

When using this library in an addon, it should focus on listening to the
library events, which are more detailed and have more mapped parameters.

@classmod Facades.Events
]]
local Events = {}
    Events.__index = Events
    Events.__ = self
    self:addClass('Events', Events)

    --[[--
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

    --[[--
    Creates the events frame, which will be responsible for capturing
    all World of Warcraft events and forwarding them to the library
    handlers.

    @local
    ]]
    function Events:createFrame()
        self.eventsFrame = CreateFrame('Frame')
        self.eventsFrame:SetScript('OnEvent', function (source, event, ...)
            self:handleOriginal(source, event, ...)
        end)
    end

    --[[--
    This is the main event handler method, which will capture all
    subscribed World of Warcraft events and forwards them to the library
    handlers that will later notify other subscribers.

    It's important to mention that addons shouldn't care about this
    method, which is an internal method to the Events class.

    @tparam table source The Events instance, used when calling Events.handleOriginal
    @tparam string event The World of Warcraft event to be handled
    @param ... The parameters passed by the World of Warcraft event
    ]]
    function Events:handleOriginal(source, event, ...)
        local callback = self.originalListeners[event]

        if callback then
            callback(...)
        end
    end

    --[[--
    Listens to a Stormwind Library event.

    This method is used by addons to listen to the library events.

    @tparam string event The Stormwind Library event to listen to
    @tparam function callback The callback to be called when the event is triggered
    ]]
    function Events:listen(event, callback)
        -- initializes the event listeners array, if not already initialized
        self.__.arr:maybeInitialize(self.listeners, event, {})

        table.insert(self.listeners[event], callback)
    end

    --[[--
    Sets the Events Frame to listen to a specific event and also store the
    handler callback to be called when the event is triggered.

    It's important to mention that addons shouldn't care about this
    method, which is an internal method to the Events class.

    @tparam string event The World of Warcraft event to listen to
    @tparam function callback The callback to be called when the event is triggered
    ]]
    function Events:listenOriginal(event, callback)
        self.eventsFrame:RegisterEvent(event)
        self.originalListeners[event] = callback
    end

    --[[--
    Notifies all listeners of a specific event.

    This method should be called by event handlers to notify all listeners
    of a specific Stormwind Library event.

    @tparam string event The Stormwind Library event to notify
    @param ... The parameters to be passed to the event listeners
    ]]
    function Events:notify(event, ...)
        local params = {...}

        local listeners = self.__.arr:get(self.listeners, event, {})

        self.__.arr:map(listeners, function (listener)
            listener(self.__.arr:unpack(params))
        end)
    end
-- end of Events

self.events = self:new('Events')