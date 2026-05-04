@echo off

setlocal enabledelayedexpansion
chcp 1251 >nul
title Панель управления Windows

cls
echo ===============================
echo    ПАНЕЛЬ УПРАВЛЕНИЯ WINDOWS
echo ===============================
echo.
echo v0.1 non-public
echo.

echo Вы запустили программу для резервного управления Windows. Сделано как спасение от вирусов, которые заблокировали доступ к встроенным программам.
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
if
if
if
if
goto noncmd
