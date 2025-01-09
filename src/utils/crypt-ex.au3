#include-once
#include "../init.au3"

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
