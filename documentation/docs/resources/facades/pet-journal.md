# PetJournal

`PetJournal` encapsulates the `C_PetJournal` API methods to provide 
specific queries and was designed initially to get information about species
IDs, which is something that requires a few steps to get from the original API
method.

Still, this facade will be updated in case the original pet journal API is
changed for the next expansions and will likely grow to include more methods
by addons demands.

## Usage

Different from other facades, Stormwind Library doesn't provide a default 
instance for this class in a property given that it's not instantiable in the
Classic Era clientes like Hardcore or Season of Discovery.

Although Classic Era clients have the `C_PetJournal` table available, they're 
apparently not functional, at least at the time of writing this documentation.

Addons must instantiate the `PetJournal` class to use it.

```lua
local petJournal = library:new('PetJournal')
```

* See the [LuaDocs documentation](pathname:///lua-docs/classes/Facades.PetJournal.html) for a list of available methods.