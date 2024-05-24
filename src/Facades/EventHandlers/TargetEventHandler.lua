local events = self.events

-- it's safe to announce that the event states are false here, given
-- that when the player logs in or /reload the game, the target is cleared
events.eventStates.playerHadTarget = false

-- the Stormwind Library event triggered when the player targets a unit
events.EVENT_NAME_PLAYER_TARGET = 'PLAYER_TARGET'

-- the Stormwind Library event triggered when the player target changes
events.EVENT_NAME_PLAYER_TARGET_CHANGED = 'PLAYER_TARGET_CHANGED'

-- the Stormwind Library event triggered when the player clears the target
events.EVENT_NAME_PLAYER_TARGET_CLEAR = 'PLAYER_TARGET_CLEAR'

--[[--
Listens to the World of Warcraft PLAYER_TARGET_CHANGED event, which is
triggered when the player changes the target.

This method breaks the event into three different events:

- PLAYER_TARGET: triggered when the player targets a unit
- PLAYER_TARGET_CHANGED: triggered when the player target changes
- PLAYER_TARGET_CLEAR: triggered when the player clears the target

To achieve this, a pleyerHadTarget event state is used to keep track of
whether the player had a target or not when the World of Warcraft event
was captured.

When the player had no target and the event was captured, the
PLAYER_TARGET is triggered, meaning that player now targetted a unit.

When the player had a target, the event was captured and the player still
had a target, the PLAYER_TARGET_CHANGED is triggered, meaning that it was
changed.

Finally, when the player had a target and the event was captured, but the
player no longer has a target, the PLAYER_TARGET_CLEAR is triggered.

@local
]]
function Events:playerTargetChangedListener()
    if self.eventStates.playerHadTarget then
        if self.__.target:hasTarget() then
            self:notify(self.EVENT_NAME_PLAYER_TARGET_CHANGED)
            return
        else
            self:notify(self.EVENT_NAME_PLAYER_TARGET_CLEAR)
            self.eventStates.playerHadTarget = false
            return
        end
    else
        self:notify(self.EVENT_NAME_PLAYER_TARGET)
        self.eventStates.playerHadTarget = true
    end
end

-- listens to the World of Warcraft PLAYER_TARGET_CHANGED event
events:listenOriginal('PLAYER_TARGET_CHANGED', function ()
    events:playerTargetChangedListener()
end)