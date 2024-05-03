# Changelog

## yyyy.mm.dd - version 1.2.0

* Add the Environment class to identify the environment where the addon is 
running
* Allow classes to define constants with the Arr:freeze() method
* Fix an issue with dd() when called in test units causing the terminal 
color to be changed permanently
* Update the library Factory to allow classes to be instantiated in specific
World of Warcraft versions if necessary

## 2024.04.25 - version 1.1.0

* Add a "dump and die" method to the Output class to improve debugging
* Add a new property to initialize the library that allows addons to have a 
class managing configurations and settings with facades to Arr
* Add more Lua Doc blocks covering the library structure: to all classes in 
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