#Region ConfiguraciÃ³n
#include <Array.au3>
#include <GUIComboBox.au3>
#include <GuiTab.au3>
#include 'Funciones.au3'
#NoTrayIcon
Opt('ExpandEnvStrings', 1)
Opt('ExpandVarStrings', 1)
Opt('GUIOnEventMode', 1)
#EndRegion

#Region Globales
Global $controles[1][11]
#EndRegion

Global Const $MODULO = 10
; Global $idCombo_10
ConsoleWrite('<GUITest Case $MODULO$>@LF@')

Switch ($MODULO)
Case 1 ; Radios
    #Region Radio constants:
    $RADIO_BKCOLOR = 0xFFFF00
    $RADIO_CNT     = 4
    $RADIO_HEIGHT  = 15
    $RADIO_LEFT    = 0
    Local $RADIO_TEXT[$RADIO_CNT] = ['C', 'C++', 'Java', 'Python']
    Local $RADIO_WIDTH[$RADIO_CNT] = [50, 50, 50, 65]
    #EndRegion
    #Region GUI constants:
    $GUI_FONT_ATTR   = 0
    $GUI_FONT_NAME   = 'Liberation Mono'
    $GUI_FONT_SIZE   = 10
    $GUI_FONT_WEIGHT = 0
    $GUI_HEIGHT      = $RADIO_CNT * $RADIO_HEIGHT
    $GUI_TITLE       = 'Untitled'
    $GUI_WIDTH       = _ArrayMax($RADIO_WIDTH)
    #EndRegion

    GUICreate($GUI_TITLE, $GUI_WIDTH, $GUI_HEIGHT)
    GUISetFont($GUI_FONT_SIZE, $GUI_FONT_WEIGHT, $GUI_FONT_ATTR, $GUI_FONT_NAME)

    For $i = 0 To ($RADIO_CNT - 1)
        $RADIO_TOP = $RADIO_HEIGHT * $i
        GUICtrlCreateRadio($RADIO_TEXT[$i], $RADIO_LEFT, $RADIO_TOP, _
                           $RADIO_WIDTH[$i], $RADIO_HEIGHT)
        GUICtrlSetBkColor(-1, $RADIO_BKCOLOR)
    Next

Case 2 ; Edit
    #Region Edit constants:
    $EDIT_BKCOLOR = 0xF0F4F9
    $EDIT_COLOR   = 0x000090
    $EDIT_HEIGHT  = 100
    $EDIT_LEFT    = 0
    ;$EDIT_STYLE   = (0x0800 + 0x00200000 + 0x00100000)
    ;$EDIT_STYLE   = 0x00300800
    $EDIT_STYLE   = '0x00300800'
    ;$EDIT_TEXT    = 'untitled.cpp:16:23: error: expected primary-expression before ">" token'
    $EDIT_TEXT    = ChrW(0x250C)
    $EDIT_TOP     = 0
    $EDIT_WIDTH   = 600
    #EndRegion
    #Region GUI constants:
    $GUI_FONT_ATTR   = 0
    $GUI_FONT_NAME   = 'Liberation Mono'
    $GUI_FONT_SIZE   = 10
    $GUI_FONT_WEIGHT = 0
    $GUI_HEIGHT      = $EDIT_HEIGHT
    $GUI_TITLE       = 'Untitled'
    $GUI_WIDTH       = $EDIT_WIDTH
    #EndRegion

    GUICreate($GUI_TITLE, $GUI_WIDTH, $GUI_HEIGHT)
    GUISetFont($GUI_FONT_SIZE, $GUI_FONT_WEIGHT, $GUI_FONT_ATTR, $GUI_FONT_NAME)

    GUICtrlCreateEdit($EDIT_TEXT, $EDIT_LEFT, $EDIT_TOP, $EDIT_WIDTH, $EDIT_HEIGHT, $EDIT_STYLE)
    GUICtrlSetBkColor(-1, $EDIT_BKCOLOR)
    GUICtrlSetColor(-1, $EDIT_COLOR)

Case 3 ; Combo
    #Region Combo constants:
    $COMBO_HEIGHT = 15
    $COMBO_LEFT = 5
    $COMBO_STYLE = (0x0100 + 0x0003)
    Local $COMBO_TEXT[2] = ['Python', 'Java']
    $COMBO_TOP = 5
    $COMBO_WIDTH = 75
    #EndRegion
    #Region GUI constants:
    $GUI_FONT_ATTR   = 0
    $GUI_FONT_NAME   = 'Liberation Mono'
    $GUI_FONT_SIZE   = 10
    $GUI_FONT_WEIGHT = 0
    $GUI_HEIGHT      = 100
    $GUI_TITLE       = 'Untitled'
    $GUI_WIDTH       = 100
    #EndRegion

    GUICreate($GUI_TITLE, $GUI_WIDTH, $GUI_HEIGHT)
    GUISetFont($GUI_FONT_SIZE, $GUI_FONT_WEIGHT, $GUI_FONT_ATTR, $GUI_FONT_NAME)

    $idCombo = GUICtrlCreateCombo('', $COMBO_LEFT, $COMBO_TOP, $COMBO_WIDTH, $COMBO_HEIGHT, $COMBO_STYLE)
    GUICtrlSetData($idCombo, $COMBO_TEXT[0], $COMBO_TEXT[0])
    GUICtrlSetData($idCombo, $COMBO_TEXT[1])

Case 4 ; Botón
    #Region Button constants:
    $BTN_LEFT   = 0
    $BTN_HEIGHT = 18
    $BTN_STYLE  = 0x0100
    $BTN_TEXT   = 'Alternador Salvapantallas'
    $BTN_TOP    = 0
    $BTN_WIDTH  = 260
    #EndRegion
    #Region GUI constants:
    $GUI_FONT_ATTR   = 0
    $GUI_FONT_NAME   = 'Liberation Mono'
    $GUI_FONT_SIZE   = 10
    $GUI_FONT_WEIGHT = 0
    $GUI_HEIGHT      = $BTN_HEIGHT
    $GUI_TITLE       = 'Untitled'
    $GUI_WIDTH       = $BTN_WIDTH
    #EndRegion

    GUICreate($GUI_TITLE, $GUI_WIDTH, $GUI_HEIGHT)
    GUISetFont($GUI_FONT_SIZE, $GUI_FONT_WEIGHT, $GUI_FONT_ATTR, $GUI_FONT_NAME)

    GUICtrlCreateButton($BTN_TEXT, $BTN_LEFT, $BTN_TOP, $BTN_WIDTH, $BTN_HEIGHT, $BTN_STYLE)

Case 5 ; Lista
    #Region Lists constants:
    $LIST_LEFT   = 0
    $LIST_HEIGHT = 305
    $LIST_TOP    = 0
    $LIST_WIDTH  = 400
    #EndRegion
    #Region GUI constants:
    $GUI_FONT_ATTR   = 0
    $GUI_FONT_NAME   = 'Liberation Mono'
    $GUI_FONT_SIZE   = 10
    $GUI_FONT_WEIGHT = 0
    $GUI_HEIGHT      = $LIST_HEIGHT
    $GUI_TITLE       = 'List Set Data'
    $GUI_WIDTH       = $LIST_WIDTH
    #EndRegion

    GUICreate($GUI_TITLE, $GUI_WIDTH, $GUI_HEIGHT)
    GUISetFont($GUI_FONT_SIZE, $GUI_FONT_WEIGHT, $GUI_FONT_ATTR, $GUI_FONT_NAME)
    GUICtrlCreateList("", $LIST_LEFT, $LIST_TOP, $LIST_WIDTH, $LIST_HEIGHT)

    GUICtrlSetData(-1, 'Hola')
    GUICtrlSetData(-1, 'Mundo')

Case 6 ; Botones
    #Region Lists constants:
    $BTN_LEFT   = 0
    $BTN_HEIGHT = 18
    $BTN_WIDTH  = 75
    #EndRegion
    #Region GUI constants:
    $GUI_FONT_ATTR   = 0
    $GUI_FONT_NAME   = 'Liberation Mono'
    $GUI_FONT_SIZE   = 10
    $GUI_FONT_WEIGHT = 0
    $GUI_HEIGHT      = 9 * $BTN_HEIGHT
    $GUI_TITLE       = 'Botones'
    $GUI_WIDTH       = $BTN_WIDTH
    #EndRegion

    $gui = GUICreate($GUI_TITLE, $GUI_WIDTH, $GUI_HEIGHT)
    GUISetFont($GUI_FONT_SIZE, $GUI_FONT_WEIGHT, $GUI_FONT_ATTR, $GUI_FONT_NAME)

    For $i = 0 To 8
        $BTN_TEXT = 'Botón ' & ($i + 1)
        $BTN_TOP  = ($i * $BTN_HEIGHT)
        $boton    = GUICtrlCreateButton($BTN_TEXT, _
                                        $BTN_LEFT, $BTN_TOP, _
                                        $BTN_WIDTH, $BTN_HEIGHT)
        DebugLog($BTN_TEXT & ' = ' & $boton)
        Assert($boton <> 0, _
               'GUICtrlCreateButton falló.')
        Local $accel = [ [$boton, $i+1] ]
        Assert(GUISetAccelerators($accel, $gui) == 1, _
               'GUISetAccelerators falló.')
        Assert(GUICtrlSetOnEvent($boton, _botonClicked) == 1, _
               'GUICtrlSetOnEvent falló.')
    Next
Case 7 ; Tabs

    #Region Control Constants
    $boton_alto = 10
    $ancho = 45
    $doble_ancho = 95
    $alto = 20
    $ES_INPUTFIJO = 0x0801
    $ES_INPUTENTRADA = 0x2001
    $screenProp = @DesktopWidth / @DesktopHeight
    Local $X = [6, 56, 106, 156, 206]
    Local $Y = [28, 53, 78, 103, 128]
    #EndRegion
    #Region Tab Constants
    $TAB_HEIGHT = 145
    $TAB_LEFT = 0
    $TAB_STYLE = BitOr(0x0008, 0x0100, 0x8000)
    $TAB_TOP = 0
    $TAB_WIDTH = 209
    #EndRegion
    #Region GUI constants:
    $GUI_FONT_ATTR   = 0
    $GUI_FONT_NAME   = 'Liberation Mono'
    $GUI_FONT_SIZE   = 10
    $GUI_FONT_WEIGHT = 0
    $GUI_HEIGHT      = $TAB_HEIGHT -1 + 20
    $GUI_TITLE       = 'Tabs'
    $GUI_WIDTH       = $TAB_WIDTH - 2
    #EndRegion

    GUICreate($GUI_TITLE, $GUI_WIDTH, $GUI_HEIGHT)
    GUISetFont($GUI_FONT_SIZE, $GUI_FONT_WEIGHT, $GUI_FONT_ATTR, $GUI_FONT_NAME)

    ; Tabs:
    $tab_control = GUICtrlCreateTab($TAB_LEFT, $TAB_TOP, $TAB_WIDTH, $TAB_HEIGHT, $TAB_STYLE)
    _TabItemControls('Orig')

    $boton_agregar = GUICtrlCreateButton('Agregar', 0, 144, 69, 20)
    $boton_cerrar = GUICtrlCreateButton('Cerrar', 69, 144, 69, 20)
    GUICtrlSetColor(-1, 0xFFFFFF)
    GUICtrlSetBkColor(-1, 0xFF0000)
    GUICtrlCreateButton('Limpiar', 138, 144, 69, 20)

    GUICtrlSetOnEvent($boton_agregar, _boton_agregarClicked)
    GUICtrlSetOnEvent($boton_cerrar, _boton_cerrarClicked)

    GUICtrlCreateInput(@DesktopWidth,         $X[0], $Y[0], $ancho, $alto, $ES_INPUTFIJO)
    GUICtrlSetState(-1, 2048)
    GUICtrlCreateInput(@DesktopHeight,        $X[1], $Y[0], $ancho, $alto, $ES_INPUTFIJO)
    GUICtrlSetState(-1, 2048)
    GUICtrlCreateInput(Round($screenProp, 5), $X[2], $Y[0], $doble_ancho, $alto, $ES_INPUTFIJO)
    GUICtrlSetState(-1, 2048)

Case 8 ; Ver-Estado-Git

    $carpeta = IniRead('Ver-Estado-Git.ini', 'main', 'carpeta', '<None>')
    ;$carpeta = '%baul%\AutoIt\'

    $iPID = Run('git status', $carpeta, @SW_HIDE, $STDOUT_CHILD + $STDERR_CHILD)
    ProcessWaitClose($iPid)
    $salida = StdoutRead($iPID)
    If (@error) Then
        $edit_text = 'Error'
        $edit_lines = 1
    Else
        $regex = '(?m)^\t(?:modified:   |deleted:    )?(.+)$'
        $match = StringRegExp($salida, $regex)
        If (@error) Then
            $edit_text = 'Patrón mal escrito'
            $edit_lines = 1
        Else
            If ($match) Then
                $edit_text = ''
                $edit_lines = 0
                $matches = StringRegExp($salida, $regex, 3)
                For $match In $matches
                    $edit_text &= '$match$@CRLF@'
                    $edit_lines += 1
                Next
            Else
                $edit_text = 'No coincide'
                $edit_lines = 1
            EndIf
        EndIf
    EndIf

    #Region Input Constants
    $input_height = 20
    $input_left = 5
    $input_style = 0x0800
    $input_text = $carpeta
    $input_top = 5
    $input_width = 230
    #EndRegion
    #Region Edit Constants
    $edit_height = 15 * $edit_lines
    $edit_left = 5
    $edit_style = BitOr(0x0004, 0x0800)
    $edit_top = $input_height + 10
    $edit_width = $input_width
    #EndRegion
    #Region GUI constants:
    $GUI_FONT_ATTR   = 0
    $GUI_FONT_NAME   = 'Liberation Mono'
    $GUI_FONT_SIZE   = 10
    $GUI_FONT_WEIGHT = 0
    $GUI_HEIGHT      = $edit_height + $input_height + 15
    $GUI_TITLE       = 'Ver Estado Git'
    $GUI_WIDTH       = $input_width + 10
    #EndRegion

    GUICreate($GUI_TITLE, $GUI_WIDTH, $GUI_HEIGHT)
    GUISetFont($GUI_FONT_SIZE, $GUI_FONT_WEIGHT, $GUI_FONT_ATTR, $GUI_FONT_NAME)

    GUICtrlCreateInput($input_text, $input_left, $input_top, $input_width, _
                       $input_height, $input_style)

    GUICtrlCreateEdit($edit_text, $edit_left, $edit_top, $edit_width, _
                      $edit_height, $edit_style)


Case 9 ; List View
    #Region List View constants:
    $LV_EXSTYLE = 0
    $LV_HEIGHT = 150
    $LV_LEFT = 0
;~     $LV_STYLE = 0x0003 + 0x0004
    $LV_STYLE = 0x0002 + 0x0200
    $LV_TEXT = 'col1'
    $LV_TOP = 0
    $LV_WIDTH = 200
    Local $LV_ITEMS = ['item2', 'item1', 'item3']
    #EndRegion
    #Region GUI constants:
    $GUI_FONT_ATTR   = 0
    $GUI_FONT_NAME   = 'Liberation Mono'
    $GUI_FONT_SIZE   = 10
    $GUI_FONT_WEIGHT = 0
    $GUI_HEIGHT      = $LV_HEIGHT
    $GUI_TITLE       = 'List Set Data'
    $GUI_WIDTH       = $LV_WIDTH
    #EndRegion

    GUICreate($GUI_TITLE, $GUI_WIDTH, $GUI_HEIGHT)
    GUISetFont($GUI_FONT_SIZE, $GUI_FONT_WEIGHT, $GUI_FONT_ATTR, $GUI_FONT_NAME)
    $idListview = GUICtrlCreateListView($LV_TEXT, $LV_LEFT, $LV_TOP, $LV_WIDTH, $LV_HEIGHT, _
                          $LV_STYLE, $LV_EXSTYLE)
    GUICtrlSetBkColor($idListview, 0xFFFFFFFF)

    For $item In $LV_ITEMS
        GUICtrlCreateListViewItem($item, $idListview)
        GUICtrlSetImage(-1, 'Icons/au3.ico')
    Next

Case 10 ; Combo (2)

    #Region Control Constants
    $boton_alto = 10
    $ancho = 45
    $doble_ancho = 95
    $alto = 20
    $ES_INPUTFIJO = 0x0801
    $ES_INPUTENTRADA = 0x2001
    $screenProp = @DesktopWidth / @DesktopHeight
    Local $X = [5, 55, 105, 155, 205]
    Local $Y = [33, 58, 83, 108, 133]
    #EndRegion
    #Region Combo constants:
    $COMBO_HEIGHT = 23
    $COMBO_LEFT = 5
    $COMBO_STYLE = (0x0003)
    $COMBO_TEXT = 'Original'
    $COMBO_TOP = 5
    $COMBO_WIDTH = 195
    #EndRegion
    #Region GUI constants:
    $GUI_FONT_ATTR   = 0
    $GUI_FONT_NAME   = 'Liberation Mono'
    $GUI_FONT_SIZE   = 10
    $GUI_FONT_WEIGHT = 0
    $GUI_HEIGHT      = 171
    $GUI_TITLE       = 'Tabs'
    $GUI_WIDTH       = $COMBO_WIDTH + 10
    #EndRegion

    GUICreate($GUI_TITLE, $GUI_WIDTH, $GUI_HEIGHT)
    GUISetFont($GUI_FONT_SIZE, $GUI_FONT_WEIGHT, $GUI_FONT_ATTR, $GUI_FONT_NAME)

    $idCombo_10 = GUICtrlCreateCombo('', $COMBO_LEFT, $COMBO_TOP, $COMBO_WIDTH, $COMBO_HEIGHT, $COMBO_STYLE)
    GUICtrlSetData(-1, $COMBO_TEXT, $COMBO_TEXT)
    GUICtrlSetOnEvent($idCombo_10, _idCombo_10Changed)

    $boton_agregar_10 = GUICtrlCreateButton('Agregar', 5, 147, 65, 20)
    $boton_cerrar_10 = GUICtrlCreateButton('Cerrar', 70, 147, 65, 20)
    GUICtrlSetColor(-1, 0xFFFFFF)
    GUICtrlSetBkColor(-1, 0xFF0000)
    GUICtrlCreateButton('Limpiar', 135, 147, 65, 20)

    GUICtrlSetOnEvent($boton_agregar_10, _boton_agregar_10Clicked)
    GUICtrlSetOnEvent($boton_cerrar_10, _boton_cerrar_10Clicked)

    GUICtrlCreateInput(@DesktopWidth,         $X[0], $Y[0], $ancho, $alto, $ES_INPUTFIJO)
    GUICtrlCreateInput(@DesktopHeight,        $X[1], $Y[0], $ancho, $alto, $ES_INPUTFIJO)
    GUICtrlCreateInput(Round($screenProp, 5), $X[2], $Y[0], $doble_ancho, $alto, $ES_INPUTFIJO)

    ; Fila 2
    $input1 = GUICtrlCreateInput('', $X[0], $Y[1], $ancho, $alto, $ES_INPUTENTRADA)
    $input2 = GUICtrlCreateInput('', $X[1], $Y[1], $ancho, $alto, $ES_INPUTENTRADA)
    $input3 = GUICtrlCreateInput('', $X[2], $Y[1], $doble_ancho, $alto, $ES_INPUTFIJO)

    ; Fila 3
    $input4 = GUICtrlCreateInput('', $X[0], $Y[2], $ancho, $alto, $ES_INPUTENTRADA)
    $input5 = GUICtrlCreateInput('', $X[1], $Y[2], $ancho, $alto, $ES_INPUTENTRADA)
    $input6 = GUICtrlCreateInput('', $X[2], $Y[2], $ancho, $alto, $ES_INPUTFIJO)
    $input7 = GUICtrlCreateInput('', $X[3], $Y[2], $ancho, $alto, $ES_INPUTFIJO)

    ; Fila 4
    $input8 = GUICtrlCreateInput('', $X[0], $Y[3], $ancho, $alto, $ES_INPUTFIJO)
    $input9 = GUICtrlCreateInput('', $X[1], $Y[3], $ancho, $alto, $ES_INPUTFIJO)

    ; Fila 5
    $button1 = GUICtrlCreateButton('', $X[0], $Y[4], $ancho, $boton_alto)
    GUICtrlSetBkColor(-1, 0x00FF00)
    $button2 = GUICtrlCreateButton('', $X[1], $Y[4], $ancho, $boton_alto)
    GUICtrlSetBkColor(-1, 0x00FF00)

    GUICtrlSetOnEvent($input1, _input_2Changed)
    GUICtrlSetOnEvent($input2, _input_2Changed)
    GUICtrlSetOnEvent($input4, _input_2Changed)
    GUICtrlSetOnEvent($input5, _input_2Changed)

EndSwitch

#Region Ejecución
GUISetOnEvent(-3, _GUI_EVENT_CLOSE)
GUISetState(@SW_SHOW)
While 1
    Sleep(150)
WEnd
#EndRegion

#Region Manejadores de eventos:
Func _botonClicked()
    PrintLn('Hola mundo: ' & @GUI_CtrlId)
EndFunc
Func _boton_agregarClicked()
    GUICtrlCreateTabItem(Random(1000, 2000, 1))
    GUICtrlCreateTabItem('')
EndFunc
Func _boton_cerrarClicked()
    If (_GUICtrlTab_GetItemCount($tab_control) > 1) Then
        $n = GUICtrlRead($tab_control)
        GUICtrlDelete(GUICtrlRead($tab_control, 1))
        _ArrayDelete($controles, $n)
    EndIf
EndFunc
#Region Case 10:
Func _boton_agregar_10Clicked()
    $texto = InputBox('GUITest.au3', 'Nuevo nombre:', '', '', 1, 125)
    If ($texto And Not (_GUICtrlComboBox_FindString($idCombo_10, $texto) > -1)) Then
        GUICtrlSetData($idCombo_10, $texto, $texto)
        ConsoleWrite('"$texto$" insertado.@LF@')
        _idCombo_10Changed()
    Else
        ConsoleWrite('Inserción de "$texto$" no permitida.@LF@')
    EndIf
EndFunc
Func _boton_cerrar_10Clicked()
    If (_GUICtrlComboBox_GetCount($idCombo_10) > 1) Then
        $i = _GUICtrlComboBox_GetCurSel($idCombo_10)
        _GUICtrlComboBox_DeleteString($idCombo_10, $i)
        _GUICtrlComboBox_SetCurSel($idCombo_10, 0)
        _idCombo_10Changed()
    EndIf
EndFunc
Func _idCombo_10Changed()
    $texto = GUICtrlRead($idCombo_10)
    $i = _GUICtrlComboBox_FindString($idCombo_10, $texto)
    If ($i > -1) Then
        ConsoleWrite('# $texto$ encontrado en $$idCombo_10@LF@')
        GUICtrlSetData($idCombo_10, $texto)
    Else
        ConsoleWrite('# $texto$ NO encontrado en $$idCombo_10@LF@')
        ;GUICtrlSetData($idCombo_10, $texto, $texto)
    EndIf
EndFunc
#EndRegion
Func _GUI_EVENT_CLOSE()
    GUIDelete()
    Exit
EndFunc

Func _inputChanged()
    $n = GUICtrlRead($tab_control) + 1
    PrintLn('$$n = $n$')
    For $i = 0 To 8
        PrintLn('$controles[$n][$i] = ' & $controles[$n][$i])
        If ($controles[$n][$i] == @GUI_CtrlId) Then
            PrintLn('Input activado: $i$')
            PrintLn('texto: "' & GUICtrlRead($controles[$n][$i]) & '"')
            Return
        EndIf
    Next
    PrintLn('')
EndFunc
Func _input_2Changed()

EndFunc
#EndRegion

#Region Funciones
Func _TabItemControls($titulo)

    $tab_item = GUICtrlCreateTabItem($titulo)
    GUICtrlSetImage($tab_item, 'au3.ico')

    #Region Control Constants
    $boton_alto = 10
    $ancho = 45
    $doble_ancho = 95
    $alto = 20
    $ES_INPUTFIJO = 0x0801
    $ES_INPUTENTRADA = 0x2001
    $screenProp = @DesktopWidth / @DesktopHeight
    Local $X = [6, 56, 106, 156, 206]
    Local $Y = [28, 53, 78, 103, 128]
    #EndRegion

    ; Fila 2
    $input1 = GUICtrlCreateInput('', $X[0], $Y[1], $ancho, $alto, $ES_INPUTENTRADA)
    $input2 = GUICtrlCreateInput('', $X[1], $Y[1], $ancho, $alto, $ES_INPUTENTRADA)
    $input3 = GUICtrlCreateInput('', $X[2], $Y[1], $doble_ancho, $alto, $ES_INPUTFIJO)

    ; Fila 3
    $input4 = GUICtrlCreateInput('', $X[0], $Y[2], $ancho, $alto, $ES_INPUTENTRADA)
    $input5 = GUICtrlCreateInput('', $X[1], $Y[2], $ancho, $alto, $ES_INPUTENTRADA)
    $input6 = GUICtrlCreateInput('', $X[2], $Y[2], $ancho, $alto, $ES_INPUTFIJO)
    $input7 = GUICtrlCreateInput('', $X[3], $Y[2], $ancho, $alto, $ES_INPUTFIJO)

    ; Fila 4
    $input8 = GUICtrlCreateInput('', $X[0], $Y[3], $ancho, $alto, $ES_INPUTFIJO)
    $input9 = GUICtrlCreateInput('', $X[1], $Y[3], $ancho, $alto, $ES_INPUTFIJO)

    ; Fila 5
    $button1 = GUICtrlCreateButton('', $X[0], $Y[4], $ancho, $boton_alto)
    GUICtrlSetBkColor(-1, 0x00FF00)
    $button2 = GUICtrlCreateButton('', $X[1], $Y[4], $ancho, $boton_alto)
    GUICtrlSetBkColor(-1, 0x00FF00)

    Local $sub_arr[1][11] = [ [ _
        $input1, $input2, $input3, $input4, $input5, $input6, $input7, _
        $input8, $input9, $button1, $button2 _
    ] ]

    GUICtrlSetOnEvent($input1, _inputChanged)
    GUICtrlSetOnEvent($input2, _inputChanged)
    GUICtrlSetOnEvent($input4, _inputChanged)
    GUICtrlSetOnEvent($input5, _inputChanged)

    _ArrayAdd($controles, $sub_arr)

    GUICtrlCreateTabItem('')

;~     PrintLn('Pestaña: $titulo$')
;~     PrintLn('$$input1: $input1$')
;~     PrintLn('$$input2: $input2$')
;~     PrintLn('$$input3: $input3$')
;~     PrintLn('$$input4: $input4$')
;~     PrintLn('$$input5: $input5$')
;~     PrintLn('$$input6: $input6$')
;~     PrintLn('$$input7: $input7$')
;~     PrintLn('$$input8: $input8$')
;~     PrintLn('$$input9: $input9$')
;~     PrintLn('')

EndFunc
#EndRegion