--[[
The MethodSpy class is a helper class that allows the creation of spies for
class methods. Spies are used to assert that a method was called with the
expected arguments, how many times it was called, and to simulate the method
behavior without actually calling the original method.

Although not a good design, this class is right now fully attached to the luaunit
library, which is a testing framework for Lua. It's not a good design because it
makes the class tightly coupled to the testing framework, however, considering that
all assertions are encapsulated here, we can easily decouple it from luaunit in
the future if needed.
]]
MethodSpy = {}
MethodSpy.__index = MethodSpy

--[[
Creates a new instance of MethodSpy.

This constructor accepts a name that acts as a unique identifier for the spy. It's
important when a spy or mock class may manage multiple method spies at once,
behaving as a real instance of the class being spied.

@tparam string name

@treturn MethodSpy
]]
function MethodSpy.new(name)
    local self = setmetatable({}, MethodSpy)
    self.args = {}
    self.count = 0
    self.name = name
    return self
end

--[[
Adds a call to the method spy.

Adding a call tells the spy that the method was called and what arguments were
passed to it. This information is useful for asserting the method was called
with the expected arguments one or more times.
]]
function MethodSpy:addCall(args)
    self.count = self.count + 1
    self.args[self.count] = args or {}
    return self
end

--[[
Asserts that the method was called at least an expected number of times.

@return self
]]
function MethodSpy:assertCalledAtLeastNTimes(times)
    lu.assertTrue(times <= self.count, string.format('Method "%s" was expected to be called at least %d time(s), but it was called %d time(s) only', self.name, times, self.count))
    return self
end

--[[
Asserts that the method was called with the expected arguments in the nth time.

@return self
]]
function MethodSpy:assertCalledNthTimeWith(nth, ...)
    self:assertCalledAtLeastNTimes(nth)

    local args = self.args[nth]
    lu.assertEquals({...}, args, string.format('Method "%s" call #%d does not match the expected arguments', self.name, nth))
    return self
end

--[[ 
Asserts that the method was called a specific number of times.

@return self
]]
function MethodSpy:assertCalledNTimes(times)
    lu.assertEquals(times, self.count, string.format('Method "%s" was expected to be called %d time(s), but it was called %d time(s)', self.name, times, self.count))
    return self
end

--[[
Asserts that the method spied was called only once.

@return self
]]
function MethodSpy:assertCalledOnce()
    return self:assertCalledNTimes(1)
end

--[[
Asserts that the method was called only once with the expected arguments.

@return self
]]
function MethodSpy:assertCalledOnceWith(...)
    self:assertCalledOnce()
    return self:assertCalledNthTimeWith(1, ...)
end

--[[
Asserts that the method was called at least once or not called at all based on a
flag.

The flag should be a boolean value that indicates if the method was expected to be
called or not.

@tparam boolean calledOrNot

@return self
]]
function MethodSpy:assertCalledOrNot(calledOrNot)
    return calledOrNot and self:assertCalledAtLeastNTimes(1) or self:assertNotCalled()
end

--[[
Asserts that the method was not called.

@return self
]]
function MethodSpy:assertNotCalled()
    lu.assertEquals(0, self.count, string.format('Method "%s" was not expected to be called, but it was called %d time(s)', self.name, self.count))
    return self
end

--[[
Sets the spy body, which is the function that will be executed when the method
is called.

When passing a body to a method spy instance, whenever the method is called, the
body will also be executed and its return value will be the return value of the
method call.

It allows the spy to simulate the method behavior without actually calling the
original method plus the ability to assert the method was called with the
expected arguments.

@tparam function body

@return self
]]
function MethodSpy:setBody(body)
    self.body = body
    return self
end

Spy = {}

--[[
Creates a new instance of Spy.

Spy expects a mocked object to be passed as an argument. The mocked object is the
object that will have its methods spied.
]]
function Spy.new(mockedObject)
    mockedObject = (type(mockedObject) == 'table') and mockedObject or {}

    return setmetatable({
        --[[ Gets a method spy for the given method name, or nil if the method is not spied ]]
        getMethod = function (self, method)
            return self.methodsSpies[method]
        end,
        --[[ A list of MethodSpy instances, one for each method being spied ]]
        methodsSpies = {},
        --[[ Mocks a method of the mocked object ]]
        mockMethod = function (self, method, body)
            body = body or function () end
            self.methodsSpies[method] = MethodSpy.new(method):setBody(body)
            -- the flag below is used to determine if the method was mocked
            self.mockedObject[method] = '__mocked'
            return self
        end,
        --[[ The object being mocked (or spied) ]]
        mockedObject = mockedObject,
    }, Spy)
end

--[[
The Spy.__index function is used to implement the behavior of indexing a Spy
instance.

It checks if the method being accessed is mocked or not. If it is not mocked, the
original method is returned. But if the method is mocked, it adds a call to the
method spy and executes the body of the spy if it exists.

@NOTE: Due to how this method is implemented, functions that are saved as properties
       cannot be mocked as a "class method". Example: a class has a callback
       stored as a property, and the callback is called inside a method. It's not
       possible to mock the callback and expect that Spy will create a method spy
       for it as it won't have the same behavior as a class method, so the "_"
       parameter in this return function won't be the instance of the class.
]]
function Spy.__index(instance, method)
    if instance.mockedObject[method] ~= '__mocked' then
        -- when not mocked, the original method is returned
        return instance.mockedObject[method]
    end

    return function (_, ...)
        local methodSpy = _.methodsSpies[method]
        methodSpy:addCall({...})
        if methodSpy.body then
            return methodSpy.body(_, ...)
        end
    end
end