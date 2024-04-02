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

The library is set up before each test in the base test class, so mocking
properties and methods of the library can be done in each test case without
affecting other tests.

To mock a property or method of the library, simply assign a new value to
the property or method in the test case. For example, to mock the `name`
property of the library, you can do the following:

```lua
__.name = 'MockedName'
```

To mock a method of the library, you can assign a new function to the
method in the test case.

There's no need to revert the mocked properties and methods back to their
original values after the test case is run, unless the test method is
expected to be called multiple times in the same test class and with
different mocks.