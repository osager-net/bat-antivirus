@echo off
setlocal enabledelayedexpansion
chcp 1251 >nul
cls

echo =================================
echo     ПАНЕЛЬ УПРАВЛЕНИЯ WINDOWS
echo =================================
echo v0.2 non-public
echo Вы запустили программу для резервного управления Windows. Сделано как спасение от вирусов, которые заблокировали доступ к встроенным программам.
echo.

:commands
echo Команды:
echo /commands (Повторное отображение команд и поля ввода)
echo /shutdown (Полное завершение работы компьютера) (Может быть опасно при добавлении вируса в автозапуск реестра)
echo /restart (Перезагрузка компьютера) (Может быть опасно при добавлении вируса в автозапуск реестра)
echo /enablemgr (Разрешение открытия диспетчера задач)
echo /taskmgr (Открытие диспетчера задач)
echo /exit (Закрытие программы управления) (Может быть опасно при активности вируса)
echo /lock (Блокировка компьютера)
echo /logoff (Выход из текущей учётной записи)
echo /hibernate (Перевод в режим гибернации)
echo /sleep (Перевод в спящий режим)
echo /update (Запуск проверки и установки обновлений Windows)
echo /clean (Запуск утилиты очистки диска)
echo /msconfig (Открытие конфигурации системы)
echo /regedit (Запуск редактора реестра)
echo /cmd (Открытие командной строки)
echo /powershell (Запуск PowerShell)
echo /devmgmt (Открытие диспетчера устройств)
echo /services (Запуск оснастки «Службы»)
echo /eventvwr (Открытие просмотра событий)
echo /explorer (Открытие проводника)
echo /desktop (Переход к папке рабочего стола)
echo /documents (Открытие папки «Документы»)
echo /downloads (Переход к папке загрузок)
echo /temp (Открытие временной папки)
echo /ipconfig (Вывод информации о сетевых подключениях)
echo /ping [адрес] (Проверка связи с указанным хостом)
echo /netstat (Отображение активных сетевых соединений)
echo /wifi (Управление Wi‑Fi подключениями)
echo /perfmon (Запуск монитора производительности)
echo /resmon (Открытие монитора ресурсов)
echo /dxdiag (Запуск средства диагностики DirectX)
echo /systeminfo (Вывод подробной информации о системе)
echo /volume (Управление громкостью)
echo /brightness [%] (Регулировка яркости экрана)
echo /wallpaper [путь] (Смена обоев рабочего стола)
echo /screenshot (Создание скриншота)
echo /calc (Запуск калькулятора)
echo /notepad (Открытие Блокнота)
echo /paint (Запуск Paint)
echo /wordpad (Открытие WordPad)
echo /snipping (Запуск инструмента «Ножницы»)
echo /info (Вывод сведений о системе)
echo /time (Показ текущего времени и даты)
echo /battery (Статус батареи для ноутбуков)
echo /diskusage (Информация о занятом и свободном месте на дисках)
echo.

set /p command=Введите команду:
if "!command!"=="/commands" goto commands
if "!command!"=="/shutdown" goto shutdown
if "!command!"=="/restart" goto restart
if "!command!"=="/enablemgr" goto enablemgr
if "!command!"=="/taskmgr" goto taskmgr
if "!command!"=="/exit" goto exit
if "!command!"=="/lock" goto lock
if "!command!"=="/logoff" goto logoff
if "!command!"=="/hibernate" goto hibernate
if "!command!"=="/sleep" goto sleep
if "!command!"=="/update" goto update
if "!command!"=="/clean" goto clean
if "!command!"=="/msconfig" goto msconfig
if "!command!"=="/regedit" goto regedit
if "!command!"=="/cmd" goto cmd
if "!command!"=="/powershell" goto powershell
if "!command!"=="/devmgmt" goto devmgmt
if "!command!"=="/services" goto services
if "!command!"=="/eventvwr" goto eventvwr
if "!command!"=="/explorer" goto explorer
if "!command!"=="/desktop" goto desktop
if "!command!"=="/documents" goto documents
if "!command!"=="/downloads" goto downloads
if "!command!"=="/temp" goto temp
if "!command!"=="/ipconfig" goto ipconfig
if "!command!"=="/ping" goto ping
if "!command!"=="/netstat" goto netstat
if "!command!"=="/wifi" goto wifi
if "!command!"=="/perfmon" goto perfmon
if "!command!"=="/resmon" goto resmon
if "!command!"=="/dxdiag" goto dxdiag
if "!command!"=="/systeminfo" goto systeminfo
if "!command!"=="/volume" goto volume
if "!command!"=="/brightness" goto brightness
if "!command!"=="/wallpaper" goto wallpaper
if "!command!"=="/screenshot" goto screenshot
if "!command!"=="/calc" goto calc
if "!command!"=="/notepad" goto notepad
if "!command!"=="/paint" goto paint
if "!command!"=="/wordpad" goto wordpad
if "!command!"=="/snipping" goto snipping
if "!command!"=="/info" goto info
if "!command!"=="/time" goto time
if "!command!"=="/battery" goto battery
if "!command!"=="/diskusage" goto diskusage
goto noncmd

:shutdown
echo Стартует выключение...
shutdown /s /t 0
goto :eof

:restart
echo Стартует перезагрузка...
shutdown /r /t 0
goto commands

:enablemgr
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /f >nul 2>&1
if !errorlevel! equ 0 (
    echo Диспетчер задач успешно разблокирован.
) else (
    echo Ошибка: диспетчер задач уже разблокирован или произошла ошибка.
)
echo -----------------------------------
pause
goto commands

:taskmgr
start taskmgr.exe
echo Диспетчер задач открыт. Если он не появился, возможно, вирус заблокировал его.
echo -----------------------------------
pause
goto commands

:lock
echo Блокировка компьютера...
rundll32.exe user32.dll,LockWorkStation
goto commands

:logoff
echo Выход из учётной записи...
shutdown /l
goto commands

:hibernate
echo Перевод в режим гибернации...
shutdown /h
goto commands

:sleep
echo Перевод в спящий режим...
rundll32.exe powrprof.dll,SetSuspendState 0,1,0
goto commands

:update
echo Запуск проверки обновлений...
start ms-settings:windowsupdate
goto commands

:clean
echo Запуск очистки диска...
cleanmgr
goto commands

:msconfig
echo Открытие конфигурации системы...
start msconfig
goto commands

:regedit
echo Запуск редактора реестра...
start regedit
goto commands

:cmd
echo Открытие командной строки...
start cmd
goto commands

:powershell
echo Запуск PowerShell...
start powershell
goto commands

:devmgmt
echo Открытие диспетчера устройств...
start devmgmt.msc
goto commands

:services
echo Запуск оснастки «Службы»...
start services.msc
goto commands

:eventvwr
echo Открытие просмотра событий...
start eventvwr
goto commands

:explorer
echo Открытие проводника...
start explorer
goto commands

:desktop
echo Переход к рабочему столу...
start %USERPROFILE%\Desktop
goto commands

:documents
echo Открытие папки «Документы»...
start %USERPROFILE%\Documents
goto commands

:downloads
echo Переход к папке загрузок...
start %USERPROFILE%\Downloads
goto commands

:temp
echo Открытие временной папки...
start %TEMP%
goto commands

:ipconfig
echo Вывод информации о сетевых подключениях...
ipconfig /all
pause
goto commands

:ping
set /p host=Введите адрес для проверки (например, google.com):
echo Проверка связи с !host!...
ping !host! -n 4
pause
goto commands

:netstat
echo Отображение активных сетевых соединений...
netstat -an
pause
goto commands

:wifi
echo Управление Wi‑Fi...
start ms-settings:network-wifi
goto commands

:perfmon
echo Запуск монитора производительности...
start perfmon
goto commands

:resmon
echo Открытие монитора ресурсов...
start resmon
goto commands

:dxdiag
echo Запуск диагностики DirectX...
start dxdiag
goto commands

:systeminfo
echo Вывод информации о системе...
systeminfo
pause
goto commands

:volume
echo Запуск регулятора громкости...
start sndvol
goto commands

:brightness
echo Регулировка яркости экрана...
start powercfg.cpl
echo Для изменения яркости перейдите в раздел «Электропитание» → «Настройка плана электропитания» → «Изменить дополнительные параметры питания».
pause
goto commands
