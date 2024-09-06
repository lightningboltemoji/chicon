# ch(ange)icon

Set and remove custom icons on macOS files and folders

## Features

1. Set, remove, and test for custom icons
2. Define a list of icons in `.config` & apply them in bulk

## Motivation

I like using custom icons for my dock :~)



In general, when apps update, the icon reverts, requiring the custom icon to be reapplied often for certain apps. I hadn't found the perfect tool for this job. `fileicon` is awesome, but it leaves something to be desired in terms of performance (setting many icons takes a non-negligible amount of time) and requires orchestration.

## Credit

This is only possible because of [fileicon](https://github.com/mklement0/fileicon/tree/master). This is just a Swift reimplementation of its logic, and there's no way I'd ever have figured out how to implement it without having it as a reference.
