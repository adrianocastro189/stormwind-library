--[[
The target facade maps all the information that can be retrieved by the
World of Warcraft API target related methods.

This class can also be used to access the target with many other purposes,
like setting the target icon.
]]
local Target = {
        -- constants
        MARKER_REMOVE = 'remove',
        MARKER_STAR = 'star',
        MARKER_CIRCLE = 'circle',
        MARKER_DIAMOND = 'diamond',
        MARKER_TRIANGLE = 'triangle',
        MARKER_MOON = 'moon',
        MARKER_SQUARE = 'square',
        MARKER_X = 'x',
        MARKER_SKULL = 'skull',

        -- markers dictionary
        markers = {
            remove   = 0,
            star     = 1,
            circle   = 2,
            diamond  = 3,
            triangle = 4,
            moon     = 5,
            square   = 6,
            x        = 7,
            skull    = 8,
        }
    }
    Target.__index = Target
    Target.__ = self

    --[[
    Target constructor.
    ]]
    function Target.__construct()
        return setmetatable({}, Target)
    end

    --[[
    Gets the target GUID.
    ]]
    function Target:getGuid()
        return UnitGUID('target')
    end

    --[[
    Gets the target health.

    In the World of Warcraft API, the UnitHealth('target') function behaves
    differently for NPCs and other players. For NPCs, it returns the absolute
    value of their health, whereas for players, it returns a value between
    0 and 100 representing the percentage of their current health compared
    to their total health.
    ]]
    function Target:getHealth()
        return self:hasTarget() and UnitHealth('target') or nil
    end

    --[[
    Gets the target health in percentage.

    This method returns a value between 0 and 1, representing the target's
    health percentage.
    ]]
    function Target:getHealthPercentage()
        return self:hasTarget() and (self:getHealth() / self:getMaxHealth()) or nil
    end

    --[[
    Gets the maximum health of the specified unit.

    In the World of Warcraft API, the UnitHealthMax function is used to
    retrieve the maximum health of a specified unit. When you call
    UnitHealthMax('target'), it returns the maximum amount of health points
    that the targeted unit can have at full health. This function is commonly
    used by addon developers and players to track and display health-related
    information, such as health bars and percentages.
    ]]
    function Target:getMaxHealth()
        return self:hasTarget() and UnitHealthMax('target') or nil
    end

    --[[
    Gets the target name.
    ]]
    function Target:getName()
        return UnitName('target')
    end

    --[[
    Target marks in World of Warcraft are numbers from 0 to 8.

    This method works as a helper to get the target mark index based on its
    name or index. The name is a string, and the index is a number and for
    more reference, see the MARKER_* constants in this class.
    ]]
    function Target:getTargetMarkIndex(targetNameOrIndex)
        if (type(targetNameOrIndex) == 'number') then
            return (targetNameOrIndex >= 0 and targetNameOrIndex <= 8) and targetNameOrIndex or nil
        end

        return self.__.arr:get(self.markers, targetNameOrIndex)
    end

    --[[
    Determines whether the player has a target or not.
    ]]
    function Target:hasTarget()
        return nil ~= self:getName()
    end

    --[[
    Determines whether the target is alive.
    ]]
    function Target:isAlive()
        if self:hasTarget() then
            return not self:isDead()
        end
        
        return nil
    end

    --[[
    Determines whether the target is dead.
    ]]
    function Target:isDead()
        return self:hasTarget() and UnitIsDeadOrGhost('target') or nil
    end

    --[[
    Determines whether the target is taggable or not.

    In Classic World of Warcraft, a taggable enemy is an enemy is an enemy that
    can grant experience, reputation, honor, loot, etc. Of course, that would
    depend on the enemy level, faction, etc. But this method checks if another
    player hasn't tagged the enemy before the current player.

    As an example, if the player targets an enemy with a gray health bar, it
    means it's not taggable, then this method will return false.
    ]]
    function Target:isTaggable()
        if not self:hasTarget() then
            return nil
        end

        return not self:isNotTaggable()
    end

    --[[
    Determines whether the target is already tagged by other player.

    Read Target::isTaggable() method's documentation for more information.
    ]]
    function Target:isNotTaggable()
        return UnitIsTapDenied('target')
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

    It's also possible to use the MARKER_* constants from this class.
    ]]
    function Target:mark(iconIndex)
        markIndex = self:getTargetMarkIndex(iconIndex)

        if nil ~= markIndex then SetRaidTarget('target', markIndex) end
    end
-- end of Target

-- sets the unique library target instance
self.target = Target.__construct()