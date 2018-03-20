#Region Configuración
#pragma compile(Icon, au3.ico)
#NoTrayIcon
Opt("GUIOnEventMode", 1)
#EndRegion

#Region Includes
#include <AutoItConstants.au3>
#EndRegion

#Region Variables globales
Global $idDir, $idCmd, $idOutput
#EndRegion

#Region Manejadores de eventos
Func _GUI_EVENT_CLOSE()
    GUIDelete()
    Exit
EndFunc
Func _idDummyActivated()
    GUICtrlSetData($idOutput, '')

    Local $sDir = GUICtrlRead($idDir)
    If ($sDir == '') Then
        $sDir = @ScriptDir
    EndIf
    GUICtrlSetTip($idDir, $sDir)

    If (FileExists($sDir)) Then
        Local $sCmd = GUICtrlRead($idCmd)
        Local $pid = Run($sCmd, $sDir, @SW_HIDE, $STDOUT_CHILD)

        GUICtrlSetData($idOutput, 'Ejecutando...')
        ProcessWaitClose($pid)
        GUICtrlSetData($idOutput, StdoutRead($pid))
    Else
        GUICtrlSetData($idOutput, 'El directorio [' & $sDir & '] no existe.')
    EndIf
EndFunc
#EndRegion

#Region Interfaz gráfica
GUICreate("Ejecución de comandos", 650, 154)
GUISetFont(10, Default, Default, 'Liberation Mono')

GUICtrlCreateLabel('Carpeta: ', 5, 5, 64, 17)
$sDir = IniRead('CommandRun.ini', 'main', 'dir', '')
$idDir = GUICtrlCreateInput($sDir, 74, 5, 571, 17)
GUICtrlSetTip($idDir, $sDir)

GUICtrlCreateLabel('Comando: ', 5, 27, 64, 17)
$idCmd = GUICtrlCreateInput(IniRead('CommandRun.ini', 'main', 'cmd', ''), 74, 27, 571, 17)
$idOutput = GUICtrlCreateEdit('', 5, 49, 640, 100, (0x0800 + 0x00200000))
; 0x0800:     $ES_READONLY
; 0x00200000: $WS_VSCROLL
GUICtrlSetBkColor($idOutput, 0xF0F4F9)
GUICtrlSetColor($idOutput, 0x000090)

$idDummy = GUICtrlCreateDummy()
Local $aAccelKeys[1][2] = [['{enter}', $idDummy]]
GUISetAccelerators($aAccelKeys)

GUICtrlSetOnEvent($idDummy, _idDummyActivated)

GUISetOnEvent(-3, _GUI_EVENT_CLOSE)
GUISetState(@SW_SHOW)
While 1
    Sleep(100)
WEnd
#EndRegion