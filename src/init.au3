#include-once

Global $mProgressBar[]

OnAutoItExitRegister('_Exit')

Func _Exit()
    _EndProgressBar('Processing completed.')
EndFunc

#include "./handler/file-handler.au3"
#include "./handler/request-handler.au3"
#include "./handler/webex-handler.au3"
#include "./utils/progressbar.au3"
#include "./utils/crypt-ex.au3"
