; https://www.autoitscript.com/autoit3/docs/libfunctions/_WinAPI_GetSystemPowerStatus.htm
#pragma compile(Icon, Icons\au3.ico)
#pragma compile(Out, Battery Checker.exe)

#include <Date.au3>
#include <MsgBoxConstants.au3>
#include <WinAPISys.au3>

Const $AC_OFF = 0
Const $AC_ON = 1
Const $EST_BATERIA_DESC = 255
Const $MSGBOX_FLAG = BitOR($MB_ICONWARNING, $MB_OK, $MB_TOPMOST)

Global $t ; Variable para medir tiempo entre carga y descarga.
Global $carga_min
Global $carga_max

CargarLimites()
ArrancarTemporizador()

While True
    Sleep(100)
    $estado_bateria = _WinAPI_GetSystemPowerStatus()
    $carga = $estado_bateria[2]
    TraySetToolTip("La carga es de " & $carga & "%.")

    Switch $estado_bateria[0]

        Case $AC_OFF ; Cargador desconectado
            If $carga <= $carga_min Then
                $minseg = ConvertirSegMin(CalcularTiempo())
                MsgBox( _
                    $MSGBOX_FLAG, _
                    "Battery Checker", _
                    "¡Conectar cargador!" & @LF _
                        & "Tiempo de descarga: " & _
                            $minseg[0] & ' minutos, ' & _
                            $minseg[1] & 'segundos.')

            ElseIf $carga == $EST_BATERIA_DESC Then
                ErrorBateria()
            EndIf

        Case $AC_ON ; Cargando
            If $carga >= $carga_max Then
                $minseg = ConvertirSegMin(CalcularTiempo())
                MsgBox( _
                    $MSGBOX_FLAG, _
                    "Battery Checker", _
                    "¡Desconectar cargador!" & @LF _
                        & "Tiempo de carga: " & _
                            $minseg[0] & ' minutos, ' & _
                            $minseg[1] & 'segundos.')
            ElseIf $carga == $EST_BATERIA_DESC Then
                ErrorBateria()
            EndIf

    EndSwitch

WEnd

Func CargarLimites()
    ; Carga los niveles de carga mínima y máxima. Si no los encuentra, pone un
    ; valor negativo por defecto. Un valor negativo en cualquiera de los límites
    ; hace terminar el programa.
    $carga_min = Int(IniRead("Battery Checker.ini", "main", "min", -1))
    $carga_max = Int(IniRead("Battery Checker.ini", "main", "max", -1))
    If ($carga_min < 0) Or ($carga_max < 0) Then
        MsgBox( _
            BitOR($MB_ICONERROR, $MB_OK), _
            "Battery Checker", _
            "¡Error lectura de archivo de configuración!")
        Exit
    EndIf
EndFunc

Func ArrancarTemporizador()
    $t = _NowCalc()
EndFunc

Func CalcularTiempo()
    ; Calcula la diferencia entre la última medida de tiempo y cuando se llama a
    ; la función, actualiza la variable de tiempo y regresa la diferencia.
    $ahora = _NowCalc()
    $diferencia = _DateDiff('s', $t, $ahora)
    $t = $ahora
    Return $diferencia
EndFunc

Func ConvertirSegMin($s)
    ; A partir de los segundos dados se calcula la cantidad de minutos y los
    ; segundos de sobra.
    Local $ms[2]            ; Arreglo [Minutos, Segundos]
    $ms[0] = Int($s / 60)   ; Minutos
    $ms[1] = Mod($s, 60)    ; Segundos
    Return $ms
EndFunc

Func ErrorBateria()
    ; Muestra un mensaje si no se pudo medir la batería y termina el programa.
    MsgBox( _
        BitOR($MB_ICONERROR, $MB_OK, $MB_TOPMOST), _
        "Battery Checker", _
        "Error: ¡Estado de batería desconocido!")
    Exit
EndFunc