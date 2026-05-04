@echo off
chcp 1251 >nul
setlocal enabledelayedexpansion
title Windows Control Panel

cls
echo ===========================
echo    WINDOWS CONTROL PANEL
echo ===========================
echo.
echo v0.1 non-public
echo.

echo You've launched the Windows backup management program. This is designed to bypass viruses that block access to built-in diagnostic and configuration programs.
echo ВНИМАНИЕ: Программу нужно запускать от имени администратора, иначе большинство комманд могут быть ограничены.
echo.

:commands
echo Команды:
echo /commands (Повторное отображание комманд)
echo /shutdown (Полное завершение работы компьютера)
echo /enablemgr (Разрешение открытия диспетчера задач)
echo /taskmgr (Открытие диспетчера задач)
echo /enableconfig (Разрешение открытия программы для конфигурации системы)
echo /msconfig (Открытие программы для конфигурации системы)
echo /sfc (Проверка целостности файлов)
echo /tasklist (Список работающих процессов)
echo /taskkill (Оборвание процесса)
echo /regedit (Открытие редактора реестра Windows)

set /p i="Введите комманду: "
if "%i%"=="/commands" (goto commands)
if "%i%"=="/shutdown" (goto shutdown)
if "%i%"=="/enablemgr" (goto enablemgr)
if "%i%"=="/taskmgr" (goto taskmgr)
if "%i%"=="/enableconfig" (goto enableconfig)
if "%i%"=="/msconfig" (goto msconfig)
if "%i%"=="/sfc" (goto sfc)
if "%i%"=="/tasklist" (goto tasklist)
if "%i%"=="/taskkill" (goto taskkill)
if "%i%"=="/regedit" (goto regedit)
goto noncmd


:next
echo Нажмите любую клавишу чтобы продолжить
echo -----------------------------------
pause
goto commands


:shutdown
shutdown /s /t 0
if errorlevel 0 (
    echo Выключаем ПК...
) else (
    echo ОШИБКА: Не удалось выполнить выключение ПК.
)
goto :eof

:enablemgr
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /f
if errorlevel 0 (
    echo Блокировка открытия диспетчера задач успешно удалена
) else (
    echo ОШИБКА: Не удалось снять блокировку с диспетчера задач, или блокировка уже была снята.
)
goto next
