#Region Configuración
#pragma compile(Icon, au3.ico)
HotKeySet('^{p}',  _Main)      ; Ctrl+P
HotKeySet('^+{p}', _ShowSizes) ; Ctrl+Shift+P
HotKeySet('{ESC}', _Close)
#EndRegion

#Region Variables globales
Global $hWnd = 0
GLobal Const $INI_FILE = 'CambiarTamaño.ini'
#EndRegion

#Region Funciones
Func _Main()
    $hWnd = WinGetHandle('')
    WinSetState($hWnd, '', @SW_RESTORE)
    HotKeySet('{DOWN}',  _Resize)
    HotKeySet('{UP}',    _Resize)
    HotKeySet('{RIGHT}', _Resize)
    HotKeySet('{LEFT}',  _Resize)
EndFunc
Func _Resize()
    $aPos = WinGetPos($hWnd)
    $w = $aPos[2]
    $h = $aPos[3]
    Switch (@HotKeyPressed)
        Case '{DOWN}'
            WinMove($hWnd, '', Default, Default, Default, $h + 1)
        Case '{UP}'
            WinMove($hWnd, '', Default, Default, Default, $h - 1)
        Case '{RIGHT}'
            WinMove($hWnd, '', Default, Default, $w + 1)
        Case '{LEFT}'
            WinMove($hWnd, '', Default, Default, $w - 1)
        Case Else
    EndSwitch
EndFunc
Func _ShowSizes()
    $hWnd = 0
    ShellExecute($INI_FILE)
EndFunc
Func _Close()
    If ($hWnd) Then
        $aPos = WinGetPos($hWnd)
        IniWrite($INI_FILE, _
                 'main', _
                 WinGetTitle($hWnd), _
                 ($aPos[2] & ';' & $aPos[3]))
    EndIf

    HotKeySet('{DOWN}')
    HotKeySet('{UP}')
    HotKeySet('{RIGHT}')
    HotKeySet('{LEFT}')

    Exit
EndFunc
#EndRegion

While 1
    Sleep(100)
WEnd