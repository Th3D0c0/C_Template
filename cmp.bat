@echo off
setlocal enabledelayedexpansion

if "%~1"=="compile" (
    echo Finding C files...
    
    set "SOURCES="
    
    rem 1. Loop recursively to find files
    for /r "src" %%F in (*.c) do (
        if exist "%%F" (
            rem Append the new file path with a space to our SOURCES string
            set "SOURCES=!SOURCES! "%%F""
        )
    )
    
    rem 2. Check if we actually found anything
    if not defined SOURCES (
        echo No C files found to compile.
        goto end
    )
    
    echo.
    echo Compiling all files at once...
    echo Running: gcc !SOURCES! -o myprogram.exe
    
    if not exist "bin\" (
        mkdir bin
    )

    rem 3. Pass the gathered paths directly to GCC
    gcc !SOURCES! -o "bin\myprogram.exe"
    
    if %errorlevel% equ 0 (
        echo Compilation Successful!
    ) else (
        echo Compilation Failed!
    )
)

if "%~1"=="run" (
    bin\myprogram.exe
)

:end