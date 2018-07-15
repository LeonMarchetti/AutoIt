#Region Configuración
#pragma compile(Icon, Icons\au3.ico)
#pragma compile(Out, ejecutables\Imágenes.exe)
#NoTrayIcon
Opt('GUIOnEventMode', 1)
#include <Misc.au3>
_Singleton('Imágenes')
#EndRegion

#Region Includes
#include <GUIComboBox.au3>
#EndRegion

#Region Variables globales
Global $x, $y               ; Ancho y alto actuales de la imágen a modificar.
Global $xImg, $yImg         ; Ancho y alto de la imágen a agregar.
Global $newProp1, $newProp2 ; Proporciones luego de agregar la imágen nueva.

; Proporción de la pantalla, se usa como proporción de referencia para la imágen
Global Const $screenProp = @DesktopWidth / @DesktopHeight

; Colores:
Global Const $COLOR_GRIS  = 0xF0F0F0
Global Const $COLOR_ROJO  = 0xF28773
Global Const $COLOR_VERDE = 0x00FF00

; Controles:
Global $input1, $input2, $input3, $input4, $input5, $input6, $input7, _
       $input8, $input9, $button1, $button2, $button3, $button4, $button5, _
       $combo

; Combo:
Global $actual = 'Original'

; Objeto diccionario para guardar los valores para cada imágen:
Global $cache = ObjCreate('Scripting.Dictionary')
#EndRegion

#Region Funciones
Func _CrearGUI()

    ; Estilos de controles inputs:
    Local Const $ES_INPUTFIJO    = 0x0801 ; = BitOr($ES_CENTER, $ES_READONLY)
    Local Const $ES_INPUTENTRADA = 0x2001 ; = BitOr($ES_CENTER, $ES_NUMBER)

    GUICreate('Imágenes', 205, 171)
    GUISetFont(10, Default, Default, 'Liberation Mono')

    $combo = GUICtrlCreateCombo('', 5, 5, 195, 23, 0x0003)
    GUICtrlSetData(-1, $actual, $actual)
    GUICtrlSetOnEvent($combo, _comboChanged)

    $button1 = GUICtrlCreateButton('Agregar', 5, 147, 65, 20)
    $button2 = GUICtrlCreateButton('Cerrar', 70, 147, 65, 20)
    GUICtrlSetColor(-1, 0xFFFFFF)
    GUICtrlSetBkColor(-1, 0xFF0000)
    $button3 = GUICtrlCreateButton('Limpiar', 135, 147, 65, 20)

    ; Fila 1
    GUICtrlCreateInput(@DesktopWidth,           5, 33, 45, 20, $ES_INPUTFIJO)
    GUICtrlCreateInput(@DesktopHeight,         55, 33, 45, 20, $ES_INPUTFIJO)
    GUICtrlCreateInput(Round($screenProp, 5), 105, 33, 95, 20, $ES_INPUTFIJO)

    ; Fila 2
    $input1 = GUICtrlCreateInput('',   5, 58, 45, 20, $ES_INPUTENTRADA)
    $input2 = GUICtrlCreateInput('',  55, 58, 45, 20, $ES_INPUTENTRADA)
    $input3 = GUICtrlCreateInput('', 105, 58, 95, 20, $ES_INPUTFIJO)

    ; Fila 3
    $input4 = GUICtrlCreateInput('',   5, 83, 45, 20, $ES_INPUTENTRADA)
    $input5 = GUICtrlCreateInput('',  55, 83, 45, 20, $ES_INPUTENTRADA)
    $input6 = GUICtrlCreateInput('', 105, 83, 45, 20, $ES_INPUTFIJO)
    $input7 = GUICtrlCreateInput('', 155, 83, 45, 20, $ES_INPUTFIJO)

    ; Fila 4
    $input8 = GUICtrlCreateInput('',  5, 108, 45, 20, $ES_INPUTFIJO)
    $input9 = GUICtrlCreateInput('', 55, 108, 45, 20, $ES_INPUTFIJO)

    ; Fila 5
    $button4 = GUICtrlCreateButton('',  5, 133, 45, 10)
    GUICtrlSetBkColor(-1, 0x00FF00)
    $button5 = GUICtrlCreateButton('', 55, 133, 45, 10)
    GUICtrlSetBkColor(-1, 0x00FF00)

    GUICtrlSetOnEvent($input1, _input1Changed)
    GUICtrlSetOnEvent($input2, _input2Changed)
    GUICtrlSetOnEvent($input4, _input4Changed)
    GUICtrlSetOnEvent($input5, _input5Changed)
    GUICtrlSetOnEvent($button1, _button1Clicked)
    GUICtrlSetOnEvent($button2, _button2Clicked)
    GUICtrlSetOnEvent($button3, _button3Clicked)
    GUICtrlSetOnEvent($button4, _button4Clicked)
    GUICtrlSetOnEvent($button5, _button5Clicked)

    GUISetOnEvent(-3, _GUI_EVENT_CLOSE)

    ; El dummy permite que se pueda usar la tecla 'enter' para actualizar la
    ; interfaz sin activar otro control.
    $dummy = GUICtrlCreateDummy()
    Local $aAccelKeys = [ _
        ['{enter}',  $dummy], _
        ['+{left}',  $button4], _
        ['+{right}', $button5] _
    ]
    GUISetAccelerators($aAccelKeys)
EndFunc
#EndRegion

#Region Manejadores de Eventos
Func _button1Clicked() ; Agregar
    $nuevo = InputBox('Imágenes', 'Nuevo nombre:', '', '', 1, 125)
    If ($nuevo And _GUICtrlComboBox_FindString($combo, $nuevo) == -1) Then
        GUICtrlSetData($combo, $nuevo, $nuevo)

        ; Creo una entrada de caché vacía:
        Local $datos_nuevos = [0, 0, 0, 0]
        $cache($nuevo) = $datos_nuevos

        _comboChanged()
    EndIf
EndFunc
Func _button2Clicked() ; Cerrar
    If (_GUICtrlComboBox_GetCount($combo) > 1) Then
        $i = _GUICtrlComboBox_GetCurSel($combo)
        _GUICtrlComboBox_DeleteString($combo, $i)
        _GUICtrlComboBox_SetCurSel($combo, 0)
        _comboChanged()
    EndIf
EndFunc
Func _button3Clicked() ; Limpiar
    $x = 0
    $y = 0
    $xImg = 0
    $yImg = 0

    ; Actualizo los controles:
    _Update_input1()
    _Update_input2()
    _Update_input3()
    _Update_input4()
    _Update_input5()
    _Update_input6()
    _Update_input7()
    _Update_input8()
    _Update_input9()
EndFunc
Func _button4Clicked() ; Sumar Ancho
    $x += $xImg
    _Update_input1()
    If ($yImg > $y) Then
        $y = $yImg
        _Update_input2()
        _Update_input3()
        _Update_input6()
        _Update_input7()
        _Update_input9()
    EndIf
EndFunc
Func _button5Clicked() ; Sumar Altura
    $y += $yImg
    _Update_input2()
    If ($xImg > $x) Then
        $x = $xImg
        _Update_input1()
        _Update_input3()
        _Update_input6()
        _Update_input7()
        _Update_input8()
    EndIf
EndFunc
Func _comboChanged()
    $nuevo = GUICtrlRead($combo)
    If ($nuevo <> $actual) Then
        ; Guardo los datos
        If (_GUICtrlComboBox_FindString($combo, $actual) == -1) Then
            ; Borro la entrada del caché si se borró la imágen:
            $cache.Remove($actual)
        Else
            ; Guardo los valores actuales en el caché:
            Local $datos_actuales = [$x, $y, $xImg, $yImg]
            $cache($actual) = $datos_actuales
        EndIf

        ; Traigo los datos del caché:
        $actual = $nuevo
        $datos_nuevos = $cache($nuevo)
        $x = $datos_nuevos[0]
        $y = $datos_nuevos[1]
        $xImg = $datos_nuevos[2]
        $yImg = $datos_nuevos[3]

        ; Actualizo los controles:
        _Update_input1()
        _Update_input2()
        _Update_input3()
        _Update_input4()
        _Update_input5()
        _Update_input6()
        _Update_input7()
        _Update_input8()
        _Update_input9()
    EndIf
EndFunc
Func _GUI_EVENT_CLOSE()
    GUIDelete()
    Exit
EndFunc
Func _input1Changed()
    $x = Int(GUICtrlRead($input1))
    _Update_input3()
    _Update_input6()
    _Update_input7()
    _Update_input8()
EndFunc
Func _input2Changed()
    $y = Int(GUICtrlRead($input2))
    _Update_input3()
    _Update_input6()
    _Update_input7()
    _Update_input9()
EndFunc
Func _input4Changed()
    $xImg = Int(GUICtrlRead($input4))
    _Update_input6()
    _Update_input7()
    _Update_input8()
EndFunc
Func _input5Changed()
    $yImg = Int(GUICtrlRead($input5))
    _Update_input6()
    _Update_input7()
    _Update_input9()
EndFunc
#EndRegion
#Region Funciones Actualizaciones Input
Func _Update_input1()
    GUICtrlSetData($input1, $x ? $x : '')
    _input1Changed()
EndFunc
Func _Update_input2()
    GUICtrlSetData($input2, $y ? $y : '')
    _input2Changed()
EndFunc
Func _Update_input3()
    GUICtrlSetData($input3, $y ? Round($x / $y, 5) : '')
EndFunc
Func _Update_input4()
    GUICtrlSetData($input4, $xImg ? $xImg : '')
EndFunc
Func _Update_input5()
    GUICtrlSetData($input5, $yImg ? $yImg : '')
EndFunc
Func _Update_input6()
    $newProp1 = $y ? ($x + $xImg) / $y : 0
    GUICtrlSetData($input6, $y ? Round($newProp1, 2) : '')
    _Update_input_colors()
EndFunc
Func _Update_input7()
    $newProp2 = $y ? $x / ($y + $yImg) : 0
    GUICtrlSetData($input7, $y ? Round($newProp2, 2) : '')
    _Update_input_colors()
EndFunc
Func _Update_input8()
    GUICtrlSetData($input8, $x + $xImg)
EndFunc
Func _Update_input9()
    GUICtrlSetData($input9, $y + $yImg)
EndFunc
Func _Update_input_colors()
    If ($y) Then
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
        GUICtrlSetBkColor($input6, $bkColor_6)
        GUICtrlSetBkColor($input7, $bkColor_7)
    Else
        GUICtrlSetBkColor($input6, $COLOR_GRIS)
        GUICtrlSetBkColor($input7, $COLOR_GRIS)
    EndIf
EndFunc
#EndRegion

; Ejecución:
_CrearGUI()
GUISetState(@SW_SHOW)
While 1 ; Idle loop
    Sleep(100)
WEnd