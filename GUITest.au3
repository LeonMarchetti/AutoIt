#Region Configuración
#include <Array.au3>
#include 'Funciones.au3'
#NoTrayIcon
Opt('GUIOnEventMode', 1)
#EndRegion

Global Const $MODULO = 6

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
Func _GUI_EVENT_CLOSE()
    GUIDelete()
    Exit
EndFunc
#EndRegion
