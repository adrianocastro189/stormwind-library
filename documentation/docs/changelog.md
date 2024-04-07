# Changelog

## yyyy.mm.dd - version 1.0.0

* Add code documentation with [ldoc](https://github.com/lunarmodules/ldoc)

## 2024.04.03 - version 0.0.8-alpha

* Add a new support class to handle bool values
* Add new support methods to Str
* Reset the library instance for each test method for better mocking and less garbage between test cases

## 2024.03.29 - version 0.0.7-alpha

* Add the Events facade class to serve as a way to improve event handling
    * Listen to `PLAYER_LOGIN`
    * Listen to `PLAYER_TARGET_CHANGED` and split it into three events
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