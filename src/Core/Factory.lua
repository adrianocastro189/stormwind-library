--[[
Contains a list of classes that can be instantiated by the library.
]]
self.classes = {}

--[[
Registers a class so the library is able to instantiate it later.

This method's the same as updating self.classes.
]]
function self:addClass(classname, classStructure)
    self.classes[classname] = classStructure
end

--[[
This method emulates the new keyword in OOP languages by instantiating a
class by its name as long as the class has a __construct() method with or
without parameters.
]]
function self:new(classname, ...)
    return self.classes[classname].__construct(...)
end