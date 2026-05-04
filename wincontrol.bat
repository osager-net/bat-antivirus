@echo off
setlocal enabledelayedexpansion
:: Проверка и установка кодировки
chcp 1251 >nul 2>&1
if errorlevel 1 echo Предупреждение: не удалось установить кодировку CP1251.
cls

echo =================================
echo     ПАНЕЛЬ УПРАВЛЕНИЯ WINDOWS
echo =================================
echo v1.0 nonpublic
echo Программа управления системой во время заражения или для быстрого доступа к функциям.
echo.

:commands
echo КОМАНДЫ:
echo /commands (Показать список команд)
echo /shutdown (Выключение компьютера)
echo /restart (Перезагрузка компьютера)
echo /enablemgr (Разблокировать диспетчер задач)
echo /taskmgr (Открыть диспетчер задач)
echo /logoff (Выйти из учётной записи)
echo /clean (Очистка диска)
echo /msconfig (Конфигурация системы — автозагрузка)
echo /regedit (Редактор реестра)
echo /cmd (Командная строка)
echo /powershell (PowerShell)
echo /services (Службы Windows)
echo /eventvwr (Просмотр событий — поиск следов атаки)
echo /ipconfig (Информация о сетевых настройках)
echo /ping [адрес] (Проверка связи с интернетом)
echo /netstat (Активные сетевые соединения — поиск подозрительных)
echo /systeminfo (Информация о системе)
echo /diskusage (Использование дисков — поиск аномалий)
echo /exit (Выход из программы)
echo.

set /p command=Введите команду:
if "!command!"=="" goto noncmd
:: Экранирование спецсимволов в вводе
set "command=!command:&=^&!"
set "command=!command:|=^|!"
set "command=!command:^=^^!"

if "!command!"=="/commands" goto commands
if "!command!"=="/shutdown" goto shutdown
if "!command!"=="/restart" goto restart
if "!command!"=="/enablemgr" goto enablemgr
if "!command!"=="/taskmgr" goto taskmgr
if "!command!"=="/logoff" goto logoff
if "!command!"=="/clean" goto clean
if "!command!"=="/msconfig" goto msconfig
if "!command!"=="/regedit" goto regedit
if "!command!"=="/cmd" goto cmd
if "!command!"=="/powershell" goto powershell
if "!command!"=="/services" goto services
if "!command!"=="/eventvwr" goto eventvwr
if "!command!"=="/ipconfig" goto ipconfig
if "!command!"=="/ping" goto ping
if "!command!"=="/netstat" goto netstat
if "!command!"=="/systeminfo" goto systeminfo
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

:logoff
echo Выход из учётной записи...
shutdown /l
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
start powershelll
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

:systeminfo
echo Вывод подробной информации о системе...
systeminfo
pause
goto commands

:diskusage
echo Использование дисков (ГБ):
echo.
for /f "tokens=1,2,3" %%a in ('wmic logicaldisk where "DriveType=3" get caption^,freespace^,size /format:table 2^>nul') do (
    if "%%b" neq "" (
        set /a free_gb=%%b/1073741824 2>nul
        set /a total_gb=%%c/1073741824 2>nul
        if !errorlevel! equ 0 (
            echo %%a: !free_gb! ГБ свободно из !total_gb! ГБ
        ) else (
            echo %%a: ошибка расчёта объёма
        )
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
