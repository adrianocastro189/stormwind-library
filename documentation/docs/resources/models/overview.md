---
sidebar_position: 1
title: Overview
---

Models are structures following [class standards](../core/classes), mostly
used to map game objects and ease data manipulation in the addon.

## Model standards

Models are classes that represent a data structure, like a raid marker,
a player, a macro, an item, etc. They're usually used to hold information
about game objects as a way to standardize structures.

Here are some good practices when creating models:

1. **Avoid constructors with parameters**: Prefer to use setters as that ease
on inheritance, testing and avoid compatibility issues in case new parameters
are added to the constructors.
1. **Implement chainable setters**: When a setter is called, it should return
the instance itself, so it can be chained with other setters. That improves
writing code and makes it more readable.
   * Prefer to use `value` as the setter parameter name instead of the 
     property name, example:
     ```lua
     --[[--
     Sets the model name.
     
     @tparam string value the model's name

     @treturn Module.ClassName self
     ]]
     function ClassName:setProperty(value)
         self.property = value
         return self
     end
     ```
1. **There's no need for getters**: Lua doesn't have a way to protect 
properties, so it's not necessary to create getters for them. If a property 
needs to be read, it can be accessed directly, and that will save a lot of
unnecessary code.
1. **Test the chainable setters in a single test method**: With a single method
testing all setters, it's possible to make sure that all setters are chainable,
save a lot of code, make the test more readable and easier to add new setter
tests when new properties are added to the model.
   ```lua
   -- @covers ClassName:setArg1()
   -- @covers ClassName:setArg2()
   -- @covers ClassName:setArg3()
   function TestClassName:testSetters()
       local instance = __:new('ClassName')
       
       lu.assertIsNil(instance.arg1)
       lu.assertIsNil(instance.arg2)
       lu.assertIsNil(instance.arg3)
   
       local result = instance
           :setArg1('arg1')
           :setArg2('arg2')
           :setArg3('arg3')
   
       lu.assertEquals(instance, result)
       lu.assertEquals(instance.arg1, 'arg1')
       lu.assertEquals(instance.arg2, 'arg2')
       lu.assertEquals(instance.arg3, 'arg3')
   end
   ```