#Region Configuración
HotKeySet('#{a}', _MostrarPaneles)
Opt('ExpandEnvStrings', 1)
Opt('GUIOnEventMode', 1)
Opt('TrayMenuMode', 1)
Opt('TrayOnEventMode', 1)
#pragma compile(Icon, Icons\au3.ico)
#EndRegion

#Region Includes
#include <Array.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <TrayConstants.au3>
#include <WindowsConstants.au3>
#EndRegion

#Region Variables globales
Global Const $INI_ARCHIVO = 'AutoItWidget.ini' ; Archivo de configuración
Global $hMainGUI                               ; Ventana 'padre' de los paneles
Global $ahPaneles[0]                           ; Paneles
Global $aBotones[0][2]                         ; Botones
Global $iPanelActivado = 0                     ; Índice del panel activado
Global Enum $PANEL_ANT, $PANEL_SIG
#EndRegion

#Region Bandeja de notificaciones
TraySetClick(8) ; El menu del Tray solo aparecerá cuando se use el click derecho.
TraySetOnEvent($TRAY_EVENT_PRIMARYDOWN, _MostrarPaneles)
TrayItemSetOnEvent(TrayCreateItem('Mostrar siempre'), _TRAYITEM_MostrarSiempre)
Global $hTrayMenu = TrayCreateMenu('Paneles')
Global $iTrayMenuItems = 0 ; Cantidad de paneles ocultos, con items en el menu
TrayItemSetState($hTrayMenu, $TRAY_DISABLE)
#EndRegion

#Region Tray - Manejadores de eventos
Func _TRAYITEM_MostrarSiempre()
    Local Static $bTop = False
    $bTop = Not $bTop
    For $hPanel in $ahPaneles
        WinSetOnTop($hPanel, '', $bTop)
    Next
EndFunc
Func _TRAYITEM_Panel()
    For $hPanel in $ahPaneles
        If (WinGetTitle($hPanel) == TrayItemGetText(@TRAY_ID)) Then _
            _MostrarPanel($hPanel)
    Next
EndFunc
#EndRegion

#Region Funciones
Func _CambiarPanel($hPanel, $eFlag)
    $iPaneles = UBound($ahPaneles)
    For $i = 0 To $iPaneles - 1
        If ($ahPaneles[$i] == $hPanel) Then
            Switch ($eFlag)
                Case $PANEL_ANT
                    $j = Mod(($i+$iPaneles-1), $iPaneles)
                Case $PANEL_SIG
                    $j = Mod(($i+1), $iPaneles)
            EndSwitch
            WinActivate($ahPaneles[$j])
            $iPanelActivado = $j
            Return
        EndIf
    Next
EndFunc
Func _CrearPaneles()
    Local Const $CTRL_ANCHO  = IniRead($INI_ARCHIVO, 'main', 'Control width', 400)
    Local Const $CTRL_ALTO   = IniRead($INI_ARCHIVO, 'main', 'Control height', 25)
    Local Const $TAM_FUENTE  = IniRead($INI_ARCHIVO, 'main', 'Font size', 10)
    Local Const $CANT_CONFIG = IniRead($INI_ARCHIVO, 'main', 'Config', 0)

    ; Cargar los nombres de las secciones en el archivo de configuración:
    Local $asSecciones = IniReadSectionNames($INI_ARCHIVO)
    _ArrayDelete($asSecciones, '0-1') ; Descartar sección 'main'

    For $sSeccion In $asSecciones
        ; Leer botones del archivo, se sacan las lineas de config. del arreglo:
        $aSeccion = IniReadSection($INI_ARCHIVO, $sSeccion)
        $iBotones = _ArrayDelete($aSeccion, '0-' & $CANT_CONFIG)

        ; Posición del panel:
        $X =        IniRead($INI_ARCHIVO, $sSeccion, 'X', -1)
        $Y =        IniRead($INI_ARCHIVO, $sSeccion, 'Y', -1)
        $bVisible = IniRead($INI_ARCHIVO, $sSeccion, 'Visible', 1)
        $iAncho =   IniRead($INI_ARCHIVO, $sSeccion, 'Ancho', $CTRL_ANCHO)

        ; Crear panel y agregarlo al arreglo de paneles:
        _ArrayAdd($ahPaneles, GUICreate($sSeccion, _
                                        $iAncho, ($CTRL_ALTO * $iBotones), _
                                        $X, $Y, _
                                        $WS_CAPTION, _
                                        $WS_EX_TOOLWINDOW, $hMainGUI))

        ; Dummy para capturar Tab y Shift+Tab
        $idDummy1 = GUICtrlCreateDummy()
        $idDummy2 = GUICtrlCreateDummy()
        Local $aAccelKeys = [ ['{Right}', $idDummy1], _
                              ['{Left}',  $idDummy2] ]
        GUICtrlSetOnEvent($idDummy1, _idDummy1Activated)
        GUICtrlSetOnEvent($idDummy2, _idDummy2Activated)

        ; Eventos del panel:
        GUISetOnEvent($GUI_EVENT_CLOSE, _GUI_EVENT_CLOSE)
        GUIRegisterMsg($WM_EXITSIZEMOVE, _EXITSIZEMOVE)

        If (IniRead($INI_ARCHIVO, $sSeccion, 'Visible', 'Si') == 'Si') Then
            GUISetState(@SW_SHOW)
        Else
            _OcultarPanel($sSeccion)
        EndIf

        ; Ajustar tamaño de fuente para los botones del panel:
        GUISetFont($TAM_FUENTE, Default, Default, 'Liberation Mono')

        For $i = 0 To $iBotones - 1
            $idBoton = GUICtrlCreateButton($aSeccion[$i][0], _
                                            0, ($CTRL_ALTO * $i), _
                                            $iAncho, $CTRL_ALTO, _
                                            $BS_LEFT)

            $asStringSplit = StringSplit($aSeccion[$i][1], ';')
            Switch $asStringSplit[0]
                Case 1 ; No fue provisto un ícono
                    GUICtrlSetImage($idBoton, $asStringSplit[1], 0, 1)
                Case 2 ; Fue provisto un ícono
                    GUICtrlSetImage($idBoton, $asStringSplit[2], 0, 1)
            EndSwitch

            Local $aBoton = [[ $idBoton, $asStringSplit[1] ]]
            _ArrayAdd($aBotones, $aBoton)

            GUICtrlSetOnEvent($idBoton, _idBotonClicked)

            ; Agregar hotkey numérico al botón:
            If ($i <= 8) Then
                Local $aBotonAccelKey = [[ $i+1, $idBoton ]]
                _ArrayAdd($aAccelKeys, $aBotonAccelKey)
            EndIf
        Next
        GUISetAccelerators($aAccelKeys)
    Next
EndFunc ; => CrearPaneles()
Func _MostrarPanel($hPanel)
    GUISetState(@SW_SHOW, $hPanel)
    TrayItemDelete(@TRAY_ID)
    IniWrite($INI_ARCHIVO, WinGetTitle($hPanel), 'Visible', 'Si')

    $iTrayMenuItems -= 1
    If ($iTrayMenuItems == 0) Then
        ; Se deshabilita el menu si no tiene items:
        TrayItemSetState($hTrayMenu, $TRAY_DISABLE)
    EndIf
EndFunc
Func _MostrarPaneles()
    WinActivate($ahPaneles[$iPanelActivado])
EndFunc
Func _OcultarPanel($hPanel)
    ; Oculta el panel seleccionado. Puede recibir tanto su manejador como su
    ; título.
    Local Const $sPanel = WinGetTitle($hPanel)
    GUISetState(@SW_HIDE, $hPanel)
    ; Crear un item en el menu de la bandeja para mostrar el panel nuevamente:
    TrayItemSetOnEvent(TrayCreateItem($sPanel, $hTrayMenu), _TRAYITEM_Panel)
    ; Incrementar contador de items en el menu de la bandeja:
    $iTrayMenuItems += 1
    If ($iTrayMenuItems == 1) Then
        ; Se habilita el menu si empieza a tener ítems:
        TrayItemSetState($hTrayMenu, $TRAY_ENABLE)
    EndIf
    ; Registrar en el archivo de configuración que un panel se ocultó:
    IniWrite($INI_ARCHIVO, $sPanel, 'Visible', 'No')
EndFunc
#EndRegion

#Region Manejadores de eventos
Func _EXITSIZEMOVE($hWndGUI, $MsgID)
    Local Const $aPos = WinGetPos($hWndGUI)
    Local Const $sPanel = WinGetTitle($hWndGUI)

    IniWrite($INI_ARCHIVO, $sPanel, 'X', $aPos[0])
    IniWrite($INI_ARCHIVO, $sPanel, 'Y', $aPos[1])
EndFunc
Func _GUI_EVENT_CLOSE()
    Exit
EndFunc
Func _idBotonClicked()
    For $i = 0 To (UBound($aBotones) - 1)
        If (@GUI_CtrlId == $aBotones[$i][0]) Then
            ShellExecute($aBotones[$i][1])
            ExitLoop
        EndIf
    Next
EndFunc
Func _idDummy1Activated()
    _CambiarPanel(@GUI_WinHandle, $PANEL_SIG)
EndFunc
Func _idDummy2Activated()
    _CambiarPanel(@GUI_WinHandle, $PANEL_ANT)
EndFunc
Func _NCLBUTTONDBLCLK($hPanel, $MsgID)
    _OcultarPanel($hPanel)
EndFunc
#EndRegion

$hMainGUI = GUICreate('AutoItWidgets')
GUIRegisterMsg($WM_NCLBUTTONDBLCLK, _NCLBUTTONDBLCLK)
_CrearPaneles()

While True
    Sleep(100)
WEnd
