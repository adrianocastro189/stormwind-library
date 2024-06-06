# Inventory

The [Container](container) model introduced a mapped object to represent bags,
bank slots, the player's backpack, and any other container capable of holding
items.

The Inventory model is a concept that **groups all containers** available to 
the player in a way to represent all items the player has.

Although instantiable just like almost every model in the Stormwind Library,
it's recommended to use the instance stored in the library object as a good
source of truth.