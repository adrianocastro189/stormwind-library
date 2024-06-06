# Item

The Item class is a model that maps game items and their properties.

Just like any other model, it's used to standardize the way addons interact 
with game objects, especially when item information is passed as a parameter
to methods, events, datasets, etc.

Its first version, introduced in the library version 1.2.0 includes only the
`name` property, but this model will grow over time as new expansions are 
released and new features are implemented in the library.

For a more detailed explanation of the Item model and its available methods 
and properties, please refer to the library
[technical documentation](pathname:///lua-docs/classes/Models.Item.html).

## Building item instances from different sources

Stormwind Library provides a factory to create item instances from different
sources like the container item info table. Please refer to the
[ItemFactory documentation](../factories/item-factory) for more information.