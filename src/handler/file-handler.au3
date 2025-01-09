#include-once
#include "../init.au3"

Func _WriteFile($sFile, $sText)
    Local Const $iUtf8WithoutBomAndOverwriteCreationMode = 256 + 2 + 8

    Local $hFile = FileOpen($sFile, $iUtf8WithoutBomAndOverwriteCreationMode)
    FileWrite($hFile, $sText)
    FileClose($hFile)
EndFunc

Func _ReadFile($sFile)
    Local Const $iUtf8WithoutBomMode = 256

    Local $hFile        = FileOpen($sFile, $iUtf8WithoutBomMode)
    Local $sFileContent = FileRead($hFile)
    FileClose($hFile)

    Return $sFileContent
EndFunc
