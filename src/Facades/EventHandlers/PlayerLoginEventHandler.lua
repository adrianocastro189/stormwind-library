-- the Stormwind Library event triggered when a player logs in
self.events.EVENT_NAME_PLAYER_LOGIN = 'PLAYER_LOGIN'

-- handles the World of Warcraft PLAYER_LOGIN event
self.events:listenOriginal('PLAYER_LOGIN', function ()
    self:notify(self.events.EVENT_NAME_PLAYER_LOGIN)
end)