--[[
Sets the addon properties.

Allowed properties = {
    colors: table, optional
        primary: string, optional
        secondary: string, optional
    command: string, optional
    name: string, optional
}
]]
self.addon = {}

self.addon.colors  = self.arr:get(props or {}, 'colors', {})
self.addon.command = self.arr:get(props or {}, 'command')
self.addon.name    = self.arr:get(props or {}, 'name')

local requiredProperties = {
    'name'
}

for _, property in ipairs(requiredProperties) do
    if not self.addon[property] then
        error(string.format('The addon property "%s" is required to initialize Stormwind Library.', property))
    end
end