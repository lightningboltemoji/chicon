# ch(ange)icon

Set and remove custom icons on macOS files and folders

## Features

1. Set, remove, and test for custom icons
2. Declarative `.config` support for applying icons in bulk

## Motivation

I like using custom icons for apps in my dock. :~)

When apps update, the icon reverts, requiring the custom icon to be reapplied often for certain apps. I hadn't found the perfect tool for this job. `fileicon` is awesome, but it leaves something to be desired in terms of performance (setting many icons takes a non-negligible amount of time) and requires orchestration.

<div align="center">
  <img width="516" alt="Screenshot of dock with custom app icons" src="https://github.com/user-attachments/assets/fe49d0ba-f51a-4f8b-9063-41b5fb6e9e9a">
</div>

## Credit

This is only possible because of [fileicon](https://github.com/mklement0/fileicon/tree/master). This is just a Swift reimplementation of its logic, and there's no way I'd ever have figured out how to implement it without having it as a reference.
