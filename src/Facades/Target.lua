--[[
The target facade maps all the information that can be retrieved by the
World of Warcraft API target related methods.

This class can also be used to access the target with many other purposes,
like setting the target icon, clearing the target itself, etc.
]]

local Target = {}
Target.__index = Target

--[[
Target constructor.
]]
function Target.__construct()
    local self = setmetatable({}, Target)

    return self
end

--[[
Adds or removes a marker on the target based on a target icon index:

0 - Removes any icons from the target
1 = Yellow 4-point Star
2 = Orange Circle
3 = Purple Diamond
4 = Green Triangle
5 = White Crescent Moon
6 = Blue Square
7 = Red "X" Cross
8 = White Skull

@see https://wowwiki-archive.fandom.com/wiki/API_SetRaidTarget
]]
function Target:mark(iconIndex)
    SetRaidTarget('target', iconIndex)
end

-- sets the unique library target instance
self.target = Target.__construct()
function self:getTarget() return self.target end