@echo off
setlocal enabledelayedexpansion
chcp 1251 >nul
cls

echo =================================
echo     ПАНЕЛЬ УПРАВЛЕНИЯ WINDOWS
echo =================================
echo v0.1 non-public
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
echo.

set /p command=Введите команду:
if "!command!"=="/commands" goto commands
if "!command!"=="/shutdown" goto shutdown
if "!command!"=="/restart" goto restart
if "!command!"=="/enablemgr" goto enablemgr
if "!command!"=="/taskmgr" goto taskmgr
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

:exit
echo Закрываем программу.
pause
exit

:noncmd
echo Команда "!command!" не существует или допущена опечатка. Попробуйте ещё раз.
echo -----------------------------------
pause
goto commands
