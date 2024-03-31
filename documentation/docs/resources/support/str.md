# Str

The **Str** methods are focused on manipulating strings.

Each helper method is well documented in the support source code and won't
be duplicated here. Please, refer to the `./src/Support/Src.lua` for better
reference.

## Methods

* `Str:isEmpty()` - Determines whether a string is empty or not.
    * By empty, it means that the string is nil, has no characters, or has 
    only whitespace characters. This last case is important because a 
    string with only whitespace characters is not considered empty by Lua's 
    standards, but it is by this function's standards.
* `Str:isNotEmpty()` - Determines whether a string is not empty.
    * Read the `Str:isEmpty()` documentation above for clarification about
    what this library considers when checking if a string is empty.
* `Str:replaceAll()` - Replaces all occurrences of a substring in a string 
with another substring.
* `Str:split()` - Splits a string in a table by breaking it where the separator is found.
* `Str:trim()` - Removes all whitespace from the beginning and end of a 
string.