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
Asserts that the method spied was called only once.

@return self
]]
function MethodSpy:assertCalledOnce()
    lu.assertEquals(1, self.count, string.format('Method "%s" was not called once', self.name))
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