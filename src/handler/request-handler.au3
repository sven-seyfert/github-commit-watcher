#include-once
#include "../init.au3"

Func _ExecuteCommand($sCommand)
    Local Const $sRepoPath    = @ScriptDir
    Local Const $sDriveLetter = StringLeft($sRepoPath, 1)
    Local Const $sExecCommand = StringFormat( _
        '%s /C %s: && cd "%s" && %s', _
        @ComSpec, $sDriveLetter, $sRepoPath, $sCommand)

    Local Const $iStdOutFlag = 0x2
    Local Const $iPID = Run($sExecCommand, $sRepoPath, @SW_HIDE, $iStdOutFlag)
    If @error Then
        ConsoleWrite(StringFormat( _
            '[Run process error]\nExpected: PID of the process.\nReceived: No PID (error).\nOccurred in command: %s\n', _
            $sExecCommand))

        Exit -1
    EndIf

    Local Const $iSixSecondsTimeout = 6

    Local Const $iResult = ProcessWaitClose($iPID, $iSixSecondsTimeout)
    If $iResult == 0 Then
        ConsoleWrite(StringFormat( _
            '[Process wait error]\nExpected: No timeout.\nReceived: Timeout after %s seconds.\nOccurred in command: %s\n', _
            $iSixSecondsTimeout, $sExecCommand))

        Exit -1
    EndIf

    Return StdoutRead($iPID)
EndFunc
