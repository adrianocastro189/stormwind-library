local events = self.events

-- the Stormwind Library event triggered when a player engages in combat
events.EVENT_NAME_PLAYER_ENTERED_COMBAT = 'PLAYER_ENTERED_COMBAT'

-- the Stormwind Library event triggered when a player leaves combat
events.EVENT_NAME_PLAYER_LEFT_COMBAT = 'PLAYER_LEFT_COMBAT'

-- handles the World of Warcraft PLAYER_REGEN_DISABLED event
events:listenOriginal('PLAYER_REGEN_DISABLED', function ()
    events:notify(events.EVENT_NAME_PLAYER_ENTERED_COMBAT)
end)

-- handles the World of Warcraft PLAYER_REGEN_ENABLED event
events:listenOriginal('PLAYER_REGEN_ENABLED', function ()
    events:notify(events.EVENT_NAME_PLAYER_LEFT_COMBAT)
end)