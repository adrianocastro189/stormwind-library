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

    --[[--
    Determines whether the player has at least one pet from a given species.

    The C_PetJournal.GetOwnedBattlePetString() API method returns a colored
    string containing the number of pets owned by the player for a given
    species. Example: "|cFFFFD200Collected (1/3)"

    This method just checks if the string is not nil, which means the player
    has at least one pet from the given species.

    @tparam integer speciesId The species ID of the pet to check

    @treturn boolean Whether the player owns at least one pet from the given species
    ]]
    function PetJournal:playerOwnsPet(speciesId)
        return C_PetJournal.GetOwnedBattlePetString(speciesId) ~= nil
    end
-- end of PetJournal