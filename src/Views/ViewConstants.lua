--[[--
Constants for centralizing values that are widely used in view classes.

@table viewConstants

@field DEFAULT_BACKGROUND_TEXTURE The default background texture for windows
                                  and frames in general
]]
self.viewConstants = self.arr:freeze({
    DEFAULT_BACKGROUND_TEXTURE = 'Interface/Tooltips/UI-Tooltip-Background',
})