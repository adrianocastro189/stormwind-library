---
sidebar_position: 2
---

# Changelog

## yyyy.mm.dd - version 1.12.1

## 2024.08.20 - version 1.12.0

* Add the [Interval:startImmediately()](resources/support/interval#usage) method
* Add the [MinimapIcon](resources/views/minimap-icon) class to easily minimap icons
* Add the [Window:toggleVisibility()](resources/views/window#showing-and-hiding-the-window) method
* Fix a couple of doc tag namespaces in the Facades package
* Introduce the concept of [spies](testing/test-classes#spies) in the testing suite, 
  still experimental

## 2024.08.01 - version 1.11.0

* Add "version" to the
  [addon initialization properties](resources/core/addon-properties#version)
* New structure to allow multiple test scenarios using the same test body called
  [TestCase](testing/test-classes#working-with-test-cases)

## 2024.07.26 - version 1.10.0

* Allow [dot notation keys](resources/support/arr#dot-notation-keys) to also 
  contain numbers when retrieving values from tables
* Remove the Output:say() method due to revisions in the SendChatMessage API

## 2024.07.19 - version 1.9.0

* A complete rewrite of the Window class content management to introduce 
  [content pages](resources/views/window#adding-content-to-the-window)
* Add a count utility method to the Arr class
* Add the [Callback Loader](resources/core/callback-loader) mechanism to
  invoke functions after the library is fully loaded

## 2024.07.10 - version 1.8.0

* Add a [facade class](resources/facades/pet-journal) to the C_PetJournal API 
table (Retail only for now)
* Add a flag to the [Container](resources/models/container#the-outdated-flag)
and [Inventory](resources/models/inventory#the-outdated-flag) models
to indicate that their items lists are outdated and need to be refreshed
* New [Interval class](resources/support/interval) to execute callback 
functions at a specified interval in seconds
* ~New Output method to make the player say something in the chat frame~ 
  (removed in v1.10.0)
* New [view constants file](resources/views/constants) to store values that 
can be reused in multiple view classes and instances

## 2024.07.04 - version 1.7.0

* Add a facade method to
[print messages in the UI error frame](resources/core/output#the-error-method)
* Add a new helper method to Arr that determines if a table has a specific key
* Add the new ["inCombat" property](resources/models/player#player-in-combat-status)
to the Player model to track the player's combat status
* Compiling the library now also generates a
[minified version](library-structure/build) of the library
* New events to broadcast player
[entering](resources/facades/events#player_entered_combat) and
[leaving](resources/facades/events#player_left_combat) combat statuses

## 2024.06.28 - version 1.6.0

* Factory and class structures now support the concept of
  [abstract classes](resources/core/factory#abstract-classes)
* Factory now offers methods to provide
  [class inheritance](resources/core/factory#class-inheritance)


## 2024.06.18 - version 1.5.0

* Add a level property to the Player model and update the current player instance automatically when the player levels up
* Allow commands to register
[argument validators](resources/commands/command#validating-arguments)
* Default to the
[help operation](resources/commands/commands-handler#the-help-operation)
when it's missing in the addon main slash command
* Watch for the [PLAYER_LEVEL_UP](resources/facades/events#player_level_up) 
event and forward it to the library listeners

## 2024.06.11 - version 1.4.0

* Add a factory to create item instances from multiple sources
* Add new helper methods to Arr
* Add the Container model to map the backpack, bags, bank slots, etc
* Add the id property to the Item model
* Inventory tracking (still experimental)

## 2024.05.24 - version 1.3.0

* Documentation published on [GitHub Pages](https://www.stormwindlibrary.com)
* Finish covering all classes with LuaDoc blocks
* Fix Events:notify() to properly handle multiple arguments
* Move the dd() method to a better location in the library structure, 
allowing it to be used before the Output class is registered
* Move the generated LuaDoc files inside the docusaurus folder
* Move World of Warcraft API mocks to a new reusable file separated from 
the unit suite

## 2024.05.08 - version 1.2.0

* Add the Environment class to identify the environment where the addon is 
running
* Add the Item model to map game items and their properties
* Add the library playerConfig() method to access player-specific configurations
* Add the Player model to map player information
* Add the Realm model to map realm information
* Add the Tooltip facade to handle tooltip events
* Allow classes to define constants with the Arr:freeze() method
* Allow window instances to have their state saved to player configurations 
(still defaults to global)
* Fix an issue with dd() when called in test units causing the terminal 
color to be changed permanently
* Fix an issue with parsing command arguments when they mix single and double
quotes
* Update the library Factory to allow classes to be instantiated in specific
World of Warcraft versions if necessary

## 2024.04.25 - version 1.1.0

* Add a "dump and die" method to the Output class to improve debugging
* Add a new property to initialize the library that allows addons to have a 
class managing configurations and settings with facades to Arr
* Add more LuaDoc blocks covering the library structure: to all classes in 
the Commands structure, and to Output
* Add the Configuration class to handle addon configurations and settings
* Add the library getClass() method to allow addons to retrieve a class 
structure instead of instantiating it, useful for class inheritance
* Add the reusable Window class that allows addons to create windows with
basic features
* Fix Arr:get() to return false values instead of considering them nil and
return the default value erroneously

## 2024.04.10 - version 1.0.0

* Add code documentation with [ldoc](https://github.com/lunarmodules/ldoc)
* Add Target methods to get the target current raid mark
* Allow the Output class to be switched to test mode

## 2024.04.03 - version 0.0.8-alpha

* Add a new support class to handle bool values
* Add new support methods to Str
* Reset the library instance for each test method for better mocking and less garbage between test cases

## 2024.03.29 - version 0.0.7-alpha

* Add the Events facade class to serve as a way to improve event handling
    * Listen to PLAYER_LOGIN
    * Listen to PLAYER_TARGET_CHANGED and split it into three events
* Add the CommandsHandler class to allow addons to register commands
* Add the Output class to replace print() calls
* Add the RaidMarker model class and the library's possible marker instances
* Allow passing addon properties to the library

## 2024.03.16 - version 0.0.6-alpha

* Add the Str support class
* Allow addons to register classes to be instantiated
* Improvements to the Target facade resources
* New Arr support class methods

## 2024.03.08 - version 0.0.5-alpha

* Add the Target facade
* Add the Unit Test Suite

## 2024.02.29 - version 0.0.4-alpha

* Add the Macro class
* Add the Factory structure