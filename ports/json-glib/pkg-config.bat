@echo off

set prefix=@CURRENT_INSTALLED_DIR@
set exec_prefix=%prefix%
set libdir=%exec_prefix%/lib
set includedir=%prefix%/include
set bindir=%prefix%/bin

if "%1"=="--version" (
    echo 2.9
    exit /b 0
)

:: call :check %1 %2 glib-2.0
call :check %1 %2 gobject-2.0
:: call :check %1 %2 gmodule-2.0
call :check %1 %2 gio-2.0
:: call :check %1 %2 cairo
:: call :check %1 %2 cairo-pdf
:: call :check %1 %2 cairo-ps
:: call :check %1 %2 cairo-svg
:: call :check %1 %2 libarchive
:: call :check %1 %2 freetype2
:: call :check %1 %2 libpng
:: call :check %1 %2 lcms2
:: call :check %1 %2 libjpeg
:: call :check %1 %2 libtiff-4
:: call :check %1 %2 tiffxx
:: call :check %1 %2 gtk+-3.0


:: pkg-config cairomm-1.0 --cflags --libs

exit /b 1

:check

if "%1"=="%3" (
    if "%2"=="--libs" (
        echo -L%prefix%/lib -l%3
	exit
    )
)

if "%2"=="%3" (
    if "%1"=="--modversion" (
        echo 999.0
	exit
    )
    if "%1"=="--cflags" (
        echo -I%prefix%/include
	exit
    )
)

exit /b
