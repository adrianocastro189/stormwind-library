local Item = {}
Item.__index = Item

function Item.new(name)
    local self = setmetatable({}, Item)
    self.name = name
    return self
end

function Item:getName()
    return self.name
end