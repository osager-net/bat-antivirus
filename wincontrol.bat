@echo off
setlocal enabledelayedexpansion
chcp 1251 >nul

echo =================================
echo     ПАНЕЛЬ УПРАВЛЕНИЯ WINDOWS
echo =================================
echo v0.1 non-public
echo Вы запустили программу для резервного управления Windows. Сделано как спасение от вирусов, которые заблокировали доступ к встроенным программам.

:commands
echo Команды:
echo /commands (Повторное отображение комманд и поля ввода) (Обычная команда) (Обычная команда)
echo /shutdown (Полное завершение работы компьютера) (Может быть опасно при добавлении вируса в автозапуск реестра) (Завершательная команда)
echo /enablemgr (Разрешение открытия диспетчера задач) (Обычная команда) (Обычная команда)
echo /taskmgr (Открытие диспетчера задач) (Обычная команда) (Обычная команда)
echo /exit (Закрытие программы управления) (Может быть опасно при активности вируса) (Завершательная команда)

set /p command=Введите команду: 
if "!command!"=="/commands" goto commands
if "!command!"=="/shutdown" goto shutdown
if "!command!"=="/enablemgr" goto enablemgr
if "!command!"=="/taskmgr" goto taskmgr
if "!command!"=="/exit" goto exit
goto noncmd

:shutdown
echo Стартует выключение...
shutdown /s /t 0
goto :eof

:enablemgr
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /f
if !errorlevel! equ 0 (
    echo Диспетчер задач успешно разблокирован.
) else (
    echo Ошибка: диспетчер задач уже разблокирован или произошла ошибка
)
echo Нажмите любую клавишу для продолжения
echo -----------------------------------
pause
cls
goto commands

:taskmgr
start taskmgr.exe
echo Диспетчер задач открыт. Если он не появился, возможно вирус заблокировал его
echo Нажмите любую клавишу для продолжения
echo -----------------------------------
pause
cls
goto commands

:exit
echo Закрываем программу.
exit

:noncmd
echo Команда не существует, либо допущена опечатка. Попробуйте ещё раз.
echo Нажмите любую клавишу для продолжения
echo -----------------------------------
pause
cls
goto commands
