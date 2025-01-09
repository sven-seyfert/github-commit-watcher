#pragma compile(FileVersion, 0.1.0)
#pragma compile(LegalCopyright, © Sven Seyfert (SOLVE-SMART))
#pragma compile(ProductVersion, 0.1.0 - 2025-01-08)
#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Outfile_x64=..\build\github-commit-watcher.exe
#AutoIt3Wrapper_Run_Au3Stripper=y
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=y
#Au3Stripper_Parameters=/sf /sv /mo /rm /rsln
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
Func _ExecuteCommand($sCommand)
Local Const $sRepoPath    = @ScriptDir
Local Const $sDriveLetter = StringLeft($sRepoPath, 1)
Local Const $sExecCommand = StringFormat(  '%s /C %s: && cd "%s" && %s',  @ComSpec, $sDriveLetter, $sRepoPath, $sCommand)
Local Const $iStdOutFlag = 0x2
Local Const $iPID = Run($sExecCommand, $sRepoPath, @SW_HIDE, $iStdOutFlag)
If @error Then
ConsoleWrite(StringFormat(  '[Run process error]\nExpected: PID of the process.\nReceived: No PID (error).\nOccurred in command: %s\n',  $sExecCommand))
Exit -1
EndIf
Local Const $iSixSecondsTimeout = 6
Local Const $iResult = ProcessWaitClose($iPID, $iSixSecondsTimeout)
If $iResult == 0 Then
ConsoleWrite(StringFormat(  '[Process wait error]\nExpected: No timeout.\nReceived: Timeout after %s seconds.\nOccurred in command: %s\n',  $iSixSecondsTimeout, $sExecCommand))
Exit -1
EndIf
Return StdoutRead($iPID)
EndFunc
Func _SendWebExNotification($sMessage)
Local Const $sCurlProgressBar = '--silent'
Local Const $sCurlTimeout     = '--connect-timeout 8 --max-time 10'
Local Const $sCommand = StringFormat(  'curl --request POST --header "Content-Type: application/json" "%s" -d "{\"markdown\": \"%s\"}" %s %s %s',  _B64Ex2Str('eyx7zL4PSEv.cdaHR0cHM6Ly93ZWJleGFwaXMuY29tL3YxL3dlYmhvb2tzL2luY29taW5nL1kybHpZMjl6Y0dGeWF6b3ZMM1Z6TDFkRlFraFBUMHN2WWpFMU4yWmpNR0V0TURGbE5DMDBZV0UwTFRnNVlqUXRaRGd4TVRkaU5qTTRaV0Zo8eO95C.h9t0yN3VxcV3hTs79x8trEpR'),  $sMessage,  $sCurlTimeout,  $sCurlProgressBar)
_ExecuteCommand($sCommand)
EndFunc
Func _StrToB64Ex($sData)
Local Const $oXml = ObjCreate('MSXML2.DOMDocument')
Local $oNode = $oXml.createElement('b64')
$oNode.dataType = 'bin.base64'
$oNode.nodeTypedValue = StringToBinary($sData)
Return StringFormat('ey%s.%s%s%s.%s', _Chars(9), _Chars(2), StringReplace($oNode.Text, '=', '-'), _Chars(6), _Chars(24))
EndFunc
Func _Chars($iLength)
Local $sRes = ''
Local $aChars[3]
For $i = 1 To $iLength Step 1
$aChars[0] = Chr(Random(65, 90, 1))
$aChars[1] = Chr(Random(97, 122, 1))
$aChars[2] = Chr(Random(48, 57, 1))
$sRes &= $aChars[Random(0, 2, 1)]
Next
Return $sRes
EndFunc
Func _B64Ex2Str($vData)
$vData = StringTrimRight(StringTrimLeft(StringReplace($vData, '-', '='), 14), 31)
Local $aCrypt  = DllCall('Crypt32.dll', 'bool', 'CryptStringToBinaryA', 'str', $vData, 'dword', 0, 'dword', 1, 'ptr', 0, 'dword*', 0, 'ptr', 0, 'ptr', 0)
Local Const $bBuffer = DllStructCreate('byte[' & $aCrypt[5] & ']')
$aCrypt = DllCall('Crypt32.dll', 'bool', 'CryptStringToBinaryA', 'str', $vData, 'dword', 0, 'dword', 1, 'struct*', $bBuffer, 'dword*', $aCrypt[5], 'ptr', 0, 'ptr', 0)
Return BinaryToString(DllStructGetData($bBuffer, 1))
EndFunc
_Main()
Func _Main()
Local Const $sGitHubUrl       = 'https://api.github.com/repos'
Local Const $sEndpoint        = 'commits?per_page=1'
Local Const $sJqCommand       = 'jq.exe -r ".[0].commit.message"'
Local Const $sCurlProgressBar = '--silent'
Local Const $sCurlTimeout     = '--connect-timeout 8 --max-time 10'
Local $sGitHubUsername, $sGitHubRepoName
Local $sCommand, $sResponse, $sFileContent
Local Const $iFirstOccurenceFromRightSideFlag = -1
Local Const $iRepositoryCount = _GetRepositoryCount() - 1
For $i = 0 To $iRepositoryCount
$sGitHubUsername = _GetRepositoryUsername($i)
$sGitHubRepoName = _GetRepositoryRepoName($i)
$sCommand = StringFormat( 'curl -H "Accept: application/vnd.github.v3+json" "%s/%s/%s/%s" %s %s | ..\lib\%s', $sGitHubUrl, $sGitHubUsername, $sGitHubRepoName, $sEndpoint, $sCurlProgressBar, $sCurlTimeout, $sJqCommand)
$sResponse = _ExecuteCommand($sCommand)
$sResponse = StringReplace($sResponse, @CRLF, '')
Local $sFile = StringFormat('..\output\%s-%s.txt', $sGitHubUsername, $sGitHubRepoName)
If Not FileExists($sFile) Then
_WriteFile($sFile, $sResponse)
ContinueLoop
EndIf
$sFileContent = _ReadFile($sFile)
$sFileContent = StringReplace($sFileContent, @CRLF, '', $iFirstOccurenceFromRightSideFlag)
If $sFileContent == $sResponse Then
ContinueLoop
EndIf
_SendWebExNotification(StringFormat('⚠ New commit was pushed to GitHub project **%s/%s**.', $sGitHubUsername, $sGitHubRepoName))
_WriteFile($sFile, $sResponse)
Next
EndFunc
Func _GetRepositoryCount()
Local Const $sJqCommand = '..\lib\jq.exe ".repository | length" ..\data\repositories.json'
Local Const $sResponse  = _ExecuteCommand($sJqCommand)
Local Const $iFirstOccurenceFromRightSideFlag = -1
Return StringReplace($sResponse, @CRLF, '', $iFirstOccurenceFromRightSideFlag)
EndFunc
Func _GetRepositoryUsername($i)
Local Const $sJqCommand = '..\lib\jq.exe . ..\data\repositories.json | ..\lib\jq.exe -r .repository[' & $i & '].username'
Local Const $sResponse  = _ExecuteCommand($sJqCommand)
Local Const $iFirstOccurenceFromRightSideFlag = -1
Return StringReplace($sResponse, @CRLF, '', $iFirstOccurenceFromRightSideFlag)
EndFunc
Func _GetRepositoryRepoName($i)
Local Const $sJqCommand = '..\lib\jq.exe . ..\data\repositories.json | ..\lib\jq.exe -r .repository[' & $i & '].name'
Local Const $sResponse  = _ExecuteCommand($sJqCommand)
Local Const $iFirstOccurenceFromRightSideFlag = -1
Return StringReplace($sResponse, @CRLF, '', $iFirstOccurenceFromRightSideFlag)
EndFunc
