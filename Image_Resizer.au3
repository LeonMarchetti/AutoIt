#Region Configuración
#pragma compile(Icon, au3.ico)
#NoTrayIcon
Opt("GUIOnEventMode", 1)
#EndRegion

#Region Variables globales
Global $x = 0
Global $y = 0               ; Ancho y alto actuales de la imágen a modificar.
Global $xImg, $yImg         ; Ancho y alto de la imágen a agregar.
Global $newProp1, $newProp2 ; Proporciones luego de agregar la imágen nueva.

; Proporción de la pantalla, se usa como proporción de referencia para la imágen
Global Const $screenProp = @DesktopWidth / @DesktopHeight

; Estilos de inputs:
Global Const $ES_INPUTFIJO    = 0x0801 ; = BitOr($ES_CENTER, $ES_READONLY)
Global Const $ES_INPUTENTRADA = 0x2001 ; = BitOr($ES_CENTER, $ES_NUMBER)

; Colores:
Global Const $COLOR_GRIS  = 0xF0F0F0
Global Const $COLOR_ROJO  = 0xF28773
Global Const $COLOR_VERDE = 0x00FF00
#EndRegion

#Region Interfaz gráfica
GUICreate('Imágenes', 323, 131)
GUISetFont(10, Default, Default, 'Liberation Mono')

#Region Grupo reducción

GUICtrlCreateGroup('Reducción', 5, 0, 107, 67)
; Fila 1
$idInput_red_1 = GUICtrlCreateInput('',     11, 16, 45, 20, $ES_INPUTENTRADA)
                 GUICtrlCreateInput('100%', 61, 16, 45, 20, $ES_INPUTFIJO)
; Fila 2
$idInput_red_2 = GUICtrlCreateInput('',     11, 41, 45, 20, $ES_INPUTENTRADA)
$idInput_red_3 = GUICtrlCreateInput('',     61, 41, 45, 20, $ES_INPUTFIJO)
GUICtrlCreateGroup('', -99, -99) ; => Grupo 'Reducción'

#EndRegion
#Region Grupo tamaño imagen

GUICtrlCreateGroup('Tamaño', 111, 0, 207, 126)
; Fila 1
GUICtrlCreateInput(@DesktopWidth,         117, 16, 45, 20, $ES_INPUTFIJO)
GUICtrlCreateInput(@DesktopHeight,        167, 16, 45, 20, $ES_INPUTFIJO)
GUICtrlCreateInput(Round($screenProp, 5), 217, 16, 95, 20, $ES_INPUTFIJO)
; Fila 2
$idInput_tam_1 = GUICtrlCreateInput('', 117, 41, 45, 20, $ES_INPUTENTRADA)
$idInput_tam_2 = GUICtrlCreateInput('', 167, 41, 45, 20, $ES_INPUTENTRADA)
$idInput_tam_3 = GUICtrlCreateInput('', 217, 41, 95, 20, $ES_INPUTFIJO)
; Fila 3
$idInput_tam_4 = GUICtrlCreateInput('', 117, 66, 45, 20, $ES_INPUTENTRADA)
$idInput_tam_5 = GUICtrlCreateInput('', 167, 66, 45, 20, $ES_INPUTENTRADA)
$idInput_tam_6 = GUICtrlCreateInput('', 217, 66, 45, 20, $ES_INPUTFIJO)
$idInput_tam_7 = GUICtrlCreateInput('', 267, 66, 45, 20, $ES_INPUTFIJO)
; Fila 4
$idInput_tam_8 = GUICtrlCreateInput('', 117, 91, 45, 20, $ES_INPUTFIJO)
$idInput_tam_9 = GUICtrlCreateInput('', 167, 91, 45, 20, $ES_INPUTFIJO)
; Fila 5
$idButton_tam_1 = GUICtrlCreateButton('', 117, 111, 45, 10)
GUICtrlSetBkColor(-1, $COLOR_VERDE)
$idButton_tam_2 = GUICtrlCreateButton('', 167, 111, 45, 10)
GUICtrlSetBkColor(-1, $COLOR_VERDE)

GUICtrlCreateGroup('', -99, -99) ; => Grupo 'Tamaño'

#EndRegion

GUICtrlSetOnEvent($idInput_tam_1, _idInput_tam_1Changed)
GUICtrlSetOnEvent($idInput_tam_2, _idInput_tam_2Changed)
GUICtrlSetOnEvent($idInput_tam_4, _idInput_tam_4Changed)
GUICtrlSetOnEvent($idInput_tam_5, _idInput_tam_5Changed)
GUICtrlSetOnEvent($idButton_tam_1, _idButton_tam_1Clicked)
GUICtrlSetOnEvent($idButton_tam_2, _idButton_tam_2Clicked)
GUICtrlSetOnEvent($idInput_red_1, _idInput_red_1Changed)
GUICtrlSetOnEvent($idInput_red_2, _idInput_red_2Changed)
GUISetOnEvent(-3, _GUI_EVENT_CLOSE)

; El dummy permite que se pueda usar la tecla 'enter' para actualizar la
; interfaz sin activar otro control.
$idDummy = GUICtrlCreateDummy()
Local $aAccelKeys = [ _
    ['{enter}',  $idDummy], _
    ['+{left}',  $idButton_tam_1], _
    ['+{right}', $idButton_tam_2] _
]
GUISetAccelerators($aAccelKeys)

GUISetState(@SW_SHOW)
While 1 ; Idle loop
    Sleep(100)
WEnd

#EndRegion

;Region Manejadores de Eventos

Func _GUI_EVENT_CLOSE()
    GUIDelete()
    Exit
EndFunc
Func _idInput_red_1Changed()
    _Update_idInput_red_3()
EndFunc
Func _idInput_red_2Changed()
    _Update_idInput_red_3()
EndFunc
Func _idInput_tam_1Changed()
    $x = Int(GUICtrlRead($idInput_tam_1))
    _Update_idInput_tam_3()
    _Update_idInput_tam_6()
    _Update_idInput_tam_7()
    _Update_idInput_tam_8()
EndFunc
Func _idInput_tam_2Changed()
    $y = Int(GUICtrlRead($idInput_tam_2))
    _Update_idInput_tam_3()
    _Update_idInput_tam_6()
    _Update_idInput_tam_7()
    _Update_idInput_tam_9()
EndFunc
Func _idInput_tam_4Changed()
    $xImg = Int(GUICtrlRead($idInput_tam_4))
    _Update_idInput_tam_6()
    _Update_idInput_tam_7()
    _Update_idInput_tam_8()
EndFunc
Func _idInput_tam_5Changed()
    $yImg = Int(GUICtrlRead($idInput_tam_5))
    _Update_idInput_tam_6()
    _Update_idInput_tam_7()
    _Update_idInput_tam_9()
EndFunc
Func _idButton_tam_1Clicked()
    $x += $xImg
    _Update_idInput_tam_1()
    If ($yImg > $y) Then
        $y = $yImg
        _Update_idInput_tam_2()
        _Update_idInput_tam_3()
        _Update_idInput_tam_6()
        _Update_idInput_tam_7()
        _Update_idInput_tam_9()
    EndIf
EndFunc
Func _idButton_tam_2Clicked()
    $y += $yImg
    _Update_idInput_tam_2()
    If ($xImg > $x) Then
        $x = $xImg
        _Update_idInput_tam_1()
        _Update_idInput_tam_3()
        _Update_idInput_tam_6()
        _Update_idInput_tam_7()
        _Update_idInput_tam_8()
    EndIf
EndFunc

;Region Funciones Actualizaciones Input

Func _Update_idInput_red_3()
    Local $viejo = Int(GUICtrlRead($idInput_red_1))
    Local $nuevo = Int(GUICtrlRead($idInput_red_2))
    If ($viejo > 0) Then
        Local $porcentaje = Round(($nuevo * 100 / $viejo), 0)
        GUICtrlSetData($idInput_red_3, $porcentaje & '%')

        Local $bkColor = $COLOR_GRIS
        Select
            Case $porcentaje > 100
                $bkColor = $COLOR_VERDE
            Case $porcentaje < 100 And $porcentaje > 0
                $bkColor = $COLOR_ROJO
        EndSelect

        GUICtrlSetBkColor($idInput_red_3, $bkColor)
    Else
        GUICtrlSetData($idInput_red_3, '')
        GUICtrlSetBkColor($idInput_red_3, $COLOR_GRIS)
    EndIf
EndFunc
Func _Update_idInput_tam_1()
    GUICtrlSetData($idInput_tam_1, $x)
    _idInput_tam_1Changed()
EndFunc
Func _Update_idInput_tam_2()
    GUICtrlSetData($idInput_tam_2, $y)
    _idInput_tam_2Changed()
EndFunc
Func _Update_idInput_tam_3()
    GUICtrlSetData($idInput_tam_3, ($y == 0) ? "" : Round($x / $y, 5))
EndFunc
Func _Update_idInput_tam_6()
    $newProp1 = ($y == 0) ? 0 : (($x + $xImg) / $y)
    GUICtrlSetData($idInput_tam_6, ($y == 0) ? "" : Round($newProp1, 2))
    _Update_idInput_tam_Colors()
EndFunc
Func _Update_idInput_tam_7()
    $newProp2 = ($y == 0) ? 0  : ($x / ($y + $yImg))
    GUICtrlSetData($idInput_tam_7, ($y == 0) ? "" : Round($newProp2, 2))
    _Update_idInput_tam_Colors()
EndFunc
Func _Update_idInput_tam_8()
    GUICtrlSetData($idInput_tam_8, ($x + $xImg))
EndFunc
Func _Update_idInput_tam_9()
    GUICtrlSetData($idInput_tam_9, (($y == 0) ? "" : ($y + $yImg)))
EndFunc
Func _Update_idInput_tam_Colors()
    If ($y == 0) Then
        GUICtrlSetBkColor($idInput_tam_6, $COLOR_GRIS)
        GUICtrlSetBkColor($idInput_tam_7, $COLOR_GRIS)
    Else
        Local $dif1 = Abs($newProp1 - $screenProp)
        Local $dif2 = Abs($newProp2 - $screenProp)

        Local $bkColor_6 = $COLOR_GRIS
        Local $bkcolor_7 = $COLOR_GRIS

        Select
            Case $dif1 < $dif2
                $bkColor_6 = $COLOR_VERDE
            Case $dif2 < $dif1
                $bkColor_7 = $COLOR_VERDE
            Case $dif1 == $dif2
                $bkColor_6 = $COLOR_VERDE
                $bkColor_7 = $COLOR_VERDE
        EndSelect
        GUICtrlSetBkColor($idInput_tam_6, $bkColor_6)
        GUICtrlSetBkColor($idInput_tam_7, $bkColor_7)
    EndIf
EndFunc
