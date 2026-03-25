
## Dependencies:


## handbrakecli
(command line interface)
which you can find on own from the official website
<br>
or
<br>
specifically at:
<br>
**https://handbrake.fr/downloads2.php**
<br>
or
### Linux
    flatpak install fr.handbrake.ghb




## ffprobe
which comes with ffmpeg

which you can find on own from the official website<br>
or <br>
specifically at: <br>
**https://ffmpeg.org/download.html**


#


~~both requirements are shipped with releases.~~

## Note:
You **must** point the program to installed dependencies:<br>
|  | Linux | Windows |  |
| --- | --- | --- | --- |
| HandBrakeCLI | the output from<br>`which fr.handbrake.ghb` | location of<br>`HandBrakeCLI.exe` | via line 1 of<br>`resources/path_handbrake.md` |
| ffprobe | the output from<br>`which ffprobe` | location of<br>`ffprobe.exe` | via line 1 of<br>`resources/path_ffprobe.md` |

---

<br>
<br>

## v1.0.7 Update:
<br>
Windows is not currently supported.
<br>
I moved to Linux, and I haven't figured out how to get Mingw working for Windows builds.
<br>
Until such at time as I do, or someone let's me use their Windows machine dev/build, releases will be Linux only.
<br>
Sorry.
<br>
<br>

While the new source code is left out,
<br>

the program is now entirely cpp, 
using 
<br>

[Dear ImGui](https://github.com/ocornut/imgui),
<br>

[SDL3](https://www.libsdl.org/) 
and 
<br>

[Vulkan](https://www.vulkan.org/).

<br>
Changes:
<br>

- press **Escape**, **Alt+F4** or right-click the taskbar entry and choose 'close' to exit.
- you can also just **open with** Discorder now<br>_if you set the default to Discorder then change it back to whatever it was before, <br>Discorder should show up in the open with menu._
- if the video you're converting is less than ~9MB Discorder will use the slowpreset otherwise it'll use the normal one.<br>
_The reasoning is if a video is that small it won't take that long to re-encode it anyway,<br>so might as well ensure the best quality possible._
- Not really a change, but worth noting that all files will be converted to `.mp4` for maximum compatibility however,<br>options for this can be added in the future.
- Lastly, you can replace the preset files with your own, just export a preset from handbrake.<br>
_(or copy the `preset.json` contents into `slowpreset.json`)_
<br>
<br>
for Linux, I tried just reading the `which` cmd output but flatpak installs to a non-path directory,
<br>
so using the user-pointed method is still the best option.
<br>
<br>

## Extra Details:
~~I couldn't figure out how to display progress through AHK,
so I just made in write up a powershell script and then execute it.~~
<br>
<br>
The full process is:
- display drop UI
- wait for dropped item
- get ffprobe path and ask it for the duration of the file
- calculate the needed average bitrate to ensure a filesize less than 10MB
- get handbrakecli path
~~and set up the powershell script ('ReEncode.ps1') with the parameters~~
- parameters are set inside a premade `preset.json` & `slowpreset.json`
- a final param is added at the end to overwrite the bitrate option in `preset.json`
- then we just run ~~the powershell script which just runs~~ handbrakecli and display progress
- wait until it finishes and exit

\- blank
