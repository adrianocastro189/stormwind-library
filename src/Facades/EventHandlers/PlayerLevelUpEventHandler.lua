local events = self.events

-- the Stormwind Library event triggered when a player levels up
events.EVENT_NAME_PLAYER_LEVEL_UP = 'PLAYER_LEVEL_UP'

-- handles the World of Warcraft PLAYER_LEVEL_UP event
events:listenOriginal('PLAYER_LEVEL_UP', function (newLevel)
    self.currentPlayer:setLevel(newLevel)

    events:notify(events.EVENT_NAME_PLAYER_LEVEL_UP, newLevel)
end)