---
sidebar_position: 2
title: Build
---

All the library code is written inside the `./src` folder and split into multiple `.lua` files.

This initial build method is pretty rough and should be updated in the future, but it works in
a very simple way:

1. Open the command line
1. Navigate to `./compiler`
1. Run `node build.js`

After that, a file called `stormwind-library.lua` is created in the `./dist` folder.

This is the file that must be imported by the addons.