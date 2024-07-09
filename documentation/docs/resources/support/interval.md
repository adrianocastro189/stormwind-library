# Interval

The Interval class was inspired by the JavaScript `setInterval()` function,
which is responsible for executing a callback function at a specified interval.

In this Lua version for World of Warcraft addons, it works in a similar way,
but with an oriented object approach. That said, an instance of the Interval
class is created by settings its properties and calling the `start()` method
to start the interval and `stop()` to stop it.

It uses the World of Warcraft API in its background, more specifically the
`C_Timer` table and the `NewTicker()` function. However, addons don't need to
worry about how it works internally, just use the exposed methods.

## Usage

The example above creates an interval that will print _Hello, World of Warcraft!_ every 5 seconds.

```lua
local interval = library:new('Interval')

interval
    :setSeconds(5)
    :setCallback(function()
        print('Hello, World of Warcraft!')
    end)
    :start()
```

Later when the interval must be stopped, just call the `stop()` method on the
same instance.

```lua
interval:stop()
```

## Notes

* Multiple intervals can be created and started at the same time
* Make sure to save the instance variable to stop the interval later, if 
necessary, of course

:::warning The first execution

The first execution of the callback function will occur after the interval
time has passed. For example, if the interval is set to 5 seconds, the first
execution will occur after 5 seconds, not immediately after calling the
`start()` method.

:::