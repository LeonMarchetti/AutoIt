#Region Configuración
#pragma compile(Icon, Icons\au3.ico)
#NoTrayIcon
Opt('ExpandEnvStrings', 1)
Opt('GUIOnEventMode', 1)
#EndRegion

#Region Includes
#include <Array.au3>
#include <File.au3>
#include <GUIListBox.au3>
#EndRegion

#Region Variables globales
Global Enum $COPIAR_1_A_2, $COPIAR_2_A_1
Global $idInput1, $idInput2, $idList1, $idList2
#EndRegion

#Region Manejadores de eventos
Func _GUI_EVENT_CLOSE()
    GUIDelete()
    Exit
EndFunc
Func _idBotonClicked()
    Local $bError = False
    Local $sErrorMsg = ''

    Local Const $sCarpeta1 = _LeerNombreCarpeta($idInput1)
    If (@error Or $sCarpeta1 = '') Then
        GUICtrlSetData($idInput1, '')
        $bError = True
        $sErrorMsg = 'Entrada 1: "' & $sCarpeta1 & '" es incorrecto.' & @LF
    EndIf

    Local Const $sCarpeta2 = _LeerNombreCarpeta($idInput2)
    If (@error Or $sCarpeta2 = '') Then
        GUICtrlSetData($idInput2, '')
        $bError = True
        $sErrorMsg = $sErrorMsg & 'Entrada 2: "' & $sCarpeta2 & '" es incorrecto.'
    EndIf

    If ($bError) Then
        MsgBox($MB_ICONERROR, 'Comparador de Carpetas', $sErrorMsg)
        Return
    EndIf

    Local Const $aCarpeta1 = _FileListToArray($sCarpeta1, '*', $FLTA_FILES)
    Local Const $aCarpeta2 = _FileListToArray($sCarpeta2, '*', $FLTA_FILES)

    _ArmarLista($aCarpeta1, $aCarpeta2, $idList1)
    _ArmarLista($aCarpeta2, $aCarpeta1, $idList2)
EndFunc
Func _idBotonCopiar1Clicked()
    _Copiar($COPIAR_1_A_2)
EndFunc
Func _idBotonCopiar2Clicked()
    _Copiar($COPIAR_2_A_1)
EndFunc
Func _idInput1Changed()
    _VaciarListas()
EndFunc
Func _idInput2Changed()
    _VaciarListas()
EndFunc
Func _idList1Clicked()
    _BorrarItemLista($idList1)
EndFunc
Func _idList2Clicked()
    _BorrarItemLista($idList1)
EndFunc
#EndRegion

#Region Funciones
Func _ArmarLista($aCarpetaA, $aCarpetaB, $idList)
    GUICtrlSetData($idList, "")
    For $i = 1 To $aCarpetaA[0]
        _ArraySearch($aCarpetaB, $aCarpetaA[$i])
        If (@error) Then _
            GUICtrlSetData($idList, $aCarpetaA[$i])
    Next
EndFunc
Func _BorrarItemLista($idList)
    Local Const $iListItemIndex = _GUICtrlListBox_GetCurSel($idList)
    Local Const $sArchivo = _GUICtrlListBox_GetText($idList, $iListItemIndex)
    If (MsgBox($MB_YESNO, 'Comparador de Carpetas', _
                '¿Quiere sacar a "' & $sArchivo & '" de la lista?') == $IDYES) Then
        _GUICtrlListBox_DeleteString($idList, $iListItemIndex)
    EndIf
EndFunc
Func _Copiar($flag)
    Local $idListSRC, $idInputSRC, $idInputDST
    Switch ($flag)
        Case $COPIAR_1_A_2
            $idListSRC = $idList1
            $idInputSRC = $idInput1
            $idInputDST = $idInput2
        Case $COPIAR_2_A_1
            $idListSRC = $idList2
            $idInputSRC = $idInput2
            $idInputDST = $idInput1
    EndSwitch

    Local Const $sDirSRC = GUICtrlRead($idInputSRC)
    Local Const $sDirDST = GUICtrlRead($idInputDST)
    Local Const $iItems = _GUICtrlListBox_GetCount($idListSRC)
    Local $asArchivosNoCopiados[0]
    Local $sArchivo, $iCopyResult
    For $i = 0 To $iItems - 1
        $sArchivo = _GUICtrlListBox_GetText($idListSRC, $i)
        $iCopyResult = FileCopy($sDirSRC & '\' & $sArchivo, _
                                $sDirDST & '\' & $sArchivo)
        If ($iCopyResult == 0) Then _
            _ArrayAdd($asArchivosNoCopiados, $sArchivo)
    Next

    If (UBound($asArchivosNoCopiados) > 0) Then
        MsgBox($MB_ICONERROR, 'Comparador de Carpetas', _
                              'No se pudo copiar los archivos: "' & _
                                  _ArrayToString($asArchivosNoCopiados, ', ') & '"')
    EndIf
    GUICtrlSetData($idListSRC, '')
EndFunc
Func _LeerNombreCarpeta($idInput)
    Local Const $sCarpeta = GUICtrlRead($idInput)
    DirGetSize($sCarpeta)
    If (@error) Then
        SetError(@error)
    Else
        Return $sCarpeta
    EndIf
EndFunc
Func _VaciarListas()
    GUICtrlSetData($idList1, "")
    GUICtrlSetData($idList2, "")
EndFunc
#EndRegion

#Region Interfaz gráfica
GUICreate('Comparador de Carpetas', 620, 93)
GUISetFont(10, Default, Default, 'Liberation Mono')

GUICtrlCreateLabel('Origen:', 5, 5, 64, 12)
$idInput1 = GUICtrlCreateInput('', 5, 18, 205, 17)
GUICtrlCreateLabel('Destino:', 5, 35, 64, 12)
$idInput2 = GUICtrlCreateInput('', 5, 48, 205, 17)
$idBoton = GUICtrlCreateButton('Comparar', 5, 69, 205, 20)

; Panel lateral:
$idBotonCopiar1 = GUICtrlCreateButton('Copiar a Carpeta 2 =>', 214, 0, 200, 20)
$idBotonCopiar2 = GUICtrlCreateButton('<= Copiar a Carpeta 1', 415, 0, 200, 20)
$idList1 = GUICtrlCreateList('', 215, 20, 200, 80)
$idList2 = GUICtrlCreateList('', 415, 20, 200, 80)

GUICtrlSetOnEvent($idBoton, _idBotonClicked)
GUICtrlSetOnEvent($idBotonCopiar1, _idBotonCopiar1Clicked)
GUICtrlSetOnEvent($idBotonCopiar2, _idBotonCopiar2Clicked)
GUICtrlSetOnEvent($idInput1, _idInput1Changed)
GUICtrlSetOnEvent($idInput2, _idInput2Changed)
GUICtrlSetOnEvent($idList1, _idList1Clicked)
GUICtrlSetOnEvent($idList2, _idList2Clicked)
GUISetOnEvent(-3, _GUI_EVENT_CLOSE)

GUISetState(@SW_SHOW)
While 1
    Sleep(100)
WEnd
#EndRegion