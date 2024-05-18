CreateFrame = function (...)
    local mockFrame = {
        ['events'] = {},
        ['scripts'] = {},
    }
    
    mockFrame.Hide = function (self) self.hideInvoked = true end
    mockFrame.EnableMouse = function (self, enable) self.mouseEnabled = enable end
    mockFrame.RegisterEvent = function (self, event) table.insert(self.events, event) end
    mockFrame.SetBackdrop = function (self, backdrop) self.backdrop = backdrop end
    mockFrame.SetBackdropBorderColor = function (self, r, g, b, a) self.backdropBorderColor = { r, g, b, a } end
    mockFrame.SetBackdropColor = function (self, r, g, b, a) self.backdropColor = { r, g, b, a } end
    mockFrame.SetHeight = function (self, height) self.height = height end
    mockFrame.SetHighlightTexture = function (self, texture) self.highlightTexture = texture end
    mockFrame.SetMovable = function (self, movable) self.movable = movable end
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
    mockFrame.SetSize = function (self, width, height) self.width = width self.height = height end
    mockFrame.SetScript = function (self, script, callback) self.scripts[script] = callback end
    mockFrame.SetText = function (self, text) self.text = text end
    mockFrame.Show = function (self) self.showInvoked = true end

    return mockFrame
end

GameTooltip = {
    HookScript = function (self, script, callback)
        self.scripts = self.scripts or {}
        self.scripts[script] = callback
    end
}

GetRealmName = function () return 'test-realm' end

UnitGUID = function (unit)
    if unit == 'player' then
        return 'test-player-guid'
    end
end

UnitName = function (unit)
    if unit == 'player' then
        return 'test-player-name'
    end
end