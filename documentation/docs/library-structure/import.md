---
sidebar_position: 3
title: Import
---

When a new version of the library is [built](build), it's time to import it
in the addon:

1. Create a the `./lib/stormwind-library` directory in the addon root folder,
so `lib` is at the same level as the addon `.toc` file
2. Copy the `./dist/stormwind-library.lua` file from the library repository into
the folder created above
3. Update the addon `.toc` file by adding `lib\stormwind-library\stormwind-library.lua`
4. Now, a library instance must be instantiated with `StormwindLibrary_vx_y_z.new()` where `x_y_z`
is the current library version