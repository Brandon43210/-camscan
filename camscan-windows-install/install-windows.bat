@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"
echo camscan installer
echo ==================
echo Running from: %cd%
echo.

where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Python was not found on your PATH.
    echo Install it from https://python.org/downloads and re-run this script.
    echo IMPORTANT: check "Add python.exe to PATH" during install.
    pause
    exit /b 1
)

python --version

set WHEEL_FILE=
for %%f in (camscan-*.whl) do set WHEEL_FILE=%%f

if not "%WHEEL_FILE%"=="" (
    echo Installing !WHEEL_FILE! ...
    python -m pip install --upgrade "!WHEEL_FILE!"
    goto :afterinstall
)

if exist pyproject.toml (
    echo No prebuilt .whl found, but pyproject.toml is here - installing from source...
    python -m pip install --upgrade .
    goto :afterinstall
)

echo Could not find a camscan-*.whl file or a pyproject.toml in this folder.
echo Files actually present here:
dir /b
echo.
echo %cd% | findstr /i "\\Temp\\" >nul
if !errorlevel! equ 0 (
    echo It looks like you ran this file directly from inside the zip
    echo ^(Windows copies just this one file to a temp folder in that case^).
    echo.
    echo Fix: right-click the zip -^> "Extract All..." -^> pick a folder -^>
    echo Extract, then run install-windows.bat from that extracted folder.
) else (
    echo Make sure you extracted the full zip ^(not just this one file^)
    echo into this folder, then try again.
)
pause
exit /b 1

:afterinstall
if %errorlevel% neq 0 (
    echo.
    echo Install failed. See the error above.
    pause
    exit /b 1
)

echo.
where ffmpeg >nul 2>nul
if %errorlevel% neq 0 (
    echo NOTE: ffmpeg was not found on your PATH.
    echo Scanning will work, but stream testing ^(--probe^) needs it.
    echo Get it from https://www.gyan.dev/ffmpeg/builds/ ^(pick a "release full" build^),
    echo unzip it, and add its "bin" folder to your PATH.
) else (
    echo ffmpeg found - stream testing will work.
)

echo.
echo Done. Try:  camscan scan 192.168.1.0/24
pause
