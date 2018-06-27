#Region Configuración
#pragma compile(Icon, Icons\au3.ico)
#pragma compile(Out, ejecutables\Alternador Salvapantallas.exe)
#NoTrayIcon
Opt('GUIOnEventMode', 1)
#EndRegion

#Region Variables globales
Global $boton
Global $encendido = True
Global Const $VERDE = 0x008000
Global Const $ROJO = 0xFF0000
Global Const $BLANCO = 0xFFFFFF
#EndRegion

#Region Manejadores de eventos
Func _botonClicked()
    $encendido = Not $encendido
    AlternarSalvapantallas($encendido)
    GUICtrlSetBkColor($boton, $encendido ? $VERDE : $ROJO)
    GUICtrlSetData   ($boton, $encendido ? 'Encendido'  : 'Apagado')
EndFunc
Func _GUI_EVENT_CLOSE()
    If ($encendido = False) Then _
        AlternarSalvaPantallas(True)
    GUIDelete()
    Exit
EndFunc
#EndRegion

#Region Funciones
Func AlternarSalvapantallas($encendido)
    #cs Habilita o deshabilita el salvapantallas, según el valor booleano pasado
        como parámetro.
    #ce
    DllCall('user32.dll', 'long', 'SystemParametersInfo', _
        'long', 17, _
        'long', ($encendido ? 1 : 0), _
        'long', 0, _
        'long', 0)
EndFunc
#EndRegion

#Region Interfaz gráfica
GUICreate('Alternador de Salvapantallas', 120, 40)
GUISetFont(10, Default, Default, 'Liberation Mono')

$boton = GUICtrlCreateButton('Encendido', 10, 10, 100, 20)
GUICtrlSetColor($boton, $BLANCO)
GUICtrlSetBkColor($boton, $VERDE)
GUICtrlSetOnEvent($boton, _botonClicked )

GUISetOnEvent(-3, _GUI_EVENT_CLOSE)
GUISetState(@SW_SHOW)
While 1
    Sleep(100)
WEnd
#EndRegion