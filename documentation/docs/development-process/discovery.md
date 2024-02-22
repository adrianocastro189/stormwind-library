---
sidebar_position: 1
title: Discovery
---

The discovery process walks side by side with the **addon development** and with **versioning** the library.

When an addon is being planned, it will likely require accessing World of Warcraft exposed functions and
resources like events, target information, etc. Everything that can be encapsulated in the Stormwind Library
and have a friendly facade will be detailed in a discovery document.

A discovery document can be anything: a notepad note, a Google Document on the cloud, etc. It basically describes
what's about to be implemented in the new library version alongside with a couple of checkboxes to make sure
the implementation phase follows all the steps to the deploy like:

1. Update the changelog
1. Update the library version

When written, the discovery document describes new methods, classes, facades, etc, and attempts to breakdown them
in atomic and short tasks that will have their own git branch. Those branches are better explained in the
implementation section of this documentation.

Once all the demands of the next library version are listed, described and split into tasks, the discovery document
is considered done, so the next version is ready to be implemented.

## Process steps

Based on what's said above, this is the process to follow **for each new library version**:

1. Make a copy of the discovery model
1. Update its placeholders and **bump a new minor version** by checking the current library version
(it can be changed later)
1. Start planning an addon, and list all the World of Warcraft resources that must be accessed. Then ask:
   * Can they be encapsulated in the library?
   * Can their results be mapped in a class or data object?
   * Can they be accessed in a library helper function?
1. If any of the questions above is true, keep following the process
1. Open the discovery document and write one section per resource
1. Attempt to detail each of the sections as a good move to plan changes with minimum impact on the current code
and also to anticipate bugs and conflicts
1. Once the section is well described, split what needs to be done in a table, where each row will later
represent a git branch
1. Finally, when the document is well described, go back to the new library version and review what needs to
be done in that document to update it:
   * Bug fixes, small tweaks and non breaking changes: bump a patch version
   * New facade methods, resources and mapping objects: bump a minor version
   * Significant changes that will likely require the addons to also review the updates and make changes: bump a
major version

## Example

An addon needs to run a method every time the player enters in combat, but there's nothing on that in the library
yet:

1. Open or create a new discovery document
1. Do some research on how can we identify a player entered in combat with what's available in World of Warcraft
1. Write how that's possible and how can we add an event like that in the Stormwind Library
1. Break down all the steps into atomic and tasks that are easy to review
1. Alongside with all the required changes, select a version to bump the library
1. Consider the discovery done