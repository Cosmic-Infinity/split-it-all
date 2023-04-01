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


$path = FileReadLine(@ScriptDir & "\test.txt", 1)
;$path = '"' & $path & '"'
;MsgBox(16, "Found", $path)
;Sleep(1000)

$image = _GDIPlus_ImageLoadFromFile($path)

If @error Then
    MsgBox(16, "Error", "Does the image file exist? " & $path)
    Exit 1
 EndIf

_FileWriteToLine(@ScriptDir & "\test.txt", 1, Int(_GDIPlus_ImageGetWidth($image)/960), True, True)
_GDIPlus_ImageDispose ($image)
_GDIPlus_ShutDown ()

Exit
