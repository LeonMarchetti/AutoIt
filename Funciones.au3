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
    ; Función para ocultar una ventana y mostrar un ícono en la bandeja de
    ; notificaciones, tal que se pueda recuperar la ventana desde allí.
    ; # Para ocultar la ventana al minizarla:
    ; Switch GUIGetMsg()
    ;     Case $GUI_EVENT_MINIMIZE
    ;         TrayAlternarVisibilidad($mainGUI)
    ; # Para volver a mostrar la ventana al presionar el ícono de la bandeja:
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
    #cs Habilita o deshabilita el salvapantallas, según el valor booleano pasado
        como parámetro.
    #ce
    DllCall("user32.dll", "long", "SystemParametersInfo", _
        "long", 17, _
        "long", ($bEncendido ? 1 : 0), _
        "long", 0, _
        "long", 0)
EndFunc
Func Timer($oFunc)
    #cs Ejecuta una función y regresa un arreglo con el tiempo que tardó y el
        resultado de la función.
    #ce
    $hTimer = TimerInit()
    Local Const $aResult = [ $oFunc(), TimerDiff($hTimer) ]
    Return $aResult
EndFunc
Func Assert($bExpresion, _
            $sMensajeError="", _
            $sMensajeExito="", _
            $nLinea=@ScriptLineNumber)
    #cs Aserción sobre una expresión, en el caso de que no se cumpla termina el
        programa. Muestra un mensaje con el número de línea.
    #ce
    If (Not $bExpresion) Then
        ConsoleWrite("Assert falló[" & $nLinea & "]: " & $sMensajeError & @LF)
        Exit 1
    EndIf

    If ($sMensajeExito) Then _
        ConsoleWrite("Assert pasó [" & $nLinea & "]: " & $sMensajeExito & @LF)

    Return $bExpresion
EndFunc
Func DebugLog($sMensaje, $nLinea=@ScriptLineNumber)
    ConsoleWrite('Debug Msg   [' & $nLinea & ']: ' & $sMensaje & @LF)
EndFunc
