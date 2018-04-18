#Region Configuración
#pragma compile(Icon, Icons/au3.ico)
#NoTrayIcon
Opt('GUIOnEventMode', 1)
Opt('WinTitleMatchMode', 2)
#include <Misc.au3>
_Singleton('Enlaces')
#EndRegion

#Region Variables globales
; Se cargan los enlaces desde el archivo.
Global $asConfig = FileReadToArray(IniRead('Enlaces.ini', 'main', 'ConfigFile', ''))
Global Const $iEnlaces = UBound($asConfig) ; Cantidad de enlaces.
Global $aidBotones[$iEnlaces]
Global $asEnlaces[$iEnlaces]
Global Const $sBrowserLaunch = IniRead('Enlaces.ini', 'main', 'BrowserLaunch', '')
Global Const $sBrowserWindowName = IniRead('Enlaces.ini', 'main', 'BrowserWindowName', '')
If ($sBrowserLaunch == '' Or $sBrowserWindowName == '') Then
    MsgBox(0x10, 'Enlaces', 'Error: Parámetro no encontrado.')
    Exit 1
EndIf
#EndRegion

#Region Manejadores de eventos
Func _GUI_EVENT_CLOSE()
    GUIDelete()
    Exit
EndFunc
Func _idBotonClicked()
   For $i = 0 To UBound($aidBotones) - 1
      If ($aidBotones[$i] == @GUI_CtrlId) Then _
         _AccederEnlace($asEnlaces[$i])
   Next
EndFunc
#EndRegion

#Region Funciones
Func _AccederEnlace($sEnlace)
    If (WinExists($sBrowserWindowName)) Then
        WinActivate($sBrowserWindowName)
        Send('^{t}')
        Local Const $aPos = MouseGetPos()
        MouseClick('left', 260, 50, 1, 0)
        MouseMove($aPos[0], $aPos[1], 0)

        ; Accede al enlace, copiándolo al portapapeles y pegándolo en la barra
        ; del navegador
        Local Const $sClipBefore = ClipGet()
        ClipPut($sEnlace)
        Send('^{v}{Enter}')
        ClipPut($sClipBefore)
    Else
        ; Si no hay una ventana del navegador abierta se abre una, con
        ; navegación privada.
        ShellExecute($sBrowserLaunch, '--private ' & $sEnlace)
    EndIf
EndFunc
#EndRegion

#Region Interfaz gráfica

If ($iEnlaces == 0) Then
    ; Interfaz por si no se encuentra el archivo con los enlaces:
    GUICreate('Enlaces', 225, 35)
    GUICtrlCreateLabel('No se encontró ningún enlace...', 10, 10, 205, 15)
Else
    GUICreate('Enlaces', 225, (20 + 15 * $iEnlaces))
    For $i = 0 To $iEnlaces - 1
        #Region Extracción enlace
        ; Puedo usar un nombre como etiqueta para el enlace:
        ; Etiqueta;https://www.sitio.com.ar
        $asStringSplit = StringSplit($asConfig[$i], ';')
        If ($asStringSplit[0] == 1) Then
            $sLabel = $asStringSplit[1]
            $sEnlace = $asStringSplit[1]
        Else
            $sLabel = $asStringSplit[1]
            $sEnlace = $asStringSplit[2]
        EndIf
        #EndRegion

        $idBoton = GUICtrlCreateButton('Ir', 10, (10 + 15 * $i), 20, 15)
        GUICtrlCreateLabel($sLabel, 35, (10 + 15 * $i), 180, 15)
        GUICtrlSetOnEvent($idBoton, _idBotonClicked)

        $aidBotones[$i] = $idBoton
        $asEnlaces[$i] = $sEnlace
     Next
     $asConfig = 0
EndIf

GUISetOnEvent(-3, _GUI_EVENT_CLOSE)
GUISetState(@SW_SHOW)
While 1
    Sleep(100)
WEnd
#EndRegion