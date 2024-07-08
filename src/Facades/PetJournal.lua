--[[--
Facade for the PetJournal API.

Although C_PetJournal is available in the CLASSIC_ERA clients, this facade is
not instantiable there considering that its functions are not functional.

@classmod Core.PetJournal
]]
local PetJournal = {}
    PetJournal.__index = PetJournal
    PetJournal.__ = self
    self:addClass('PetJournal', PetJournal, {
        self.environment.constants.TEST_SUITE,
        self.environment.constants.CLIENT_CLASSIC,
        self.environment.constants.CLIENT_RETAIL,
    })

    --[[--
    PetJournal constructor.
    ]]
    function PetJournal.__construct()
        return setmetatable({}, PetJournal)
    end
-- end of PetJournal