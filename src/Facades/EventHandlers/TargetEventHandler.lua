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

--[[
Listens to the World of Warcraft PLAYER_TARGET_CHANGED event, which is
triggered when the player changes the target.

This method covers 
]]
function Events:playerTargetChangedListener()
    
end

-- listens to the World of Warcraft PLAYER_TARGET_CHANGED event
events:listenOriginal('PLAYER_TARGET_CHANGED', function ()
    events:playerTargetChangedListener()
end)