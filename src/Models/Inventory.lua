--[[--
This model represents the group of all player containers condensed as a
single concept.

It's a concept because the game doesn't have a visual inventory, but it
shows the items inside bags, bank slots, keyring, etc, that are mapped as
containers, while the inventory is the "sum" of all these containers.

@classmod Models.Inventory
]]
local Inventory = {}
    Inventory.__index = Inventory
    Inventory.__ = self
    self:addClass('Inventory', Inventory)

    --[[--
    Inventory constructor.
    ]]
    function Inventory.__construct()
        local instance = setmetatable({}, Inventory)

        instance.outdated = true

        return instance
    end

    --[[--
    Marks the inventory as outdated, meaning that the container's items need
    to be refreshed, mapped again, in which container inside this inventory
    instance to reflect the current state of the player items in all
    containers.

    It's important to mention that this flag is named "outdated" instead of
    "updated" because as a layer above the game's API, the library will do the
    best it can to keep the container's items updated, but it's not guaranteed
    considering the fact that it can miss some specific events. One thing it
    can be sure is when the container is outdated when the BAG_UPDATE event
    is triggered.

    @see Models.Container.flagOutdated

    @treturn Models.Inventory self
    ]]
    function Inventory:flagOutdated()
        self.outdated = true

        self.__.arr:each(self.containers, function (container)
            container:flagOutdated()
        end)

        return self
    end

    --[[--
    Gets all items from the inventory.

    This method will return all items from all containers mapped in the
    inventory.

    Make sure to call this method after any actions that trigger the
    inventory mapping (refresh), to get the most updated items.
    ]]
    function Inventory:getItems()
        self:maybeMapContainers()

        local items = {}

        self.__.arr:each(self.containers, function (container)
            items = self.__.arr:concat(items, container:getItems())
        end)

        return items
    end

    --[[--
    Determines whether the inventory has a specific item.

    @tparam int|Models.Item The item ID or item instance to search for

    @treturn boolean
    ]]
    function Inventory:hasItem(item)
        self:maybeMapContainers()

        return self.__.arr:any(self.containers, function (container)
            return container:hasItem(item)
        end)
    end

    --[[--
    Maps all player containers in the inventory internal list.

    This method will also trigger the mapping of the containers slot, so
    it's expected to have the player items synchronized after this method
    is called.

    @treturn Models.Inventory self
    ]]
    function Inventory:mapContainers()
        if not self.__.arr:get(_G, 'Enum.BagIndex') then
            return
        end

        self.containers = {}

        self.__.arr:each(Enum.BagIndex, function (bagId, bagName)
            local container = self.__:new('Container')
                :setSlot(bagId)
                :mapItems()

            table.insert(self.containers, container)
        end)

        self.outdated = false

        return self
    end

    --[[--
    May map the containers if the inventory is outdated.

    @local
    
    @treturn Models.Inventory self
    ]]
    function Inventory:maybeMapContainers()
        if self.outdated then
            self:mapContainers()
        end

        return self
    end

    --[[--
    Iterates over all containers in the inventory and refreshes their items.

    @treturn Models.Inventory self
    ]]
    function Inventory:refresh()
        self:maybeMapContainers()

        self.__.arr:each(self.containers, function (container)
            container:refresh()
        end)

        return self
    end
-- end of Inventory

if self.addon.inventory.track then
    self.playerInventory = self:new('Inventory')
    self.playerInventory:mapContainers()

    self.events:listenOriginal('BAG_UPDATE', function ()
        self.playerInventory:mapContainers()
    end)
end