

This program requires: 

## handbrakecli
(command line interface)
which you can find on own from the official website
or 
specifically at:
**https://handbrake.fr/downloads2.php**



## ffprobe
which comes with ffmpeg

which you can find on own from the official website
or 
specifically at: 
**https://ffmpeg.org/download.html#build-windows**


I'm not really sure what would be best in terms of 
packaging dependancies and getting the location of them,
so to keep things flexible, I ask that you:
- **ensure that path_HandBrakeCLI.md points to a installed HandBrakeCLI.exe**
- **ensure that path_ffprobe.md points to a installed ffprobe.exe**

## Extra Details:
I couldn't figure out how to display progress through AHK, 
so I just made in write up a powershell script and then execute it.
The full process is:
- display drop UI
- wait for dropped item
- get ffprobe path and ask it for the duration of the file
- calculate the needed average bitrate needed to ensure a filesize less than 10MB
- get handbrakecli path and set up the powershell script ('ReEncode.ps1') with the parameters
- parameters are set inside a premade preset.json
- a final param is added at the end to overwrite the bitrate option in preset.json
- finally we just run the powershell script which just runs handbrakecli and displays progress
- wait until it finishes and then exit

If anyone knows a better way to do all this, 
please feel free to push a pull-request to the git repo, 
the help would be much appreciated!

\- blank
