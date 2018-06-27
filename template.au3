#Region Configuración
#pragma compile(Icon, Icons\au3.ico)
#pragma compile(Out, ejecutables\template.exe)
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

#Region Interfaz gráfica
GUICreate('GUICreate')
GUISetFont(10, Default, Default, 'Liberation Mono')

GUISetOnEvent(-3, _GUI_EVENT_CLOSE)
GUISetState(@SW_SHOW)
While 1
    Sleep(100)
WEnd
#EndRegion