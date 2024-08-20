# Test Classes

Test classes in the Stormwind Library are organized in a way that makes it
easy to run all tests at once although split into multiple files for each
class in the src directory.

The `./tests/unit.lua` file is the entry point for running all tests and it
also defines a base test class that sets up the library before each test.
Setting up the library before each test ensures that the library is in a
clean state before each test is run, so mocking the library on tests won't
affect the results of other tests.

## Writing a test class

In order to write a test class, it's highly recommended to follow a couple
of standards to keep the tests organized, easy to read, and easy to
maintain.

As an example, consider the support classes in the library as they are good
representatives of how a test class should be written.

1. Start by creating a directory following the same structure as the src
   directory, but inside tests
1. Create a test file for each class in the src directory
1. Define the test class starting with the **Test** prefix followed by the
   name of the class being tested; this is important for the test runner to
   identify the test class, otherwise it will be skipped
1. Define a method for each test case starting with the **test** prefix
1. Update the `./tests/unit.lua` file to include the test file, preferably
   in alphabetical order

See [this example](../resources/core/classes#class-recipe) of how a test class
is structured.

## Working with test cases

Stormwind Library version 1.11.0 introduced a new way to write test cases by providing
a test class that allows multiple scenarios to be tested in a single test body. It was
initially added to `tests\unit.lua` but may be moved in the future in case a test
library is created.

By the way, `tests\unit.lua` can be copied to the addon's test directory and updated 
to serve as the entry point for running all tests there as well.

A test case is a simple class that contains a few chained setters and a register 
method. Once called and configured, the register method will add a new method prefixed
with `test` so the testing library can identify it as a test case. In other words, it
works similarly as writing multiple test methods in a table.

By the time of writing this documentation, Stormwind Library uses
[luaunit](../testing/unit-suite) as the main testing library, so all test cases must
be created as methods prefixed with `test` in tables that also start with the `Test`
prefix.

That said, for methods with conditionals and multiple possible outcomes, it's 
recommended to share the same test body. However, having multiple assertions for each
scenario can be a bit confusing to identify when they break. So it's recommended to 
have atomic assertions for each scenario.

Here's an example of how to write a test case with multiple scenarios:

```lua
TestMyCustomClass = BaseTestClass:new()

TestCase.new()
   :setName('add')
   :setTestClass(TestMyCustomClass)
   :setExecution(function(data)
      local handler = {'imagine a handler class here...'}
      handler:add(data.value)
      lu.assertTrue(data.expectedResult, handler:getAddedValues())
   end)
   :setScenarios({
      ['adding nil values'] = {
         value = nil,
         expectedResult = {}
      },
      ['adding a number'] = function ()
         local something = _G['someCustomTable']:getSomething()
         return {
            value = something,
            expectedResult = {something}
         }
      end,
   })
   :register()
```

* The test name can be anything that identifies the test case and must be unique
* The test class must be the table instantiated in the test file
* The execution method is where the test body is defined
* Scenarios is a table with multiple scenarios that will be sent to the test body
  as the `data` argument
* The register method will add a new method prefixed with `test` to the test class
  for each scenario

Based on the example above, when executing the tests for `TestMyCustomClass`, two 
test methods will be created, one for each scenario, which also desires a few notes:

* The scenarios setter is not required, so it's possible to have a test case with
  only one default scenario. Just omit the `setScenarios()` call and remove the `data`
  parameter from the execution method.
* Each scenario must have a unique name, otherwise they may overwrite each other
* Note that scenarios can be defined as tables or functions in the example above:
  * When they are tables, the test body will receive the table as the `data` parameter
  * When they are functions, the test body will receive the return of the function as
    the `data` parameter. This is useful when the scenario needs to access structures
    that are available only at runtime, after the test setup.

## Getting the library instance in a test case

A library instance is available in each test case through the global
variable `__` and it's ready to be used without any further setup. However,
if a test case requires a different setup, it's possible to instantiate a
new library instance in the test case by doing this:

```lua
local __ = StormwindLibrary.new({
    name = 'TestSuite'
})
```

In the example above, `StormwindLibrary` is an alias for the library version
being tested, so when new versions are released, it's only necessary to
update the alias in the `./tests/unit.lua` file.

## Mocking library properties and methods

A library instance is set up before each test in the base test class and also before 
each scenario when the test case class is used. That said, mocking properties and 
methods of the library can be done in each test execution without affecting other 
tests.

To mock a property or method in this instance, simply assign a new value to
the property or method in the test case. For example, to mock the addon `name`,
you can do the following:

```lua
__.addon.name = 'MockedName'
```

To mock a method library, you can assign a new function to do and/or return what
you expect to help the test case.

There's no need to revert the mocked properties and methods back to their
original values after the test case is run, unless the test method is
expected to be called multiple times in the same test class and with
different mocks, however, that's a sign that a test case should be created
with multiple scenarios instead.

Stormwind Library also provides a set of mocks for the World of Warcraft API
that are better described in the [API Mocks](api-mocks) documentation.

### Spies

Spies are a type of mock that allows you to replace a few parts of objects to track
how they are being used. Of course, the concept of spies are way more complex than
this, but Stormwind Library implements a simple version of it. It was introduced in
v1.12.0 as an experimental feature that may be improved in the future.

As of now, the two spy classes available are `Spy` and `MethodSpy`, both located in 
`tests\spies.lua`. This file can be copied to the addon's test directory and 
referenced with `dofile` so they can be used in test cases.

You probably won't need to use `MethodSpy` directly as it's more like a utility class
for `Spy`.

As an example, consider a class called `EndGameFeatures` with a couple of methods 
for handling end game features.

```lua
-- class declaration...
EndGameFeatures = {}
   -- other methods here...

   function EndGameFeatures:getPlayerLevel()
      return UnitLevel('player')
   end

   function EndGameFeatures:playerIsAtMaxLevel()
      return self:getPlayerLevel() == MAX_PLAYER_LEVEL
   end
   
   -- more methods here...
```

When testing this class, you may want to mock the `UnitLevel` function to return a
specific value to serve the `getPlayerLevel` method. And in another method, you may
wamt to mock `getPlayerLevel` to return a specific value to test 
`playerIsAtMaxLevel`.

This can be done directly by replacing the function references like this:

```lua
TestCase.new()
   :setName('playerIsAtMaxLevel')
   :setTestClass(TestEndGameFeatures)
   :setExecution(function(data)
      local instance = library:new('EndGameFeatures')

      instance.getPlayerLevel = function()
         return data.playerLevel
      end

      lu.assertEquals(data.expectedResult, instance:playerIsAtMaxLevel())
   end)
   :setScenarios({
      ['player is at max level'] = {
         playerLevel = 60,
         expectedResult = true
      },
      ['player not at max level'] = {
         playerLevel = 59,
         expectedResult = false
      }
   })
   :register()
```

It works as a valid test, but with spies, it can be improved to track how the method
is observed. Here's how to do it:

```lua
TestCase.new()
   :setName('playerIsAtMaxLevel')
   :setTestClass(TestEndGameFeatures)
   :setExecution(function(data)
      local instance = Spy
         .new(library:new('EndGameFeatures'))
         :mockMethod('getPlayerLevel', function()
            return data.playerLevel
         end)

      local result = instance:playerIsAtMaxLevel()

      lu.assertEquals(data.expectedResult, result)
      instance:getMethod('getPlayerLevel'):assertCalledOnce()
   end)
   :setScenarios({
      ['player is at max level'] = {
         playerLevel = 60,
         expectedResult = true
      },
      ['player not at max level'] = {
         playerLevel = 59,
         expectedResult = false
      }
   })
   :register()
```

This is what the test execution does:

1. Create a new spy instance passing the `EndGameFeatures` instance
1. Once wrapped, the spy instance can mock methods and properties and the mock 
   methods are chained, which means it's possible to mock multiple methods one
   after another and still hold the reference to the spy instance
1. Call the `instance:playerIsAtMaxLevel()` method and store the result
1. Assert the result is the expected one
1. Assert the `getPlayerLevel` method was called once, and this is the main
   advantage of using spies, as it allows you to track how the method is being
   used

The `MethodSpy` class has a few more assertions that use the same unit testing
library, so it's not necessary to call `lu.assertEquals` and similar functions
on the methods spies instances.

:::note Mocking functions stored as properties

Due to how this first Spy version is implemented, functions that are saved as 
properties cannot be mocked as a "class method". Example: a class has a callback
stored as a property, and the callback is called inside a method. It's not
possible to mock the callback and expect that Spy will create a method spy
for it as it won't have the same behavior as a class method.

:::

:::warning Use spies carefully

It's important to mention that as of now, spies are still an experimental feature
and may not work as expected in all scenarios. It's recommended to use them
carefully and review the test results to ensure they are working as expected.

If you find any issues with spies, please report them in the
[library's repository issues page](https://github.com/adrianocastro189/stormwind-library/issues).

:::