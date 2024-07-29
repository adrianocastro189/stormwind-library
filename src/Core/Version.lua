--[[--
Gets a formatted version label for the addon.

By default, a version label is simply the version number prefixed with a 'v'.

For this method to work, the addon property 'version' must be set during
initialization, otherwise it will return nil.

@treturn string The version addon property prefixed with a 'v'
]]
function self:getVersionLabel()
    if self.addon.version then
        return 'v' .. self.addon.version
    end

    return nil
end