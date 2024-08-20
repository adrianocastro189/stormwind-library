-- Set up mocks for WoW API functions and global variables that are usually
-- available in the game environment.
--
-- This file is meant to be required in the test suite setup to provide a
-- consistent environment for the tests to run.
--
-- Although some of the functions and variables have static values, it's
-- possible to override them in the test suite to provide different values
-- for the tests when needed.
C_PetJournal = {
    GetPetInfoByPetID = function (petGuid)
        -- return speciesID, customName, level, xp, maxXP, displayID, isFavorite, name, icon, petType, creatureID, sourceText, description, isWild, canBattle, tradable, unique, obtainable
        return 189, 'Test Pet', 1, 0, 0, 1, false, 'Test Pet', 'test-icon', 1, 1, 'Test Source', 'Test Description', false, true, true, true, true
    end,
    GetSummonedPetGUID = function () return 'test-pet-guid' end,
    GetOwnedBattlePetString = function (speciesId)
        if speciesId == -1 then
            return nil
        end

        return '|cFFFFD200Collected (1/3)'
    end
}

C_Timer = {
    After = function (seconds, callback) end,
    NewTicker = function (seconds, callback)
        local tickerMock = {}
        tickerMock.canceled = false
        tickerMock.callback = callback
        tickerMock.seconds = seconds
        
        function tickerMock:Cancel() self.canceled = true end

        return tickerMock
    end
}

CreateFrame = function (...)
    local mockFrame = {
        ['events'] = {},
        ['scripts'] = {},
        ['unregisteredEvents'] = {},
    }
    
    mockFrame.AddMessage = function (self, ...) self.addMessageInvoked = true end
    mockFrame.ClearAllPoints = function (self) self.clearAllPointsInvoked = true end
    mockFrame.CreateFontString = function (self, ...) return CreateFrame(...) end
    mockFrame.CreateTexture = function (self, ...) return CreateFrame(...) end
    mockFrame.GetHeight = function (self) return self.height end
    mockFrame.GetWidth = function (self) return self.width end
    mockFrame.EnableMouse = function (self, enable) self.mouseEnabled = enable end
    mockFrame.Hide = function (self) self.hideInvoked = true end
    mockFrame.Left = { Hide = function (self) self.hideInvoked = true end }
    mockFrame.Middle = { Hide = function (self) self.hideInvoked = true end }
    mockFrame.RegisterEvent = function (self, event) table.insert(self.events, event) end
    mockFrame.RegisterForClicks = function (self, ...) self.registerForClicksInvoked = true end
    mockFrame.Right = { Hide = function (self) self.hideInvoked = true end }
    mockFrame.SetAutoFocus = function (self, autoFocus) self.autoFocus = autoFocus end
    mockFrame.SetBackdrop = function (self, backdrop) self.backdrop = backdrop end
    mockFrame.SetBackdropBorderColor = function (self, r, g, b, a) self.backdropBorderColor = { r, g, b, a } end
    mockFrame.SetBackdropColor = function (self, r, g, b, a) self.backdropColor = { r, g, b, a } end
    mockFrame.SetColorTexture = function (self, r, g, b, a) self.colorTexture = { r, g, b, a } end
    mockFrame.SetEnabled = function (self, enabled) self.enabled = enabled end
    mockFrame.SetFont = function (self, font, size) self.fontFamily = font self.fontSize = size end
    mockFrame.SetFontObject = function (self, fontObject) self.fontObject = fontObject end
    mockFrame.SetFontString = function (self, fontString) self.fontString = fontString end
    mockFrame.SetFrameLevel = function (self, level) self.frameLevel = level end
    mockFrame.SetFrameStrata = function (self, strata) self.frameStrata = strata end
    mockFrame.SetHeight = function (self, height) self.height = height end
    mockFrame.SetHighlightTexture = function (self, texture) self.highlightTexture = texture end
    mockFrame.SetJustifyH = function (self, justifyH) self.justifyH = justifyH end
    mockFrame.SetMovable = function (self, movable) self.movable = movable end
    mockFrame.SetMultiLine = function (self, multiLine) self.multiLine = multiLine end
    mockFrame.SetNormalTexture = function (self, texture) self.normalTexture = texture end
    mockFrame.SetParent = function (self, parent) self.parent = parent end
    mockFrame.SetPoint = function (self, point, relativeFrame, relativePoint, xOfs, yOfs)
        self.points = self.points or {}

        self.points[point] = {
            relativeFrame = relativeFrame,
            relativePoint = relativePoint,
            xOfs = xOfs,
            yOfs = yOfs,
        }
    end
    mockFrame.SetResizable = function (self, resizable) self.resizable = resizable end
    mockFrame.SetScrollChild = function (self, child) self.scrollChild = child end
    mockFrame.SetScript = function (self, script, callback) self.scripts[script] = callback end
    mockFrame.SetSize = function (self, width, height) self.width = width self.height = height end
    mockFrame.SetText = function (self, text) self.text = text end
    mockFrame.SetTextColor = function (self, r, g, b, a) self.textColor = { r, g, b, a } end
    mockFrame.SetTextInsets = function (self, left, right, top, bottom) self.textInsets = { left, right, top, bottom } end
    mockFrame.SetTexture = function (self, texture) self.texture = texture end
    mockFrame.SetWidth = function (self, width) self.width = width end
    mockFrame.Show = function (self) self.showInvoked = true end
    mockFrame.UnregisterEvent = function (self, event) table.insert(self.unregisteredEvents or {}, event) end

    return mockFrame
end

CreateMacro = function () end

date = function (format) return '2024-02-04' end

DEFAULT_CHAT_FRAME = CreateFrame('Frame')

GameTooltip = {
    HookScript = function (self, script, callback)
        self.scripts = self.scripts or {}
        self.scripts[script] = callback
    end
}

GetMacroIndexByName = function () return 0 end

GetRealmName = function () return 'test-realm' end

GetSubZoneText = function () return 'Trade District' end

GetZoneText = function () return 'Stormwind City' end

LOOT_ITEM_SELF = 'You receive loot : %s|Hitem :%d :%d :%d :%d|h[%s]|h%s.'
LOOT_ITEM_SELF_MULTIPLE = 'You receive loot: %sx%d.'

Minimap = {
    GetWidth = function () return 200 end,
}

UIErrorsFrame = { AddMessage = function(instance, message, r, g, b)
    UIErrorsFrame.messageArg = message
    UIErrorsFrame.rArg = r
    UIErrorsFrame.gArg = g
    UIErrorsFrame.bArg = b
end }

UnitAffectingCombat = function (unit) return true end

UnitGUID = function (unit)
    if unit == 'player' then
        return 'test-player-guid'
    end
end

UnitLevel = function (unit) return 60 end

UnitName = function (unit)
    if unit == 'player' then
        return 'test-player-name'
    end
end

SlashCmdList = {}