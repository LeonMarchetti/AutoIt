#pragma compile(Icon, Icons\Terminal.ico)
#pragma compile(Out, MiCMD.exe)
#NoTrayIcon
Opt('ExpandEnvStrings', 1)


Global $default_dir = '%homepath%'
$dir = IniRead('MiCMD.ini', 'main', 'dir', $default_dir)
If $dir = $default_dir Then
    MsgBox(64, 'Mi CMD', 'Se cargó el directorio por defecto')
EndIf
Run('cmd', $dir)
