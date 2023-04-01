#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#Include <GDIPlus.au3>
#include <File.au3>

_GDIPlus_Startup ()


$image = _GDIPlus_ImageLoadFromFile(FileReadLine(@ScriptDir & "\test.txt", 1))
If @error Then
    MsgBox(16, "Error", "Does the text file exist?")
    Exit 1
 EndIf

_FileWriteToLine(@ScriptDir & "\test.txt", 1, Int(_GDIPlus_ImageGetWidth($image)/960), True, True)
_GDIPlus_ImageDispose ($image)
_GDIPlus_ShutDown ()

Exit
