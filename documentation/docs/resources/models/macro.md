# Macros

Macro is the mapping of a game macro accessed with `/m`.

It basically allows macro manipulation without having to use the World of Warcraft API
global functions.

When addons need to create/update macros, they can easily instantiate a macro
by its name, use the setters to define its icon and body, then call the `save()` method.

:::tip Note about macro names

The **Macro** class was designed to work with macros created and managed by an addon.

It's not entirely related to query and manage existing and custom macros so it won't
behave well if used for that purpose.

:::

## How to use the Macro class

1. Instantiate a macro using the [factory resources](../core/factory)
1. Customize is icon if necessary
1. Set a body
1. Save it!

:::tip Setting the macro body with an array

The Macro's `setBody()` method accepts a string **or** an array of strings.

If an array is passed, the library will automatically add a line break between the values
to place a command per line. So, there's no need to concatenate lines with `\n` here.

:::

## Example

Imagine an addon that adds a macro to target a unit and wave. This is how it could
implement that:

```lua
local macro = library:new('Macro', 'MyAddonCustomMacro')

macro:setIcon("INV_Misc_QuestionMark")
macro:setBody({
    '/tar PlayerName',
    '/wave'
})
macro:save()
```

When the code above is executed, a macro with name **MyAddonCustomMacro** will be created
**or** updated with a body and icon.