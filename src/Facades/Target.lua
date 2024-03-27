--[[
The target facade maps all the information that can be retrieved by the
World of Warcraft API target related methods.

This class can also be used to access the target with many other purposes,
like setting the target marker.
]]
local Target = {}
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
    Adds or removes a raid marker on the target.

    @see ./src/Models/RaidTarget.lua
    @see https://wowwiki-archive.fandom.com/wiki/API_SetRaidTarget

    @tparam RaidMarker raidMarker
    ]]
    function Target:mark(raidMarker)
        if raidMarker then
            SetRaidTarget('target', raidMarker.id)
        end
    end
-- end of Target

-- sets the unique library target instance
self.target = Target.__construct()