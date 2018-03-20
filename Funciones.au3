#Region Includes
#include-once
#include <GUIConstantsEx.au3>
#EndRegion
#Region Constantes
#EndRegion
; Region Funciones
Func PrintLn($sTexto = "")
    ConsoleWrite($sTexto & @LF)
EndFunc
Func DivisiblePor($iDividendo, $iDivisor)
    Return Mod($iDividendo, $iDivisor) == 0
EndFunc
Func MostrarCartel($sTitulo, $sTexto)
    MsgBox(0, $sTitulo, $sTexto)
EndFunc
Func TrayAlternarVisibilidad($hGUI)
    ; Funci�n para ocultar una ventana y mostrar un �cono en la bandeja de
    ; notificaciones, tal que se pueda recuperar la ventana desde all�.
    ; # Para ocultar la ventana al minizarla:
    ; Switch GUIGetMsg()
    ;     Case $GUI_EVENT_MINIMIZE
    ;         TrayAlternarVisibilidad($mainGUI)
    ; # Para volver a mostrar la ventana al presionar el �cono de la bandeja:
    ; Switch TrayGetMsg()
    ;     Case $TRAY_PRIMARYDOWN
    ;         TrayAlternarVisibilidad($mainGUI)
    If BitAnd(WinGetState($hGUI), 2) Then ; $GUI es visible
        GUISetState(@SW_HIDE, $hGUI)
        Opt("TrayIconHide", 0)
    Else
        GuiSetState(@SW_SHOW, $hGUI)
        Opt("TrayIconHide", 1)
    EndIf
EndFunc
Func AlternarSalvapantallas($bEncendido)
    #cs Habilita o deshabilita el salvapantallas, seg�n el valor booleano pasado
        como par�metro.
    #ce
    DllCall("user32.dll", "long", "SystemParametersInfo", _
        "long", 17, _
        "long", ($bEncendido ? 1 : 0), _
        "long", 0, _
        "long", 0)
EndFunc
Func Timer($oFunc)
    #cs Ejecuta una funci�n y regresa un arreglo con el tiempo que tard� y el
        resultado de la funci�n.
    #ce
    $hTimer = TimerInit()
    Local Const $aResult = [ $oFunc(), TimerDiff($hTimer) ]
    Return $aResult
EndFunc
Func Assert($bExpresion, _
            $sMensajeError="", _
            $sMensajeExito="", _
            $nLinea=@ScriptLineNumber)
    #cs Aserci�n sobre una expresi�n, en el caso de que no se cumpla termina el
        programa. Muestra un mensaje con el n�mero de l�nea.
    #ce
    If (Not $bExpresion) Then
        ConsoleWrite("Assert fall�[" & $nLinea & "]: " & $sMensajeError & @LF)
        Exit 1
    EndIf

    If ($sMensajeExito) Then _
        ConsoleWrite("Assert pas� [" & $nLinea & "]: " & $sMensajeExito & @LF)

    Return $bExpresion
EndFunc
Func DebugLog($sMensaje, $nLinea=@ScriptLineNumber)
    ConsoleWrite('Debug Msg   [' & $nLinea & ']: ' & $sMensaje & @LF)
EndFunc
