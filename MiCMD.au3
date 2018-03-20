#pragma compile(Icon, Icons/Terminal.ico)
#NoTrayIcon
Opt('ExpandEnvStrings', 1)
$dir = IniRead('MiCMD.ini', 'main', 'dir', '%homepath%')
Run('cmd', $dir)
