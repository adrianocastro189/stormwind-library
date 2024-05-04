# Tooltip

The Tooltip facade is a layer between the World of Warcraft tooltip system
and the Stormwind Library.

It was introduced in version 1.2.0 due to the need of different ways to handle
tooltip show events from Classic Era and Retail versions of the game. For that
reason, this facade is offered as an abstraction called `AbstractTooltip` and
its implementations will be automatically delivered to any addons as long as
they use the [instantiation structure](../core/factory).

## Handling tooltip show events

Tooltip events in World of Warcraft are handled by the child classes of the
abstraction and then an [event](events) is broadcasted so addons can
hook into it and perform their own actions, regardless of the game version.

With this approach, it's only a matter of listening to the proper events.

:::note Tooltip events in 1.2.0

In version 1.2.0, the tooltip facade covers only **Unit** and **Item** 
tooltips. However, there are plans to expand it to other types of tooltips
in the future.

Keep an eye on the [changelog](../../changelog) for updates and in this page
for new implementations.

:::

The list of available tooltip events is [here](events#tooltip_item_shown).

## Tooltip implementations

The abstract tooltip facade has two implementations:

- `ClassicTooltip`: for Classic Era and Classic versions of the game
- `RetailTooltip`

They're registered for the proper game version when the library is loaded,
so there's no need to manually instantiate them, just invoke the facade
instantiation method by passing `'Tooltip'` as the class name.

```lua
local tooltip = library:new('Tooltip')
```