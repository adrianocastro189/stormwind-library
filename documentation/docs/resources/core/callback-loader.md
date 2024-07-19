# Callback Loader

As described in the [build section](../../library-structure/build), the library
Lua files - spread across multiple directories - are merged into a single Lua
file.

This approach eases its distribution but introduces a problem: the importance
of the order in which the files are merged. For instance, if a file `a.lua`
needs to call a function defined in `b.lua`, `b.lua` must be merged before, but
if the opposite is also true, a cyclic dependency is created and it's 
impossible to handle. Of course, cyclic dependencies are a sign of bad design,
however, in specific cases like the calls between support functions, it's
acceptable.

Most issues would be observed between model classes. Imagine relationships 
between classes that reference each other, like a `Player` class that owns an
`Item` that is also used by a `GuildBank` class that references a `Guild` that 
has a list of `Player`s. We don't have a direct cyclic dependency, but an 
indirect one.

To solve problems like this, the library version 1.9.0 introduced the callback 
loader mechanism. This mechanism is similar to the jQuery's
`$(document).ready()` function and will create a callback queue to be executed 
after all files are merged.

With this queue, all Lua files will be focused on defining their class and
function structures, but when it comes to execute code, it will be done later
when the library is fully loaded.

:::warning This is available only for the library itself

Please, note that callback loader is available during the library loading
process and it's not available for addons.

When the library is instantiated, the callback queue and invocation mechanism
are removed right after their execution, making this an **internal** system to
improve the library loading process.

:::

## Usage

As a reminder, the callback loader is available only for the library itself.
That said, the instructions below must be considered when developing library
files, not addons.

Consider the two files below. **They're not part of the library**, but just a 
very simple example to illustrate the callback loader mechanism.

* Inventory.lua
  ```lua
  function playerHasItem(itemId)
      -- logic to check if the player has an item
      return true
  end
  ```

* Player.lua
  ```lua
  function playerIsMissingHearthstone()
      return not playerHasItem(6948)
  end
  ```

Now, during the **library loading process**, some code that's not inside any 
class or function scope does:

```lua
-- on initialization
if playerIsMissingHearthstone() then
    print('Remember to talk to an innkeeper to get a hearthstone!')
end
```

The code above will raise errors if the `PlayerCheckUp.lua` file is referenced
before `Inventory.lua`.

To solve such issues, the callback loader mechanism can be used. The code below
can be placed at the end of any file above and will be executed after all
library resources are loaded.

```lua
-- on initialization
library:onLoad(function()
    if playerIsMissingHearthstone() then
        print('Remember to talk to an innkeeper to get a hearthstone!')
    end
end)
```