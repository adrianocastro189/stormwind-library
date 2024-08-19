# View Constants

To avoid hardcoding some values that can be reused in multiple places and that
can have a big chance to be changed in the future in the game (or even in the
library), the `src\Views\ViewConstants.lua` file was created to store these
values as frozen tables.

This is a list of the constants available in the file:

* `DEFAULT_BACKGROUND_TEXTURE`: The default texture used in the backdrop of 
windows and frames. This texture is available in the game and should not 
require any additional assets to work as a valid background texture.

## Usage

Just access the `viewConstants` table in your code and use the constants:

```lua
frame:SetBackdrop({
    bgFile = library.viewConstants.DEFAULT_BACKGROUND_TEXTURE,
    -- other backdrop properties
})
```