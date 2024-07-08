--[[--
Facade for the PetJournal API.

Although C_PetJournal is available in the CLASSIC_ERA clients, this facade is
not instantiable there considering that its functions are not functional. For
that reason, StormwindLibrary won't hold a default instance of this class like
it does for other facades. Instead, addons must create their own instances of
this class when needed.

@classmod Facades.PetJournal
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
    Gets the species id of the pet currently summoned by the player.

    If the player has no pet summoned, this method returns nil.

    Note that this method doesn't return the pet identifier, or GUID, which
    means the returned id is the species id of the pet, not the pet itself.

    @treturn integer|nil The currently summoned pet species id, or nil if no pet is summoned
    ]]
    function PetJournal:getSummonedPetSpeciesId()
        local petGuid = C_PetJournal.GetSummonedPetGUID()

        if petGuid then
            -- this sanity check is necessary to avoid Lua errors in case no
            -- pet is summoned
            return C_PetJournal.GetPetInfoByPetID(petGuid)
        end

        return nil
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