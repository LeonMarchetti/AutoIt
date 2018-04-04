#Region Configuración
#pragma compile(Icon, Icons/au3.ico)
#NoTrayIcon
Opt('ExpandVarStrings', 1)
Opt('GUIOnEventMode', 1)
#EndRegion

#Region Includes
#include <String.au3>
#include 'Funciones.au3'
#EndRegion

#Region Variables globales
Global $edit, $input

; Constantes Interfaz Gráfica:
Global Const $CTRL_ANCHO = 655
Global Const $CTRL_ALTO = 20
#EndRegion

#Region Manejadores de eventos
Func _GUI_EVENT_CLOSE()
    GUIDelete()
    Exit
EndFunc
Func _inputChanged()
    Local $clase = GUICtrlRead($input)
    If ($clase <> '') Then
        Local $separador = ArmarSeparador($clase)
        GUICtrlSetData($edit, $separador)
        ClipPut($separador)
    EndIf
EndFunc
#EndRegion

#Region Funciones
Func ArmarSeparador($clase)
    Local Static $longitud_total = 80
    Local Static $longitud_extra = 13
        ; Caracteres extra:
        ; <// >      => 3
        ; < class "> => 8
        ; <" >       => 2

    Local $longitud_clase = StringLen($clase)
    Local $cantidadAsteriscos = $longitud_total - $longitud_extra - $longitud_clase
    Local $asteriscos = _StringRepeat('*', Int($cantidadAsteriscos / 2))
    ; Local $resultado = '// ' & $asteriscos & ' class "' & $clase & '" ' & $asteriscos
    Local $resultado = '// $asteriscos$ class "$clase$" $asteriscos$'
    If Mod($longitud_clase, 2) == 0 Then _
        $resultado &= '*'

    Return $resultado
EndFunc
#EndRegion

#Region Interfaz gráfica
GUICreate('Separador de clase', ($CTRL_ANCHO + 10), ($CTRL_ALTO * 2 + 15))
GUISetFont(10, Default, Default, 'Liberation Mono')

$input = GUICtrlCreateInput('', 5, 5, $CTRL_ANCHO, $CTRL_ALTO)
$edit = GUICtrlCreateEdit('', 5, 30, $CTRL_ANCHO, $CTRL_ALTO, 0x800)

GUICtrlSetOnEvent($input, _inputChanged)

GUISetOnEvent(-3, _GUI_EVENT_CLOSE)
GUISetState(@SW_SHOW)
While 1
    Sleep(100)
WEnd
#EndRegion