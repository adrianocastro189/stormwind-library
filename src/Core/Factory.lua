--[[
Contains a list of classes that can be instantiated by the library.
]]
self.classes = {}

--[[
This method emulates the new keyword in OOP languages by instantiating a
class by its name as long as the class has a __construct() method with or
without parameters.
]]
function self:new(classname, ...)
    return self.classes[classname].__construct(...)
end