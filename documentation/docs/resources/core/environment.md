# Environment

Environment is a library resource used to identify the environment where the 
addon is running. By environment, it can be a specific game client version or 
even the unit test suite if the addon is being covered by tests.

It can serve for many purposes, from cosmetic changes to the addon interface
to the implementations based on available API functions that can be different
between game versions.

Once initialized, the Stormwind Library instance will have the environment
information available through the `environment` property.

## Usage

Introduced in the Stormwind Library version 1.2.0, the Environment class is
not instantiable by the [factory](factory.md) due to limitations regarding 
the lifecycle and order of initializations, considering that the factory 
itself depends on the environment.

Instead, its unique instance can
be accessed through the `environment` property of the library.

```lua
local environment = library.environment

if environment:getClientFlavor() == environment.constants.CLIENT_CLASSIC then
  -- do something specific to the Classic client
elseif -- ... other client flavors
```

### Available flavors

* `Environment.constants.CLIENT_CLASSIC`: The current World of Warcraft 
Classic client, which includes TBC, WotLK, Cataclysm, etc. It's important to 
mention that Blizzard calls "Classic" the current classic progression that
started in 2019 with Vanilla and then moved to TBC, WotLK, and so on.
* `Environment.constants.CLIENT_CLASSIC_ERA`: Classic Season of Discovery, 
Hardcore, and any other clients that have no expansions.
* `Environment.constants.CLIENT_RETAIL`: The current World of Warcraft Retail 
client, which is the most recent expansion.
* `Environment.constants.TEST_SUITE`: The unit test suite, that executes 
locally without any World of Warcraft client. This is important sometimes to
avoid calling API functions that are not meant to be called outside the game
and vice versa.

:::warning Note about classic flavors

When this class was designed, the Classic progression was close to the 
Cataclysm release, which made sense to separate it from the Classic Era 
flavor.

In case Blizzard changes the progression steps and creates something like a 
TBC Era, WoTLK Era, etc., the library may be updated to reflect these 
changes and introduce new constants.

Keep an eye on the library updates to check if new constants were added.

:::