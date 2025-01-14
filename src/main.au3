#pragma compile(FileVersion, 0.5.0)
#pragma compile(LegalCopyright, © Sven Seyfert (SOLVE-SMART))
#pragma compile(ProductVersion, 0.5.0 - 2025-01-14)

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
    _StartProgressBar('Processing in progress...', 'github-commit-watcher')

    Local Const $sGitHubUrl         = 'https://api.github.com/repos'
    Local Const $sEndpoint          = 'commits?per_page=1'
    Local Const $sJqCommand         = 'jq.exe -j ".[0].commit.message"'
    Local Const $sCurlProgressBar   = '--silent'
    Local Const $sCurlIgnoreSSLCert = '--insecure'
    Local Const $sCurlTimeout       = '--connect-timeout 8 --max-time 10'

    Local $sGitHubUsername, $sGitHubRepoName
    Local $sCommand, $sResponse, $sFile, $sFileContent

    Local Const $iFirstOccurenceFromRightSideFlag = -1

    ;~ Get json data entry count.
    Local Const $iRepositoryCount = _GetRepositoryCount() - 1

    For $i = 0 To $iRepositoryCount
        ;~ Get json data values.
        $sGitHubUsername = _GetRepositoryUsername($i)
        $sGitHubRepoName = _GetRepositoryRepoName($i)

        ;~ Note: To geht username and repo name directly as a string
        ;~ like "sven-seyfert/autoit-webdriver-boilerplate", the following
        ;~ jq command can be used:
        ;~ '..\lib\jq.exe -j ".repository[' & $i & '] | \"\(.username)/\(.name)\"" ..\data\repositories.json'
        ;~ This would avoid the separate jq calls like above.

        ;~ Get first commit of specific repository.
        $sCommand = StringFormat( _
            'curl -H "Accept: application/vnd.github.v3+json" "%s/%s/%s/%s" %s %s %s | ..\lib\%s', _
            $sGitHubUrl, $sGitHubUsername, $sGitHubRepoName, $sEndpoint, $sCurlProgressBar, $sCurlIgnoreSSLCert, $sCurlTimeout, $sJqCommand)

        $sResponse = _ExecuteCommand($sCommand)
        $sResponse = StringReplace($sResponse, @CRLF, '')

        ;~ Write commit entry to file.
        $sFile = StringFormat('..\output\%s-%s.txt', $sGitHubUsername, $sGitHubRepoName)
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
        _SendWebExNotification(StringFormat( _
            '⚠ New [commit](https://github.com/%s/%s/commits/) was pushed to GitHub project [%s/%s](https://github.com/%s/%s).', _
            $sGitHubUsername, $sGitHubRepoName, $sGitHubUsername, $sGitHubRepoName, $sGitHubUsername, $sGitHubRepoName))

        ;~ Update existing commit entry with new commit entry.
        _WriteFile($sFile, $sResponse)

        ;~ TODO
        ;~ Setup windows scheduled task or do it with AutoIt.
    Next
EndFunc

Func _GetRepositoryCount()
    Local Const $sJqCommand = '..\lib\jq.exe -j ".repository | length" ..\data\repositories.json'
    Local Const $sResponse  = _ExecuteCommand($sJqCommand)

    Return $sResponse
EndFunc

Func _GetRepositoryUsername($i)
    Local Const $sJqCommand = '..\lib\jq.exe . ..\data\repositories.json | ..\lib\jq.exe -j .repository[' & $i & '].username'
    Local Const $sResponse  = _ExecuteCommand($sJqCommand)

    Return $sResponse
EndFunc

Func _GetRepositoryRepoName($i)
    Local Const $sJqCommand = '..\lib\jq.exe . ..\data\repositories.json | ..\lib\jq.exe -j .repository[' & $i & '].name'
    Local Const $sResponse  = _ExecuteCommand($sJqCommand)

    Return $sResponse
EndFunc
