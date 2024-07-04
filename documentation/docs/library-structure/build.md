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

After that, a file called `stormwind-library.lua` is created in the `./dist` 
folder and since 1.7.0, another file called `stormwind-library.min.lua` was
also produced, containing the minified version of the library.

This is the file that must be imported by the addons.

## Building with Visual Studio Code and tasks.json

If you're using Visual Studio Code, you can create a file called `tasks.json`
in the `./.vscode` folder to crate a couple of useful tasks instead of
running the commands manually.

This is just an example of how you can create tasks to build the library,
run the tests, manage the documentation, etc.

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Build ldoc documentation",
            "type": "shell",
            "options": {
                "cwd": "./dist"
            },
            "command": "ldoc stormwind-library.lua -d ../documentation-ldoc -v",
            "problemMatcher": []
        },
        {
            "label": "Build library",
            "type": "shell",
            "options": {
                "cwd": "./compiler"
            },
            "command": "node build",
            "problemMatcher": []
        },
        {
            "label": "Build library, ldoc, and test",
            "dependsOrder": "sequence",
            "dependsOn": ["Build library", "Build ldoc documentation", "Run unit tests"],
            "problemMatcher": []
        },
        {
            "label": "Run documentation",
            "type": "shell",
            "options": {
                "cwd": "./documentation"
            },
            "command": "npx docusaurus start",
            "problemMatcher": []
        },
        {
            "label": "Run unit tests",
            "type": "shell",
            "command": "lua54 ./tests/unit.lua -v",
            "problemMatcher": []
        }
    ]
}
```