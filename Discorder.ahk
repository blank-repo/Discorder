#SingleInstance Force
KeyHistory 0
#Requires AutoHotkey v2.0
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.
; TraySetIcon("C:\Users\rocket\_util\_Custom_Icon\Skull_Boi\Skull5.ico", 1, freeze := true)


MyGui := Gui(, "Discorder")
MyGui.SetFont("s32")
MyGui.Opt("+AlwaysOnTop +ToolWindow -SysMenu +Owner")  ; +Owner avoids a taskbar button.
MyGui.MenuBar := ""

guictrl := MyGui.Add("ListBox", "r10 x0 w600 vChoice", ["Drop Video Here"])
MyGui.OnEvent("DropFiles", Gui_DropFiles , 1)

MyGui.Show("NoActivate")  ; NoActivate avoids deactivating the currently active window.

ih := InputHook("L1", "{Space}{Enter}")
ih.Start()
ih.Wait()

guiData := MyGui.Submit()

if(ih.EndKey != "Space" and ih.EndKey != "Enter"){
	return
}

Gui_DropFiles(GuiObj, GuiCtrlObj, FileArray, X, Y) {
	guiData := MyGui.Submit()
	ih.Stop()
	ffprobePath := A_WorkingDir "/bin/path_ffprobe.md"
	Loop Read, ffprobePath
	{
		ffprobe := a_LoopReadLine
		break
	}

	for i, DroppedFilePath in FileArray
		try
		{
			cmd := Format( '"{1}" -i "{2}" -show_entries format=duration -v quiet -of csv="p=0"', ffprobe, DroppedFilePath )

			shell := ComObject("WScript.Shell")

			fullCmd := A_ComSpec " /C "  "`"" cmd "`""
			exec := shell.Exec(fullCmd)
			cmdOutput := exec.StdOut.ReadAll()

			desiredSize := 9.8 ; minus small buffer (0.2 mb) to further accomodate any potential inaccuracies
			powerOf2ByBits := 8192
			withOverhead := 1.024

			if(InStr(cmdOutput,".")){
				strArray := StrSplit(cmdOutput,'.')
				secNum:= strArray[1]
			}else{
				secNum:= cmdOutput
			}
			if isInteger(secNum)
				totalSeconds:= Integer(secNum)

				audioBitRate := 128

				result := (desiredSize * powerOf2ByBits) / (totalSeconds * withOverhead) - audioBitRate ;Calculate total bitrate → Subtract audio bitrate

				strArray := StrSplit(result,'.')
				result := Integer(strArray[1])

				ReEncode(DroppedFilePath, result)

		}
		catch Error as e{
			MsgBox(e.Message)
		}
}

ReEncode(inputPath, bitrate) {
	try{
		handbrakePath := A_WorkingDir "/bin/path_HandBrakeCLI.md"
		Loop Read, handbrakePath
		{
			cliPath := a_LoopReadLine
			break
		}
		presetPath := A_WorkingDir "/bin/preset.json"

		strArray := StrSplit(inputPath,'.')
		outputPath := strArray[1] "+." strArray[2]

		cmd := Format('"{1}" -i "{2}" -o "{3}" --preset-import-file "{4}" -b {5}', cliPath, inputPath, outputPath, presetPath, bitrate)

		consolePath := A_WorkingDir "/bin/encode.ps1"

		file := FileOpen(consolePath, "w")
		{
			if !IsObject(file)
			{
				MsgBox "Can't open" consolePath "for writing."
				return
			}
			script .= "& " cmd "`n"
			file.Write(script)
		}
		file.Close()

		runcmd := Format('powershell.exe -ExecutionPolicy Unrestricted -File {1}', consolePath)

		RunWait(runcmd)

	}
	catch Error as e{
		MsgBox(e.Message)
	}
}

; todo: sanitize filenames
; todo: add logging
