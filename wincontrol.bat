@echo off
setlocal enabledelayedexpansion
chcp 1251 >nul
cls

echo =================================
echo     ПАНЕЛЬ УПРАВЛЕНИЯ WINDOWS
echo =================================
echo v0.3 public
echo Программа для восстановления доступа к Windows при вирусной атаке.
echo.

:commands
echo Доступные команды:
echo /commands (Показать список команд)
echo /shutdown (Выключение компьютера)
echo /restart (Перезагрузка компьютера)
echo /enablemgr (Разблокировать диспетчер задач)
echo /taskmgr (Открыть диспетчер задач)
echo /lock (Заблокировать компьютер)
echo /logoff (Выйти из учётной записи)
echo /hibernate (Гибернация)
echo /sleep (Спящий режим)
echo /clean (Очистка диска)
echo /msconfig (Конфигурация системы)
echo /regedit (Редактор реестра)
echo /cmd (Командная строка)
echo /powershell (PowerShell)
echo /devmgmt (Диспетчер устройств)
echo /services (Службы)
echo /eventvwr (Просмотр событий)
echo /ipconfig (Информация о сети)
echo /ping [адрес] (Проверка связи)
echo /netstat (Активные сетевые соединения)
echo /dxdiag (Диагностика DirectX)
echo /systeminfo (Информация о системе)
echo /info (Краткий обзор системы)
echo /battery (Статус батареи)
echo /diskusage (Использование дисков)
echo /exit (Выход из программы)
echo.

set /p command=Введите команду:
if "!command!"=="" goto noncmd
if "!command!"=="/commands" goto commands
if "!command!"=="/shutdown" goto shutdown
if "!command!"=="/restart" goto restart
if "!command!"=="/enablemgr" goto enablemgr
if "!command!"=="/taskmgr" goto taskmgr
if "!command!"=="/lock" goto lock
if "!command!"=="/logoff" goto logoff
if "!command!"=="/hibernate" goto hibernate
if "!command!"=="/sleep" goto sleep
if "!command!"=="/clean" goto clean
if "!command!"=="/msconfig" goto msconfig
if "!command!"=="/regedit" goto regedit
if "!command!"=="/cmd" goto cmd
if "!command!"=="/powershell" goto powershell
if "!command!"=="/devmgmt" goto devmgmt
if "!command!"=="/services" goto services
if "!command!"=="/eventvwr" goto eventvwr
if "!command!"=="/ipconfig" goto ipconfig
if "!command!"=="/ping" goto ping
if "!command!"=="/netstat" goto netstat
if "!command!"=="/dxdiag" goto dxdiag
if "!command!"=="/systeminfo" goto systeminfo
if "!command!"=="/info" goto info
if "!command!"=="/battery" goto battery
if "!command!"=="/diskusage" goto diskusage
if "!command!"=="/exit" goto exit
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


:ipconfig
echo Вывод информации о сетевых подключениях...
ipconfig /all
pause
goto commands

:ping
set /p host=Введите адрес для проверки (например, google.com):
if "!host!"=="" (
    echo Ошибка: адрес не введён.
    pause
    goto commands
)
echo Проверка связи с !host!...
ping !host! -n 4
pause
goto commands

:netstat
echo Отображение активных сетевых соединений...
netstat -an
pause
goto commands

:dxdiag
echo Запуск диагностики DirectX...
start dxdiag
goto commands

:systeminfo
echo Вывод подробной информации о системе...
systeminfo
pause
goto commands

:info
echo Краткий обзор системы...
echo.
echo ОС:
ver
echo.
echo Процессор:
wmic cpu get name /format:list
echo.
echo Память:
wmic computersystem get totalphysicalmemory /format:list
echo.
pause
goto commands

:battery
echo Статус батареи...
powercfg /batteryreport
echo Отчёт сохранён как battery-report.html
for /f "tokens=2 delims==" %%i in ('wmic path Win32_Battery get EstimatedChargeRemaining /value 2^>nul') do set "charge=%%i"
if defined charge (
    if !charge! neq "" echo Заряд: !charge!%%
)
pause
goto commands

:diskusage
echo Использование дисков (ГБ):
echo.
for /f "tokens=1,2,3" %%a in ('wmic logicaldisk where "DriveType=3" get caption^,freespace^,size /format:table 2^>nul') do (
    if "%%b" neq "" (
        set /a free_gb=%%b/1073741824
        set /a total_gb=%%c/1073741824
        echo %%a: !free_gb! ГБ свободно из !total_gb! ГБ
    )
)
echo.
pause
goto commands

:exit
echo Закрываем программу.
pause
exit

:noncmd
echo Команда "!command!" не существует. Попробуйте ещё раз.
echo -----------------------------------
pause
goto commands
