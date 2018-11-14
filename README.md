# helldivers-cursor

[![poster](https://thumbs.gfycat.com/ImmaculateFalseHornet-poster.jpg)](https://gfycat.com/ImmaculateFalseHornet)

<p align="center">
    <em>
        <a href="https://gfycat.com/ImmaculateFalseHornet">Gfycat of the cursor in action</a>
    </em>
</p>

---

An [AHK](https://www.autohotkey.com/) script that adds an overlay cursor for the game [Helldivers](https://store.steampowered.com/app/394510/).

There is a "Crosshair Always Visible" setting, but all it adds is a blurry grey blob that is still very difficult to see.
- https://steamcommunity.com/app/394510/discussions/0/1734343065615613678/
- https://steamcommunity.com/app/394510/discussions/0/412446292765891245/

With this AHK script, it will render the `crosshair.png` image file on your cursor when the Helldivers window is active, allowing you to aim better.

### How To Use

1. If you do not have AHK installed,
    1. You can choose to trust me and download the compiled binaries in [Releases](https://github.com/altbdoor/helldivers-cursor/releases).
    1. Or you can [install AHK](https://www.autohotkey.com/download/) today!
1. If you have AHK installed,
    1. Download the [code base as a ZIP file](https://github.com/altbdoor/helldivers-cursor/archive/master.zip).
    1. Unzip the archive to where you want it to be.
1. Edit the `crosshair.png` as you see fit.
    1. Protip, the white color (`#fff`) will be rendered as transparent!
    1. Please keep the image size as 64 pixels square.
1. Double click on `helldivers_cursor.ahk` (or `helldivers_cursor.exe`, if you download the compiled binaries).
1. Enjoy!


### Additional Info

- The cursor overlay updates itself every 10 milliseconds. It might appear laggy at times, but thats [the best AHK could do](https://autohotkey.com/docs/commands/SetTimer.htm#Remarks).
- If something else is putting a heavy load on the CPU, the cursor might be even more laggy.
- The cursor hides itself when you `Alt+Tab` to another window. It will only show itself on Helldivers window.
