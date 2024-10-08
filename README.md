# ch(ange)icon

<div align="center">
  <p>Set and remove custom icons on macOS files and folders</p>
  <img width="516" alt="Screenshot of dock with custom app icons" src="https://github.com/user-attachments/assets/fe49d0ba-f51a-4f8b-9063-41b5fb6e9e9a">
  <br/> <br/>
  <p><a href="https://macosicons.com">macosicons.com</a> is a great source for icons! (no affiliation)</p>
  <p><sup>Warning ⚠️ I've never written anything in Swift, so expect this to suck</sup></p>
</div>

## Subcommands

### Set (`set`)

Applies a custom icon to a file or folder. This should work with many different image formats.

```
chicon set /Applications/kitty.app ~/Desktop/kitty.png
```

### Remove (`rm`)

Removes a custom icon that's been previously applied.

```
chicon rm /Applications/kitty.app
```

### Bulk (`bulk`)

Performs many `set` operations in parallel based on the contents of a JSON configuration file. 

By default, uses the configuration at `~/.config/chicon/chicon.json`. 

If an image path is not absolute (i.e. doesn't start with `/`), it's resolved relative to the configuration file's directory. In general, it's recommended to put the images in the same directory as the configuration file.

```
chicon bulk
```
```
chicon bulk /path/to/custom/config.json
```

Example configuration:
```
$ cat ~/.config/chicon/chicon.json 
{
  "/Applications/Amazon Chime.app": "Amazon Chime.icns",
  "/Applications/Microsoft Outlook.app": "Microsoft Outlook.icns",
  "/Applications/Obsidian.app": "Obsidian.icns",
  "/Applications/Slack.app": "Slack.png",
  "/Applications/Spotify.app": "Spotify.png",
  "/Applications/Visual Studio Code.app": "Visual Studio Code.icns",
  "/Applications/Zed.app": "Zed.icns",
  "/Applications/kitty.app": "kitty.icns"
}
```

## Building

```bash
xcodebuild -scheme chicon -configuration Release -archivePath ./build/Release clean archive && \
cp ./build/Release.xcarchive/Products/usr/local/bin/chicon ./build && \
rm -rf ./build/Release.xcarchive
```

This will generate a binary @ `./build/chicon`.

## Motivation

When apps update, the icon reverts, requiring custom icons to be reapplied often. I hadn't found the perfect tool for this job. [fileicon](https://github.com/mklement0/fileicon/tree/master) is awesome, but setting many icons at once takes a non-negligible amount of time and requires orchestration. I wanted a declaritive solution that made use of `.config` and applied many icons very quickly.

## Credits

This is only possible because of [fileicon](https://github.com/mklement0/fileicon/tree/master). This is just a Swift reimplementation of its logic, and there's no way I'd ever have figured out how to implement it without having it as a reference.
