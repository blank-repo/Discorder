

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





both requirements are shipped with releases.

you can point to a installed HandBrakeCLI.exe via path_HandBrakeCLI.md
and point to a installed ffprobe.exe via path_ffprobe.md

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

\- blank
