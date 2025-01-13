#include-once
#include "../init.au3"

Func _SendWebExNotification($sMessage)
    Local Const $sCurlProgressBar = '--silent'
    Local Const $sCurlTimeout     = '--connect-timeout 8 --max-time 10'

    Local Const $sCommand = StringFormat( _
        'curl --request POST --header "Content-Type: application/json" "%s" -d "{\"markdown\": \"%s\"}" %s %s %s', _
        _B64Ex2Str('ey83U1nBRgt.JOYmlBTjplLzM1Z0g9JjpeQDNCIUQ8N3Q8UHhdT0hNIlNzXVhNX20xLCNlVyo8ei8hIjtDRUh0aDN4Ti9aRGZnOkVIdz0uSXBTW144b0BrRz5XYzhISTZ1TWd4Zz9gZW97QT86PSY9MThgYHNrbTRHSXpqU2diLihYcK1809.19p545wN6r75017hxF1aRv0z'), _
        $sMessage, _
        $sCurlTimeout, _
        $sCurlProgressBar)

        ConsoleWrite($sCommand & @CRLF)
    _ExecuteCommand($sCommand)
EndFunc
