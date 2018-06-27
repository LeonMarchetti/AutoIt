#Region Configuración
#pragma compile(Icon, Icons\au3.ico)
#pragma compile(Out, ejecutables\PathGUI.exe)
#NoTrayIcon
Opt('ExpandEnvStrings', 1)
Opt('GUIOnEventMode', 1)
#EndRegion

#Region Variables globales
Global $lista
#EndRegion

#Region Manejadores de eventos
Func _GUI_EVENT_CLOSE()
    GUIDelete()
    Exit
EndFunc
Func _listaClicked()
    Local Const $ruta = GUICtrlRead($lista)
    ClipPut($ruta)
    Run('explorer.exe /n,/e,' & $ruta)
EndFunc
#EndRegion

#Region Funciones
Func _ArmarLista()
    For $ruta In StringSplit(EnvGet('Path'), ';', 2)
        GUICtrlSetData($lista, $ruta)
        ConsoleWrite($ruta & @LF)
    Next
EndFunc
#EndRegion

#Region Interfaz gráfica
GUICreate('Path', 500, 500)
GUISetFont(10, Default, Default, 'Liberation Mono')

$lista = GUICtrlCreateList('', 5, 5, 490, 490)

_ArmarLista()

GUICtrlSetOnEvent($lista, _listaClicked)

GUISetOnEvent(-3, _GUI_EVENT_CLOSE)
GUISetState(@SW_SHOW)
While 1
    Sleep(100)
WEnd
#EndRegion