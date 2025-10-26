# Cyberpunk Log Viewer

### What's this?

Cyberpunk Log Viewer (CLV) is a small utility for Cyberpunk: 2077. If your game isn't modded, it's probably useless. Otherwise, it might save you half a headache when you're trying to locate logs when the game crashes.

### How does it work?

Just run CLV, locate your game folder, and it'll find all the logs for you. Then you can select a file and click on the button at the bottom to open it, or simply double click on the name, and a new window will open with the file contents.

You can also right-click on any file to copy the full path to the directory or file to your clipboard, or to open the file with a program of your choice.

### Installation

Head to the [releases](https://github.com/l1chorpe/cyberpunk-log-viewer/releases) section, download the version of CLV you want (latest recommended) and unzip it wherever you want. Then just double-click the EXE file.<sup>1</sup>

### Current limitations & roadmap (in no particular order)

- The files listed are not filtered/ordered. I also plan on adding a few filters and sorting types, including differentiating between "core" mods like CET and RED4ext, and "regular" mods.

- The UI is somewhat barebones. It's not Windows NT but don't expect a work of art. As I have discovered while making this, design is very time-consuming, and I'd rather spend more time programming new useful features than designing.

- **There is no syntax highlighting when viewing logs.** And it's extremely likely to stay this way, since everyone has their own way of writing logs. However, I have not researched at all about the subject so, if I find a way to make it happen *without too much hassle*, it will happen.

- There is no way to open folders containing the files.

- This is a very early release so things might break if you ask a bit too much out of it. No worries though, this will get fixed. However, due to the quantity of edge cases, this will take a while to complete, especially since new features always add new edge cases.

- There is no feedback when copying paths.

### Known bugs

- When opening the context menu (right click) on a log file in the list, the background is bigger than it should.

### List of folders checked by CLV (only if full search is disabled)

/bin/x64/plugins/cyber_engine_tweaks  
/r6/logs  
/red4ext/logs  
/red4ext/plugins  

### Appendix

<sup>1</sup>If you download CLV 1.0.1, make sure to keep the EXE and PCK files in the same folder, or CLV won't work.