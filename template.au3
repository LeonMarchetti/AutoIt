#Region Configuraci�n
#pragma compile(Icon, au3.ico)
#NoTrayIcon
Opt('GUIOnEventMode', 1)
#EndRegion

#Region Includes

#EndRegion

#Region Variables globales

#EndRegion

#Region Manejadores de eventos
Func _GUI_EVENT_CLOSE()
    GUIDelete()
    Exit
EndFunc
#EndRegion

#Region Funciones

#EndRegion

#Region Interfaz gr�fica
GUICreate('GUICreate')
GUISetFont(10, Default, Default, 'Liberation Mono')

GUISetOnEvent(-3, _GUI_EVENT_CLOSE)
GUISetState(@SW_SHOW)
While 1
    Sleep(100)
WEnd
#EndRegion