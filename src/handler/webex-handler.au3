#include-once
#include "../init.au3"

Func _SendWebExNotification($sMessage)
    Local Const $sCurlProgressBar = '--silent'
    Local Const $sCurlTimeout     = '--connect-timeout 8 --max-time 10'

    Local Const $sCommand = StringFormat( _
        'curl --request POST --header "Content-Type: application/json" "%s" -d "{\"markdown\": \"%s\"}" %s %s %s', _
        _B64Ex2Str('eyx7zL4PSEv.cdaHR0cHM6Ly93ZWJleGFwaXMuY29tL3YxL3dlYmhvb2tzL2luY29taW5nL1kybHpZMjl6Y0dGeWF6b3ZMM1Z6TDFkRlFraFBUMHN2WWpFMU4yWmpNR0V0TURGbE5DMDBZV0UwTFRnNVlqUXRaRGd4TVRkaU5qTTRaV0Zo8eO95C.h9t0yN3VxcV3hTs79x8trEpR'), _
        $sMessage, _
        $sCurlTimeout, _
        $sCurlProgressBar)

    _ExecuteCommand($sCommand)
EndFunc
