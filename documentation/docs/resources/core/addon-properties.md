# Addon Properties

When the library is initialized, addons can pass its properties to
improve how it handles its resources.

In the example below, `MyAddon` is the addon main table and `__` is
the library reference. Please, remember that the library class must
carry its version to avoid conflicts, but for the sake of simplicity,
it's simply called `StormwindLibrary`.

```lua
MyAddon.__ = StormwindLibrary.new({
  command = 'myAddon',
  name    = 'My Custom Addon',
})
```

Once initialized, these properties can be accessed in the library's
property called `addon`. The code below will print "My Custom Addon".

```lua
print(MyAddon.__.addon.name)
```

## Available properties

The following sections list the available properties and their effect
on the library. See the first example in this article on how to pass
the addon properties and each subtitle below represents a table index,
so when showing `command` for example, it means passing a table with
`{command = 'myAddon'}` when calling `new()` for a new library instance.

Some parameters are **optional** and some are **required**.

### colors

* **Type**
  * A table containing the primary and the secondary colors
  * Colors must be provided as hexadecimal strings
  ```lua
  -- ...
  colors = {
    primary = 'FFFFFF',
    secondary = '000000',
  }
  -- ...
  ```
* **Optional**
* **Default:** `{}`, indicating there are not default colors
* **Effect:** Most output messages will use the **primary** color to
highlight the prefix; the **secondary** color may also be used to
highlight secondary information.

### command

* **Type:** string
* **Optional**
* **Default:** `nil`
* **Effect:** When initialized, the library will register a command
that can be executed in game. Please, read the
[commands documentation](../commands/overview) for reference.

### name

* **Type:** string
* **Required**
* **Effect:** The library will store the addon name for multiple purposes.
