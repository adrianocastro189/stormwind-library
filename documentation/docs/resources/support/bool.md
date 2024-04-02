# Bool

The **Bool** support methods are focused on working and validating bool 
values.

Each helper method is well documented in the support source code and won't
be duplicated here. Please, refer to the `./src/Support/Bool.lua` for better
reference.

## Methods

* `Bool:isTrue()` - Determines whether a value represents true or not.

:::note Note about the absence of isFalse()

Developers may notice this class has no `isFalse()` method.

In terms of determining if a value is true, there's a limited
range of values that can be considered true. On the other hand,
anything else **shouldn't be considered false.** Consumers of this
class can use `isTrue()` to determine if a value represents a true
value, but using a `isFalse()` method would be a bit inconsistent.
That said, instead of having a `isFalse()` method, consumers can
use the `not` operator to determine if a value is false, which
makes the code more readable, like: if this value is not true,
then do something.

:::