---
sidebar_position: 4
title: Deployment
---

When the library version is finished, tested and ready to be deployed, the 
following steps should be followed:

1. Checkout the **release branch** created in the
[implementation](implementation) phase
1. Make sure all [tests](../testing/unit-suite) are passing
   * For the distribution file
   * For the minified distribution file
1. Generate the [LuaDocs files](../library-structure/luadocs) and push them 
to the repository with **"Update LuaDocs"** as the commit message
1. Open the `documentation/docs/changelog.md` file and update the release
date placeholder with the current date and push it to the repository with
**"Update vx.y.z release date"** (of course, replacing `x.y.z` with the
current version being deployed)
1. Go to the release PR in GitHub, take a quick look at the changes, and
merge it
1. Create a [new release](https://github.com/adrianocastro189/stormwind-library/releases/new):
   * The tag name is the raw version number, like `1.0.0` 
   * The release title is the same, but with a `v` prefix, like `v1.0.0`
   * The release notes are created with the **Generate release notes** 
     button
   * **Important:** Upload both `dist/stormwind-library.lua` and
     `dist/stormwind-library.min.lua` compiled files release assets
1. Checkout the `main` branch and pull the latest changes
1. Deploy the documentation to
[GitHub Pages](https://www.stormwindlibrary.com) using the `npm` commands
described [here](../library-structure/docs)
   * Check the [GitHub actions page](https://github.com/adrianocastro189/stormwind-library/actions)
   and wait until the **page build and deployment** job is finished to have
   all the changes available in the live documentation