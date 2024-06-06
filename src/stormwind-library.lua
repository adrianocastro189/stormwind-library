-- Library version = '1.4.0'

-- import src/Core/DumpAndDie.lua

-- import src/Support/Arr.lua
-- import src/Support/Bool.lua
-- import src/Support/Str.lua

-- import src/Core/Environment.lua

-- import src/Core/AddonProperties.lua
-- import src/Core/Factory.lua

-- import src/Core/Configuration.lua
-- import src/Core/Output.lua

-- import src/Commands/Command.lua
-- import src/Commands/CommandsHandler.lua

-- import src/Facades/Events.lua
-- import src/Facades/EventHandlers/PlayerLoginEventHandler.lua
-- import src/Facades/EventHandlers/TargetEventHandler.lua
-- import src/Facades/Target.lua
-- import src/Facades/Tooltips/AbstractTooltip.lua
-- import src/Facades/Tooltips/ClassicTooltip.lua
-- import src/Facades/Tooltips/RetailTooltip.lua

-- @TODO: Move this to AbstractTooltip.lua once the library initialization callbacks are implemented <2024.05.04>
self.tooltip = self:new('Tooltip')
self.tooltip:registerTooltipHandlers()

-- import src/Models/Item.lua
-- import src/Models/Macro.lua
-- import src/Models/RaidMarker.lua
-- import src/Models/Realm.lua
-- import src/Models/Player.lua

-- import src/Views/Windows/Window.lua