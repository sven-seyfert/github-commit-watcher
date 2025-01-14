#include-once
#include "../init.au3"

Func _StartProgressBar($sStatusText, $sTitle)
    Local Const $vMarguee    = 0x00000008
    Local Const $vSetMarquee = 0x400 + 10

    $mProgressBar.Handle   = GUICreate($sTitle, 400, 70)
    $mProgressBar.Status   = GUICtrlCreateLabel($sStatusText, 15, 15, 240)
    $mProgressBar.Progress = GUICtrlCreateProgress(15, 35, 370, 20, $vMarguee)

    GUICtrlSendMsg($mProgressBar.Progress, $vSetMarquee, True, 50)
    GUISetState(@SW_SHOW, $mProgressBar.Handle)
EndFunc

Func _EndProgressBar($sStatusText)
    Local Const $iSmooth = 1
    Local Const $iDone   = 100

    GUICtrlSetStyle($mProgressBar.Progress, $iSmooth)
    GUICtrlSetData($mProgressBar.Progress, $iDone)
    GUICtrlSetData($mProgressBar.Status, $sStatusText)

    GUIDelete($mProgressBar.Handle)
EndFunc
