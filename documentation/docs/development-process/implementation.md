---
sidebar_position: 3
title: Implementation
---

The implementation phase starts by creating a new release branch that will be used as the base
branch for all the new version features.

1. Checkout `main` and pull the latest changes
1. Create a new branch named `release/version-x.y.0` where `x` is the major version and `y` is 
the minor version
1. Open the `src\stormwind-library.lua` file and update the version number in the comment where
it is defined
   ```lua
   -- Library version = 'x.y.0'
   ```
1. Open the `tests\unit.lua` file and update the version number in the library class name, where
its instance is referenced
   ```lua
   dofile('./dist/stormwind-library.lua')
   StormwindLibrary = StormwindLibrary_vx_y_0
   ```
1. Build the library and run the unit tests to make sure nothing is broken
1. Commit the changes with a message like `Bump version to x.y.0` and push the branch to the 
repository
1. Open a Pull Request with `Release - vx.y.0` as the title
1. From now, every new implementation should be created in a new branch from the release branch
1. The release PR will be merged in the deployment phase, when all the features are implemented, 
reviewed, and tested