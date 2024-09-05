# Settings

Settings are basically [configuration](configuration) values that can be manipulated
by players with chat commands and UI elements.

It's important to note that the configuration structure is a base for this class as 
it is used to store the settings values for global and player scopes. The reason 
they're separated in two classes is to avoid confusion and handle settings properly.

A good example of the difference between the two: an addon that shows a small window
with a list of settings that can be toggled on and off. When a player moves this 
window, resizes it or even closes it, the window state is persisted by the 
**[configuration structure](configuration)**, which means the last position, size and
visibility are not directly set by players. But when they toggle the settings inside 
this window, the values are stored in the **settings structure**, described below.

And finally, configurations are only changed programmatically, while settings can be
changed by players by running chat commands and interacting with UI elements. And 
this is one of the settings motivations when designed: to allow automatic UI elements
to be created from the addon settings.