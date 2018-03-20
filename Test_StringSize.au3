#include <StringSize.au3>

;Global Const $string = '————————————————————————————————————————————————————————————————————————————————'
; Width      = 640
; Form width = 675
;Global Const $string = 'untitled.cpp:16:23: error: expected primary-expression before ">" token'
; Width      = 568
; Form width = 675
Global Const $string = 'Destino:'
; Width          : 64

$aStringSize = _StringSize($string, 10, 400, 0, 'Liberation Mono')
If (@error) Then
    Switch(@error)
        Case 1
            ConsoleWrite('Tipo de parámetro incorrecto: ' & @extended & @LF)
        Case 2
            ConsoleWrite('Error de llamada a librería: ')
            Switch (@extended)
                Case 1
                    ConsoleWrite('GetDC' & @LF)
                Case 2
                    ConsoleWrite('SendMessage' & @LF)
                Case 3
                    ConsoleWrite('GetDeviceCaps' & @LF)
                Case 4
                    ConsoleWrite('CreateFont' & @LF)
                Case 5
                    ConsoleWrite('SelectObject' & @LF)
                Case 6
                    ConsoleWrite('GetTextExtentPoint32' & @LF)
            EndSwitch
        Case 3
            ConsoleWrite('Fuente muy grande para el ancho máximo elegido.' & @LF)
    EndSwitch
Else
    ConsoleWrite('Original string: ' & $aStringSize[0] & @LF)
    ConsoleWrite('Height         : ' & $aStringSize[1] & @LF)
    ConsoleWrite('Width          : ' & $aStringSize[2] & @LF)
    ConsoleWrite('Height         : ' & $aStringSize[3] & @LF)
EndIf
