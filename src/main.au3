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

#include-once
#include "./init.au3"

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

    ;~ Get json data entry count.
    Local Const $iRepositoryCount = _GetRepositoryCount() - 1

    For $i = 0 To $iRepositoryCount
        ;~ Get json data values.
        $sGitHubUsername = _GetRepositoryUsername($i)
        $sGitHubRepoName = _GetRepositoryRepoName($i)

        ;~ Get first commit of specific repository.
        $sCommand = StringFormat( _
            'curl -H "Accept: application/vnd.github.v3+json" "%s/%s/%s/%s" %s %s | ..\lib\%s', _
            $sGitHubUrl, $sGitHubUsername, $sGitHubRepoName, $sEndpoint, $sCurlProgressBar, $sCurlTimeout, $sJqCommand)

        $sResponse = _ExecuteCommand($sCommand)
        $sResponse = StringReplace($sResponse, @CRLF, '')

        ;~ Write commit entry to file.
        Local $sFile = StringFormat('..\output\%s-%s.txt', $sGitHubUsername, $sGitHubRepoName)
        If Not FileExists($sFile) Then
            _WriteFile($sFile, $sResponse)
            ContinueLoop
        EndIf

        ;~ Read and compare existing commit entry with new commit entry.
        $sFileContent = _ReadFile($sFile)
        $sFileContent = StringReplace($sFileContent, @CRLF, '', $iFirstOccurenceFromRightSideFlag)
        If $sFileContent == $sResponse Then
            ContinueLoop
        EndIf

        ;~ Send WebEx webhook notification message (in case of new commit).
        _SendWebExNotification(StringFormat('⚠ New commit was pushed to GitHub project **%s/%s**.', $sGitHubUsername, $sGitHubRepoName))

        ;~ Update existing commit entry with new commit entry.
        _WriteFile($sFile, $sResponse)

        ;~ TODO
        ;~ Setup windows scheduled task or do it with AutoIt.
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