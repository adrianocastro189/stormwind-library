# API Mocks

The `tests/wow-mocks.lua` file contains a set of mocks for the World of 
Warcraft API. These mocks are used to simulate the behavior of the WoW API in 
a controlled environment, allowing addon developers to test their code 
without needing to run the game.

It's important to note that these mocks are not a complete replacement for
the WoW API nor behave like it. They are designed to provide a way to assert
that addons are interacting with the WoW API correctly.

As an example, it shouldn't be expected that events will be fired in the same
way they're fired in the game when listeners are registered to frames. It's
just a way to assert that the addon registers the listener correctly, and 
that's all for now.

:::note Look out for future implementations

Although the API Mocks are just a way to make a consistent environment for
testing, there are plans to make them more robust and closer to the real
WoW API in a way that they can provide more values to the tests.

Keep an eye on the updates to see what's new in the API Mocks.

:::

## Usage

To use the API Mocks in your tests, simply copy the `tests/wow-mocks.lua` file
to the `tests` directory of the addon.

Feel free to add more mocks, especially to the frame methods, as they are
the most used in the addons. Also, feel free to [open a PR](https://github.com/adrianocastro189/stormwind-library/fork)
with the new mocks so they can be shared with the community.