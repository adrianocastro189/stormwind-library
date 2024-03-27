local events = self.events

-- the Stormwind Library event triggered when a player logs in
events.EVENT_NAME_PLAYER_LOGIN = 'PLAYER_LOGIN'

-- handles the World of Warcraft PLAYER_LOGIN event
events:listenOriginal('PLAYER_LOGIN', function ()
    events:notify(events.EVENT_NAME_PLAYER_LOGIN)
end)