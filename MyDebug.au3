#Region Includes
#include-once
;#include "_Fann.au3"
#include <Array.au3>
#include <GUIConstantsEx.au3>
#include <StringSize.au3>
#EndRegion

#Region Global Variables
Global Const $aEventIdMsg = [ _
    [0, "No event."], _
    [$GUI_EVENT_CLOSE,         'CLOSE'], _
    [$GUI_EVENT_MINIMIZE,      'MINIMIZE'], _
    [$GUI_EVENT_RESTORE,       'RESTORE'], _
    [$GUI_EVENT_MAXIMIZE,      'MAXIMIZE'], _
    [$GUI_EVENT_MOUSEMOVE,     'MOUSEMOVE'], _
    [$GUI_EVENT_PRIMARYDOWN,   'PRIMARYDOWN'], _
    [$GUI_EVENT_PRIMARYUP,     'PRIMARYUP'], _
    [$GUI_EVENT_SECONDARYDOWN, 'SECONDARYDOWN'], _
    [$GUI_EVENT_SECONDARYUP,   'SECONDARYUP'], _
    [$GUI_EVENT_RESIZED,       'RESIZED'], _
    [$GUI_EVENT_DROPPED,       'DROPPED'] _
]
#EndRegion

; Funciones
#cs Func _MyDebug_ANNInfo($hAnn)
    ConsoleWrite("NumInput: "         & @TAB & @TAB & _ANNGetNumInput($hAnn) & @LF)
    ConsoleWrite("NumOutput: "        & @TAB & @TAB & _ANNGetNumOutput($hAnn) & @LF)
    ConsoleWrite("TotalNeurons: "     & @TAB & @TAB & _ANNGetTotalNeurons($hAnn) & @LF)
    ConsoleWrite("TotalConnections: " & @TAB & _ANNGetTotalConnections($hAnn) & @LF)
    ConsoleWrite("NumLayers: "        & @TAB & @TAB & _ANNGetNumLayers($hAnn) & @LF)
EndFunc
#ce
Func _MyDebug_ArrayAccess($aArray, $iIndex)
    Select
        Case $iIndex < 0
            ConsoleWrite('Index is negative' & @LF)
            ConsoleWrite('    index = ' & $iIndex & @LF)
        Case $iIndex >= UBound($aArray)
            ConsoleWrite('Index is out of bounds' & @LF)
            ConsoleWrite('    index  = ' & $iIndex & @LF)
            ConsoleWrite('    length = ' & UBound($aArray) & @LF)
        Case UBound($aArray, 0) > 1
            ConsoleWrite('Incorrect number of subscripts' & @LF)
            ConsoleWrite('    subscripts  = ' & UBound($aArray, 0) & @LF)
        Case Else
            ConsoleWrite('Array access successful' & @LF)
            ConsoleWrite('    value = ' & $aArray[$iIndex] & @LF)
        EndSelect

    Return $aArray[$iIndex]
EndFunc
Func _MyDebug_CheckType($var)
    If IsArray($var) Then
        ConsoleWrite('Es arreglo' & @LF)
    ElseIf IsBinary($var) Then
        ConsoleWrite('Es binario' & @LF)
    ElseIf IsBool($var) Then
        ConsoleWrite('Es booleano' & @LF)
    ElseIf IsDllStruct($var) Then
        ConsoleWrite('Es dll struct' & @LF)
    ElseIf IsFloat($var) Then
        ConsoleWrite('Es flotante' & @LF)
    ElseIf IsFunc($var) Then
        ConsoleWrite('Es función' & @LF)
    ElseIf IsHWnd($var) Then
        ConsoleWrite('Es handle window' & @LF)
    ElseIf IsInt($var) Then
        ConsoleWrite('Es entero' & @LF)
    ElseIf IsString($var) Then
        ConsoleWrite('Es string' & @LF)
    EndIf
EndFunc
Func _MyDebug_FileExists($file)
    If FileExists($file) Then
        ConsoleWrite('"' & $file & '" existe.' & @LF)
    Else
        ConsoleWrite('"' & $file & '" no existe.' & @LF)
    EndIf
EndFunc
Func _MyDebug_GUIGetMsg()
    $aMsg = GUIGetMsg(1)

    $iSearch = _ArraySearch($aEventIdMsg, $aMsg[0])
    ConsoleWrite('EventId = ' & (($iSearch == -1) ? _
                                 $aMsg[0] : _
                                 $aEventIdMsg[$iSearch][1]) & @LF)
    ConsoleWrite('Window handle:  [' & $aMsg[1] & ']' & @LF)
    ConsoleWrite('Control handle: [' & $aMsg[2] & ']' & @LF)
    ConsoleWrite('Pos:            [' & $aMsg[3] & ', ' & $aMsg[4] & ']' & @LF)

    Return $aMsg
EndFunc
Func _MyDebug_StringSize($sText)
    $aStringSize = _StringSize($sText, 10, 400, 0, 'Liberation Mono')
    If (@error) Then
        Switch(@error)
            Case 1
                ConsoleWrite('Tipo de parámetro incorrecto: ' & @extended & @LF)
            Case 2
                ConsoleWrite('Error de llamada a librería: ')
                Switch (@extended)
                    Case 1
                        ConsoleWrite('GetDC' & @LF)
                    Case 2
                        ConsoleWrite('SendMessage' & @LF)
                    Case 3
                        ConsoleWrite('GetDeviceCaps' & @LF)
                    Case 4
                        ConsoleWrite('CreateFont' & @LF)
                    Case 5
                        ConsoleWrite('SelectObject' & @LF)
                    Case 6
                        ConsoleWrite('GetTextExtentPoint32' & @LF)
                EndSwitch
            Case 3
                ConsoleWrite('Fuente muy grande para el ancho máximo elegido.' & @LF)
        EndSwitch
    Else
        ConsoleWrite('Original string: ' & $aStringSize[0] & @LF)
        ConsoleWrite('Height         : ' & $aStringSize[1] & @LF)
        ConsoleWrite('Width          : ' & $aStringSize[2] & @LF)
        ConsoleWrite('Height         : ' & $aStringSize[3] & @LF)
    EndIf
EndFunc
Func _MyDebug_UBound($aArray)
    ConsoleWrite('Dimensions = ' & UBound($aArray, 0) & @LF)
    ConsoleWrite('Rows       = ' & UBound($aArray, 1) & @LF)
    ConsoleWrite('Columns    = ' & UBound($aArray, 2) & @LF)
EndFunc
Func _MyDebug_WinActivate($hWnd)
    $handle = WinActivate($hWnd)
    If ($handle) Then
        Switch @extended
            Case 1
                ConsoleWrite('Window was already active' & @LF)
            Case 2
                ConsoleWrite('Window was not already active' & @LF)
        EndSwitch
        ConsoleWrite((WinActive($hWnd) ? 'Window is active' : 'Window is not active') & @LF)
    Else
        ConsoleWrite('Window is not found or cannot be activated.' & @LF)
    EndIf

    Return $handle
EndFunc
