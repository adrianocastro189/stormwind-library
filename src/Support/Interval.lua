--[[--
The Interval class is a utility class that is capable of executing a given
function at a specified interval.

It uses the World of Warcraft API ticker in the background to mimic the
setInterval() function in JavaScript. And different from other support
classes, Interval is an instance based class, which means it requires one
instance per interval, allowing multiple intervals to be run at the same time.

@classmod Support.Interval
]]
local Interval = {}
    Interval.__index = Interval
    Interval.__ = self
    self:addClass('Interval', Interval)

    --[[--
    Interval constructor.
    ]]
    function Interval.__construct()
        return setmetatable({}, Interval)
    end

    --[[--
    Sets the callback to be executed at each interval.

    @tparam function value the callback to be executed at each interval

    @treturn Support.Interval self
    ]]
    function Interval:setCallback(value)
        self.callback = value
        return self
    end

    --[[--
    Sets the number of seconds between each interval.

    @tparam integer value the number of seconds between each interval

    @treturn Support.Interval self
    ]]
    function Interval:setSeconds(value)
        self.seconds = value
        return self
    end

    --[[--
    Starts the interval.

    @treturn Support.Interval self
    ]]
    function Interval:start()
        self.ticker = C_Timer.NewTicker(self.seconds, self.callback)
        return self
    end
-- end of Interval