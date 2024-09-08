# ch(ange)icon

Set and remove custom icons on macOS files and folders

## Features

1. Set, remove, and test for custom icons
2. Apply many icons at once, driven by config files

```
% chicon
OVERVIEW: set and remove custom icons

USAGE: chicon <subcommand>

OPTIONS:
  -h, --help              Show help information.

SUBCOMMANDS:
  bulk                    Applies icons in bulk, based on configuration file in .config
  set                     Applies a custom icon to a target
  rm                      Removes a custom icon from a target
```

## Building

```bash
xcodebuild -scheme chicon -configuration Release -archivePath ./build/Release clean archive && \
cp ./build/Release.xcarchive/Products/usr/local/bin/chicon ./build && \
rm -rf ./build/Release.xcarchive

# binary @ ./build/chicon
```

## Motivation

I like using custom icons for apps in my dock. :~) When apps update, the icon reverts, requiring them to be reapplied often for certain apps. 

I hadn't found the perfect tool for this job. [fileicon](https://github.com/mklement0/fileicon/tree/master) is awesome, but setting many icons at once takes a non-negligible amount of time and requires orchestration.

<div align="center">
  <img width="516" alt="Screenshot of dock with custom app icons" src="https://github.com/user-attachments/assets/fe49d0ba-f51a-4f8b-9063-41b5fb6e9e9a">
</div>

## Credits

This is only possible because of [fileicon](https://github.com/mklement0/fileicon/tree/master). This is just a Swift reimplementation of its logic, and there's no way I'd ever have figured out how to implement it without having it as a reference.
