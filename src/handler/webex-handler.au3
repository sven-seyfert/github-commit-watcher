#include-once
#include "../init.au3"

Func _SendWebExNotification($sMessage)
    Local Const $sCurlProgressBar          = '--silent'
    Local Const $sCurlIgnoreSSLCert        = '--insecure'
    Local Const $sCurlTimeout              = '--connect-timeout 8 --max-time 10'
    Local Const $sEncryptedWebExWebhookUrl = _ReadIni('EncryptedWebExWebhookUrl')

    Local Const $sCommand = StringFormat( _
        'curl --request POST --header "Content-Type: application/json" "%s" -d "{\"markdown\": \"%s\"}" %s %s %s %s', _
        _B64Ex2Str($sEncryptedWebExWebhookUrl), _
        $sMessage, _
        $sCurlTimeout, _
        $sCurlProgressBar, _
        $sCurlIgnoreSSLCert)

    _ExecuteCommand($sCommand)
EndFunc

Func _ReadIni($sKey)
    Local Const $sValue = IniRead('..\config\webex.ini', 'WEBEX', $sKey, '-')
    If $sValue == '-' Or $sValue == '' Then
        ConsoleWrite(StringFormat( _
            '[IniRead error]\nExpected: Value for key "%s" was read.\nReceived: Value for key "%s" could not be found or read.\nOccurred in function: _ReadIni()\n', _
            $sKey, $sKey))

        Exit -1
    EndIf

    Return $sValue
EndFunc
