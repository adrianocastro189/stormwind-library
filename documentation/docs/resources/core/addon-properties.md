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

### data

* **Type:** string, that must be informed as a string, not the table variable
itself, given that the library will access it with `_G`
* **Optional**
* **Default:** `nil`
* **Effect:** The library will automatically create a [configuration](configuration)
instance and enable the `config(...)` proxy method to access the saved 
variables properties. The string must be the name of the saved variables 
table.

### inventory

* **Type**
  * A table containing flags for inventory management
  * **Important note:** This property and the inventory tracking feature were 
  introduced in version 1.4.0 in an experimental way. Please, use this tracking
  flag with caution and expect changes (especially in performance) in future
  ```lua
  -- ...
  inventory = {
    track = true,
  }
  -- ...
  ```
* **Optional**
* **Default:** `{ track = false }`, indicating that the library will not
track the player's inventory by default
* **Effect:** When set to `true`, the library will automatically instantiate
the [player's inventory](../models/inventory) and keep it updated with the 
player's containers by listening to the `BAG_UPDATE` event.

### name

* **Type:** string
* **Required**
* **Effect:** The library will store the addon name for multiple purposes.

### version

* **Type:** string
* **Optional**
* **Effect:** The library will store the addon version for multiple purposes.
