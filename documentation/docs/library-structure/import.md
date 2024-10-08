---
sidebar_position: 3
title: Import
---

When a new version of the library is [built](build), it can be downloaded and updated
in an addon. The following steps describe how to import it for the first time. When
updating, focus on steps **2** and **4**, by replacing the existing library file and
the instantiation table name.

1. Create a `lib` directory in the addon root folder, so `lib` is at the same 
   level as the addon `.toc` files
1. Download `stormwind-library.lua` **OR** `stormwind-library.min.lua` from the
   [most recent release](https://github.com/adrianocastro189/stormwind-library/releases)
   into the folder created above
1. Update the addon `.toc` file by adding
   `lib\stormwind-library.lua` **OR** `lib\stormwind-library.min.lua`
1. Now, a library instance must be instantiated with `StormwindLibrary_vx_y_z.new()` 
   where `x_y_z` is the current library version