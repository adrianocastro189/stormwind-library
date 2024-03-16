--[[
Sets the addon properties.

Allowed properties = {
    command: string, optional
    name: string, optional
}
]]
self.addon = {}

self.addon.command = self.arr:get(props or {}, 'command')
self.addon.name    = self.arr:get(props or {}, 'name')