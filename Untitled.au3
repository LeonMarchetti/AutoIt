#Region Configuracion
#pragma compile(Out, Untitled.exe)
#pragma compile(Icon, au3.ico)
#NoTrayIcon
Opt('ExpandEnvStrings', 1)
Opt('ExpandVarStrings', 1)
#EndRegion
#Region Includes
;#include '_Fann.au3'
#include 'Funciones.au3'
#include 'MyDebug.au3'
#include <AutoItConstants.au3>
#include <ButtonConstants.au3>
#include <ColorConstants.au3>
#include <Date.au3>
#include <File.au3>
#include <FileConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <GUIListBox.au3>
#include <ListViewConstants.au3>
#include <MsgBoxConstants.au3>
#include <StaticConstants.au3>
#include <String.au3>
#include <TreeViewConstants.au3>
#include <WinAPIRes.au3>
#include <WindowsConstants.au3>
#EndRegion
#Region Constantes
Global Const $TITULO = "Untitled"
Global Const $FALLA = 0
Global Const $EXITO = 1
#EndRegion

; Funciones
Func _Test_AlternarSalvapantallas()
    AlternarSalvapantallas(False)
    MsgBox($MB_OK, $TITULO, "Salvapantallas desactivado")
    AlternarSalvapantallas(True)
    MsgBox($MB_OK, $TITULO, "Salvapantallas activado!")
EndFunc
Func _Test_ArrayToString()
    Local $array = [1, 2, 3, 4, 5]
    PrintLn(_ArrayToString($array, ", "))
EndFunc
#cs Func _Test_ANN()
    Const $net_file = "xor_float.net"
    ;Global $InputsArray[4][2] = [[-1, -1],[-1, 1],[1, -1],[1, 1]]
    ;Global $OutputsArray[4][1] = [[-1],[1],[1],[-1]]
    Global $InputsArray[4][2] = [[0, 0],[0, 1],[1, 0],[1, 1]]
    Global $OutputsArray[4][1] = [[0],[1],[1],[0]]
    Local $ANNLayers[3] = [2, 2, 1]
    _InitializeANN()
    $Ann = _CreateAnn(3, $ANNLayers)
    _ANNSetActivationFunctionHidden($Ann, $FANN_SIGMOID_SYMMETRIC)
    _ANNSetActivationFunctionOutput($Ann, $FANN_SIGMOID_SYMMETRIC)
    _ANNTrainOnData($Ann, $InputsArray, $OutputsArray, 5000, 10, 0.001)
    _ANNSaveToFile($Ann, $net_file)
    _DestroyANN($Ann)
    _CloseANN()

    _InitializeANN()
    $hAnn = _ANNCreateFromFile($net_file)

    PrintLn(@LF & "XOR:")
    For $i = 0 To 3
        Local $input = [ $InputsArray[$i][0], $InputsArray[$i][1] ]
        $calc_out = _ANNRun($hAnn, $input)
        PrintLn($input[0] & " XOR " & $input[1] & " = " & $calc_out[0] & @TAB & " ~ " & Round($calc_out[0], 0))
    Next

    PrintLn("")
    _MyDebug_ANNInfo($hAnn)

    _DestroyANN($hAnn)
    _CloseANN()
EndFunc
#ce
Func _Test_ArrayDelete()
    Local $arr[5][2]
    For $i = 0 To 4
        For $j = 0 To 1
            $arr[$i][$j] = ($i+1) * ($j+1)
        Next
    Next
    PrintLn(_ArrayToString($arr, ', '))
    PrintLn('= =')
    _ArrayDelete($arr, '0-2')
    PrintLn(_ArrayToString($arr, ', '))
EndFunc
Func _Test_Arrays()
    Local $arr[0][2]
    For $i = 0 To 4
        ;DebugLog('$i = ' & $i)
        Local $subArr = [[ $i, $i ]]
        Assert(IsArray($subArr), '$subArr no es arreglo')
        _ArrayAdd($arr, $subArr)
        Assert(UBound($arr) == ($i+1), 'Número incorrecto de elementos en $arr: ' & UBound($arr))
    Next
    Assert(UBound($arr) == 5, 'Número incorrecto de elementos en $arr: ' & UBound($arr))
    For $i = 0 To 4
        PrintLn('$arr[$i] = [' & $arr[$i][0] & ', ' & $arr[$i][1] & ']')
    Next
EndFunc
Func _Test_ArrayInsert()
    Local $arr_base[10]
    For $i = 0 To 9
        $n = Random(1, 5, 1)

        Local $sub_arr[$n]
        ;Assert(Not $sub_arr[0], 'Subarreglo no vacío')

        For $j = 0 To $n - 1
            $m = Random(0, 99, 1)

            $sub_arr[$j] = $m
            Assert($sub_arr[$j] = $m, 'Elemento no insertado en subarreglo: <' & $sub_arr[$j] & '>')
        Next

        $arr_base[$i] = $sub_arr
        Assert(IsArray($arr_base[$i]), 'Elemento de arreglo principal no es un arreglo')
    Next

    For $a = 0 To UBound($arr_base) - 1
        $sub_arr = $arr_base[$a]
        Assert(IsArray($sub_arr), 'Subrreglo $i$ no es un arreglo')
        $n = UBound($sub_arr)
        $str = _ArrayToString($sub_arr, ',', 0, $n-1)
        PrintLn('$a$|$n$|[$str$]')
    Next
EndFunc
Func _Test_Assert()
    $n = 0
    Assert($n == 0, "", "Hola mundo")
    Assert($n == 1, "Mundo hola")
EndFunc
Func _Test_ControlDoubleClick()
    $t = TimerInit()
    $i = 0
    ;$extrax = 2
    ;$extray = 24

    $gui = GUICreate("input double click")
    $input = GUICtrlCreateInput("",20,20)
    GUISetState()

    While 1
        Switch GUIGetMsg()
            Case -3
                Exit
            Case $GUI_EVENT_PRIMARYDOWN
                ;$extrax = 2
                ;$extray = 24
                $wpos = WinGetPos("input double click")
                $mpos = MouseGetPos()
                $ipos = ControlGetPos("input double click","",$input)
                #cs If_
                   ($mpos[0] > $wpos[0] + $ipos[0] + $extrax And _
                    $mpos[1] > $wpos[1] + $ipos[1] + $extray And _
                    $mpos[0] < $wpos[0] + $ipos[0] + $extrax + $ipos[2] And _
                    $mpos[1] < $wpos[1] + $ipos[1] + $extray + $ipos[3] ) Then

                    If TimerDiff($t) <= 500 And $i = 1 Then
                        GUICtrlSetData($input,"1")
                    Else
                        $t = TimerInit()
                        $i = 1
                    EndIf
                EndIf
                #ce
                If _
                   ($mpos[0] > $wpos[0] + $ipos[0] And _
                    $mpos[1] > $wpos[1] + $ipos[1] And _
                    $mpos[0] < $wpos[0] + $ipos[0] + $ipos[2] And _
                    $mpos[1] < $wpos[1] + $ipos[1] + $ipos[3] ) Then

                    If TimerDiff($t) <= 500 And $i = 1 Then
                        GUICtrlSetData($input,"1")
                    Else
                        $t = TimerInit()
                        $i = 1
                    EndIf
                EndIf
        EndSwitch
    WEnd
EndFunc
Func _Test_DesktopMacros()
    ; Funciona en wine
    PrintLn("Altura = " & @DesktopHeight)
    PrintLn("Ancho = " & @DesktopWidth)
EndFunc
Func _Test_DirGetSize()
    $sDir1 = 'C:\Windows'
    $sDir2 = 'C:\Users\LeoAM'
    PrintLn($sDir1 & ': ' & DirGetSize($sDir1) & ' B')
    PrintLn($sDir2 & ': ' & DirGetSize($sDir2) & ' B')
EndFunc
Func _Test_DirRemove()
    ;FileDelete("FILES")
    If (DirRemove("Untitled") == $FALLA) Then
        MostrarCartel($TITULO, "No se pudo borrar la carpeta.")
    EndIf
EndFunc
Func _Test_DllStruct()
    Local Const $struct = 'struct;int x; int y;int xImg;int yImg;endstruct'
    Local $o = DllStructCreate($struct)
    DllStructSetData($o, 'x', 1)
    DllStructSetData($o, 'y', 2)
    DllStructSetData($o, 'xImg', 3)
    DllStructSetData($o, 'yImg', 4)

    For $i = 1 To 4
        ConsoleWrite('$$o[$i$] = ' & DllStructGetData($o, $i) & @LF)
    Next

    ; ConsoleWrite('x = ' & DllStructGetData($o, 'x') & @LF)
    ; ConsoleWrite('y = ' & DllStructGetData($o, 'y') & @LF)
    ; ConsoleWrite('xImg = ' & DllStructGetData($o, 'xImg') & @LF)
    ; ConsoleWrite('yImg = ' & DllStructGetData($o, 'yImg') & @LF)
EndFunc
Func _Test_EnvVars()
    #include <Constants.au3>

    Local $PID = Run(@ComSpec & " /c set", @SystemDir, @SW_HIDE, $STDOUT_CHILD)
    Local $line
    While 1
        $line &= StdoutRead($PID)
        If @error Then ExitLoop
    Wend
    ConsoleWrite($Line)
EndFunc
Func _Test_Equals()
    If ('') Then
        ConsoleWrite('String vacío es True@LF@')
    Else
        ConsoleWrite('String vacío es False@LF@')
    EndIf
    If (0) Then
        ConsoleWrite('Cero es True@LF@')
    Else
        ConsoleWrite('Cero es False@LF@')
    EndIf
EndFunc
Func _Test_Exit()
    Exit
EndFunc
Func _Test_FileCopy()
    $old_file = "Untitled2.txt"
    ;$new_file = "Untitled.txt"
    $new_file = "FILES\Untitled.txt"
    ;Switch (FileCopy($old_file, $new_file))
    Switch (FileCopy($old_file, $new_file, $FC_CREATEPATH))
        Case $EXITO
            PrintLn("Copia exitosa.")
        Case $FALLA
            PrintLn("Error en la copia.")
    EndSwitch
EndFunc
Func _Test_FileRead()
    $links_file = "_Links.txt"
    #cs PrintLn(MostrarArreglo(LeerLineasArchivo("_Links.txt"), @LF))
    $asResultado = FileReadToArray("Untitled.txt")
    $tamano = UBound($asResultado)
    PrintLn("Tamaño arreglo: " & $tamano)
    For $i = 0 To $tamano - 1
        PrintLn($asResultado[$i])
    Next
    #ce
    ;PrintLn(FileRead("_Links.txt"))
    $archivo = FileOpen($links_file)
    FileSetPos($archivo, 50, $FILE_BEGIN)
    PrintLn(FileRead($archivo))
    FileClose($archivo)
EndFunc
Func _Test__FileWriteToLine()
    $sArchivo = "Untitled.txt"
    #cs Local $asEntrada = [
        ["Hola", "Mundo", "Auto", "It"], _
        ["Hola", "Mundo", "Auto", "It"]]
    _FileWriteFromArray($sArchivo, $asEntrada, Default, Default, "=")
    #ce
    $sNuevaLinea = "Beta2"
    $iLinea = 2
    _FileWriteToLine($sArchivo, $iLinea, $sNuevaLinea, 1)
EndFunc
Func _Test_For()
    For $i = 0 To 9
        PrintLn('$i = ' & $i)
    Next
EndFunc
Func _Test_GUICreate()
    ;Const $ES_GUI = $WS_CAPTION
    ;Const $ES_GUI = $WS_BORDER
    ;Const $ES_GUI = $WS_POPUP
    ;Const $ES_GUI = $WS_DLGFRAME
    #cs Const $ES_GUI = $WS_THICKFRAME
    Const $ES_EX_GUI = Default
    $hGUI = GUICreate("Mis Programas", 255, 0, 500, 400, $ES_GUI, $ES_EX_GUI)
    _GUI_Run($hGUI)
    #ce

    Opt("GUIOnEventMode", 1)
    GUICreate($TITULO, 100, 100)
    GUISetOnEvent($GUI_EVENT_PRIMARYUP, _Test_GUICreate_1)
    GUICtrlSetOnEvent(GUICtrlCreateButton("Hola", 10, 10, 80, 80), _Test_GUICreate_2)
    GUISetOnEvent($GUI_EVENT_CLOSE, _Test_Exit)
    GUISetState(@SW_SHOW)
    While True
        Sleep(100)
    WEnd
EndFunc
Func _Test_GUICreate_1()
    Local Static $i = 0
    PrintLn("Hola 1" & $i)
    $i += 1
EndFunc
Func _Test_GUICreate_2()
    Local Static $i = 0
    PrintLn("Hola 2" & $i)
    $i += 1
EndFunc
Func _Test_GUICtrlCreateEdit()
    Local $sText = '————————————————————————————————————————————————————————————————————————————————'
    Local Const $iANCHO = 675
    GUICreate($TITULO, $iANCHO + 10, 100)
    GUISetFont(10, Default, Default, 'Liberation Mono')
    GUICtrlCreateEdit($sText, 5, 5, $iANCHO, 90, (0x0800 + 0x00200000))
    GUICtrlSetBkColor(-1, 0xF0F4F9)
    GUICtrlSetColor(-1, 0x000090)
    GUISetState(@SW_SHOW)
    While 1
        Switch GUIGetMsg()
            Case -3
                ExitLoop
        EndSwitch
    WEnd
    GUIDelete()
EndFunc
Func _Test_GUICtrlRead()
    GUICreate($TITULO, 120, 70)
    $idBoton = GUICtrlCreateButton($TITULO, 10, 10, 100, 20)
    $idInput = GUICtrlCreateInput('', 10, 40, 100, 20)
    GUISetState(@SW_SHOW)
    While 1
        Switch GUIGetMsg()
            Case -3
                ExitLoop
            Case $idBoton
                $n = Int(GUICtrlRead($idInput))
                PrintLn((IsInt($n)) ? '$n es Int' : '$n no es Int')
                PrintLn('$idInput = ' & $n)
        EndSwitch
    WEnd
    GUIDelete()
EndFunc
Func _Test_GUIRun_GUI_EVENT_CLOSE()
    PrintLn("Closed")
EndFunc
Func _Test_GUIRun_idBotonClicked()
    PrintLn("Clicked")
EndFunc
Func _Test_GUIRun_idEditChanged($idEdit)
    PrintLn(_GUICtrlEdit_GetText($idEdit))
EndFunc
Func _Test_HotKeySet()
    #cs HotKeySet("^{p}", "_Test_HotKeySet_1")
    HotKeySet("^+{p}", "_Test_HotKeySet_2")
    #ce

    HotKeySet("{Joy1}", "_Test_HotKeySet_1")

    HotKeySet("{Esc}", "_Test_Exit")
    While 1
        Sleep(100)
    WEnd
EndFunc
Func _Test_HotKeySet_1()
    PrintLn("Hola mundo")
EndFunc
Func _Test_HotKeySet_2()
    PrintLn("Ctrl+Shift+P")
EndFunc
Func _Test_Idle_Function()
    Sleep(1000)
EndFunc
Func _Test_IniReadSection()
    Local $aArray = IniReadSection('Untitled.ini', 'main')
    Assert(@Error == 0, 'Error en IniReadSection("Untitled.ini", "main")')
    ; Enumerate through the array displaying the keys and their respective values.
    For $i = 1 To $aArray[0][0]
        $key = $aArray[$i][0]
        $val = $aArray[$i][1]
        PrintLn('$key$@TAB@$val$')
    Next
EndFunc
Func _Test_Input_idInputChanged()
    Local Static $i = 0
    PrintLn("_idInputChanged " & $i)
    $i+=1
EndFunc
Func _Test_IsType()
    GUICreate($TITULO)
    $idInput = GUICtrlCreateInput('', 0, 0, 100, 20)
    If (IsInt($idInput)) Then
        ConsoleWrite('$$idInput es Integer@LF@')
    Else
        ConsoleWrite('No sé@LF@')
    EndIf
EndFunc
Func _Test_LeerLineasArchivo()
    $hGUI = GUICreate("AutoIt")
    $asListaApps = LeerLineasArchivo("Apps.txt")
    $iCantidadApps = UBound($asListaApps)
    Local $aidBotones[$iCantidadApps]
    Local $aaEventos[$iCantidadApps]

    Local $sDrive, $sDir, $sFilename, $sExtension ; Para _PathSplit()
    For $i = 0 To $iCantidadApps - 1
        _PathSplit($asListaApps[$i], $sDrive, $sDir, $sFileName, $sExtension)
        $idBoton = GUICtrlCreateButton($sFileName, 0, 25 * $i, 220, 25, $BS_LEFT)
        GUICtrlSetFont($idBoton, 12)
        If GUICtrlSetImage($idBoton, $asListaApps[$i], 0, 1) <> 1 Then PrintLn("Icon Error")
        $aaEventos[$i] = CrearEventoGUI($idBoton, _Test_LeerLineasArchivo_idBotonClicked, $asListaApps[$i])
        $aidBotones[$i] = $idBoton
    Next

    GUIRun($hGUI, $aaEventos)
EndFunc
Func _Test_LeerLineasArchivo_idBotonClicked($sFileName)
    ShellExecute($sFileName)
    PrintLn($sFileName)
EndFunc
Func _Test_ListView()
    GUICreate("listview items", 220, 250, 100, 200, -1, $WS_EX_ACCEPTFILES)
    GUISetBkColor(0x00E0FFFF) ; will change background color

    Local $idListview = GUICtrlCreateListView("col1  |col2|col3  ", 10, 10, 200, 150) ;,$LVS_SORTDESCENDING)
    Local $idButton = GUICtrlCreateButton("Value?", 75, 170, 70, 20)
    Local $idItem1 = GUICtrlCreateListViewItem("item2|col22|col23", $idListview)
    Local $idItem2 = GUICtrlCreateListViewItem("............item1|col12|col13", $idListview)
    Local $idItem3 = GUICtrlCreateListViewItem("item3|col32|col33", $idListview)
    GUICtrlCreateInput("", 20, 200, 150)
    GUICtrlSetState(-1, $GUI_DROPACCEPTED) ; to allow drag and dropping
    GUISetState(@SW_SHOW)
    GUICtrlSetData($idItem2, "|ITEM1")
    GUICtrlSetData($idItem3, "||COL33")
    GUICtrlDelete($idItem1)

    ; Loop until the user exits.
    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                ExitLoop
            Case $idButton
                MsgBox($MB_SYSTEMMODAL, "listview item", GUICtrlRead(GUICtrlRead($idListview)), 2)
            Case $idListview
                MsgBox($MB_SYSTEMMODAL, "listview", "clicked=" & GUICtrlGetState($idListview), 2)
        EndSwitch
    WEnd
EndFunc
Func _Test_NowDate()
    PrintLn(StringRegExpReplace(_NowDate(), '/', ''))
EndFunc
Func _Test_Null()
    $var = _Test_Idle_Function()
    If $var == Null Then
        PrintLn("Es nulo")
    Else
        PrintLn("No es nulo")
    EndIf
EndFunc
Func _Test_ObjCreate()
    ; $oOpera = ObjCreate("Opera.application.1")
    ; $oOpera.url = "http://www.google.com"
    ; PrintLn($TITULO)

    ; $cache = ObjCreate('Scripting.Dictionary')
    ; Local Const $alfa = [15, 10, 5, 5]
    ; Local Const $gamma = [45, 30, 15, 15]
    ; $clave = 'alfa'

    ; $cache($clave) = $alfa
    ; $cache($clave) = $gamma
    ; $beta = $cache($clave)
    ; PrintLn(_ArrayToString($beta))

    $cache = ObjCreate('Scripting.Dictionary')
    Local $alfa = [1, 2, 3, 4, 5]
    Local $beta = [6, 7, 8, 9, 10]
    Local $gamma = [11, 12, 13, 14, 15]
    $cache('alfa') = $alfa
    $cache('beta') = $beta
    $cache('gamma') = $gamma
    For $k In $cache
        $v = $cache($k)
        $str = _ArrayToString($v)
        PrintLn('$k$: "$str$"')
    Next

EndFunc
Func _Test_PackVariables()
    $var1 = "Hola"
    $var2 = "Mundo"
    $var3 = 4
    $var4 = 5
    $var5 = "Bleh"
    $arreglo = PackVariables($var1, $var2, $var3, $var4, $var5)
    If $arreglo == 0 Then
        PrintLn("Arreglo es nulo")
    Else
        PrintLn(ArregloToString($arreglo, ", "))
    EndIf
EndFunc
Func _Test_PrintLn()
    ;Local Const $text = Hex(0x0800 + 0x00200000 + 0x00100000)
    ;Local Const $text = ChrW(0x250C)
    ;Local Const $text = 0x00200000
    ;Local Const $text = (0x00300800 == Dec("00800300")) ? 'Si' : 'No'
    ;PrintLn($text)
    $str1 = 'Hola'
    $str2 = 'Mundo'
    PrintLn('$str1$ $str2$')
    PrintLn(_StringRepeat('=', 80))
EndFunc
Func _Test_Run()
    $iPID = Run('git status', 'C:\Users\LeoAM\Baul\AutoIt', @SW_HIDE, $STDOUT_CHILD + $STDERR_CHILD)
    ProcessWaitClose($iPid)
    $salida = StdoutRead($iPID)
    If (@error) Then
        ConsoleWrite('Error@LF@')
    Else
        ConsoleWrite($salida)
        ConsoleWrite('================================@LF@')
        $regex = '(?m)^\t(?:modified:   )?(.+)$'
        $match = StringRegExp($salida, $regex)
        If (@error) Then
            ConsoleWrite('Patrón mal escrito@LF@')
        Else
            If ($match) Then
                $matches = StringRegExp($salida, $regex, 3)
                For $match In $matches
                    ConsoleWrite('* $match$@LF@')
                Next
            Else
                ConsoleWrite('No coincide@LF@')
            EndIf
        EndIf
    EndIf

    ;Run('cmd', '%baul%\github\Taller-sockets\tcp')
    ;Run('cmd', '')
EndFunc
Func _Test_ScriptLineNumber($n=@ScriptLineNumber)
    PrintLn("Linea: " & $n)
EndFunc
Func _Test_ShellExecute()
    #cs $sCommand = "C:\Program Files\Opera\launcher.exe"
    $sPrivate = "--private "
    $sSite    = "localhost/untitled.php"
    #ce

    ; $iPID = ShellExecute("dir")
    ; $sOutput = StdoutRead($iPID)
    ; PrintLn($sOutput)

    ; ShellExecute('C:\Users\LeoAM')
    Run('..\AutoHotkey\Untitled_args.ahk "cmd \k py"')
EndFunc
Func _Test_StringRegExp()
    Local $sFile = 'Garbage.c Match.c'
    Local $aMatch = StringRegExp($sFile, '(\w*).c', 1)
    If (@error) Then
        PrintLn('StringRegExp Error')
        Return
    EndIf
    PrintLn('Match: ' & StringRegExp($sFile, '(\w*).c', 1)[0])
    Local $i = 0
    For $e In $aMatch
        $i += 1
        PrintLn('[' & $i & ']: ' & $e)
    Next

EndFunc
Func _Test_StringRepeat()
    Local $sChar = '—'
    PrintLn(_StringRepeat('—', 80))
EndFunc
Func _Test_Tab()
    $hGUI = GUICreate($TITULO, 300, 300)
    GUISetFont(10, Default, Default, "Liberation Mono")
    ;$idBoton = GUICtrlCreateButton("Agregar", 0, 0, 300, 20)
    $idTab = GUICtrlCreateTab(0, 20, 300, 280)
    $idBoton = GUICtrlCreateButton("Agregar", 0, 0, 300, 20)
    GUICtrlCreateTabItem("Main Tab")
    GUICtrlCreateTabItem("")

    Local $aEventos = [ _
        CrearEventoGUI($idBoton, _Test_Tab_idBotonClicked, $idTab) _
    ]

    GUIRun($hGUI, $aEventos)
EndFunc
Func _Test_Tab_Func()
    $idBoton = GUICtrlCreateButton("Hola", 10, 50)
    AgregarEventoGUI($idBoton, _Test_Tab_idBotonTabClicked)
EndFunc
Func _Test_Tab_idBotonClicked($idTab)
    $i = Random(0, 100, 1)
    $sTitulo = "Tab " & $i
    AgregarTab($idTab, $sTitulo, _Test_Tab_Func)
EndFunc
Func _Test_Tab_idBotonTabClicked()
    PrintLn("Hola mundo")
EndFunc
Func _Test_Timer()
    $aResult = Timer(_Test_Idle_Function)
    PrintLn("Resultado: " & $aResult[0])
    PrintLn("Tiempo:    " & $aResult[1] & " ms.")
EndFunc
Func _Test_UBound()
    Local $arreglo[0]
    PrintLn('UBound = ' & UBound($arreglo))
EndFunc
Func _Test_WinActive()
    PrintLn("_Test_WinActive()")
    Opt("WinTitleMatchMode", 2)
    ;$hWnd = WinActive("Opera")
    ;If $hWnd Then
    If WinExists("Opera") Then
        WinActivate("Opera")
            Sleep(250)
        Send("^{t}")
            Sleep(250)
        MouseClick("left", 260, 50, 1, 0)
            Sleep(250)
        Send("www.google.com.ar")
            Sleep(250)
        Send("{Enter}")
    Else
        PrintLn("Opera no está abierto")
    EndIf
EndFunc
Func _Test_Zero()
    If (0) Then
        PrintLn("Zero gives True")
    Else
        PrintLn("Zero gives False")
    EndIf
EndFunc

; Ejecución
_Test_PrintLn()
