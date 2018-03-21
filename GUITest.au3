#Region Configuración
#include <Array.au3>
#include 'Funciones.au3'
#NoTrayIcon
Opt('GUIOnEventMode', 1)
#EndRegion

Global Const $MODULO = 7

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
    _TabItemControls('Dup')
EndFunc
Func _boton_cerrarClicked()
    GUICtrlDelete(GUICtrlRead($tab_control, 1))
EndFunc
Func _GUI_EVENT_CLOSE()
    GUIDelete()
    Exit
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

    ; Fila 1
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

    GUICtrlCreateTabItem('')
EndFunc
#EndRegion