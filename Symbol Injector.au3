#cs Symbol Injector.au3
    Presenta una lista de símbolos que se pueden insertar usando un atajo del
    teclado ('ins' por defecto). Escribiendo sobre el combobox se puede insertar
    cualquier texto.
#ce

#pragma compile(Icon, au3.ico)
#include <GUIComboBox.au3>
#include <GUIConstantsEx.au3>
#include <TrayConstants.au3>

Func Pegar()
    Send(GUICtrlRead($idCombo))
EndFunc

HotKeySet(IniRead("Symbol_Injector.ini", "main", "insert", "{ins}"), "Pegar")
Opt("TrayIconHide", 1)
Opt("TrayMenuMode", 1)

Global $sListaSimbolos = IniReadSection("Symbol_Injector.ini", "símbolos")
Global $bMinimizado = False

; Armar ventana ================================================================
$hGUI = GuiCreate("Inyector de Símbolos", 245, 75)
GUISetFont(12)
GUICtrlCreateLabel("Seleccionar símbolo de la lista:", 10, 10, 225, 20)
$idCombo = GUICtrlCreateCombo("", 10, 40, 225, 25)

For $i = 1 To $sListaSimbolos[0][0] ; Cantidad de símbolos
    GUICtrlSetData($idCombo, $sListaSimbolos[$i][1])
Next
_GUICtrlComboBox_SetCurSel($idCombo, 0)

GuiSetState(@SW_SHOW, $hGUI)
; ==============================================================================

While True
    If $bMinimizado Then
        Switch TrayGetMsg()
            Case $TRAY_EVENT_PRIMARYDOWN
                GuiSetState(@SW_SHOW, $hGUI)
                Opt("TrayIconHide", 1)
                $bMinimizado = False
        EndSwitch
    Else
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                ExitLoop
            Case $GUI_EVENT_MINIMIZE
                GUISetState(@SW_HIDE, $hGUI)
                Opt("TrayIconHide", 0)
                TraySetToolTip("Texto copiado es: " & GUICtrlRead($idCombo))
                $bMinimizado = True
        EndSwitch
    EndIf
WEnd

GUIDelete($hGUI)