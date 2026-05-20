@echo off
title Base64 Encoder ^& Decoder
color 0A

:menu
cls
echo ===================================================
echo           BASE64 ENCODER ^& DECODER
echo ===================================================
echo [1] Encode (Ubah Teks menjadi Base64)
echo [2] Decode (Kembalikan Base64 menjadi Teks)
echo [3] Keluar
echo ===================================================
echo.
set /p "choice=Pilih menu (1/2/3): "

if "%choice%"=="1" goto encode
if "%choice%"=="2" goto decode
if "%choice%"=="3" exit
goto menu

:encode
echo.
set /p "myInput=Masukkan Teks untuk di-ENCODE: "
if "%myInput%"=="" goto encode
echo.
echo Memproses Encode...
:: Menggunakan PowerShell untuk ENCODE
for /f "delims=" %%i in ('powershell -command "[Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes('%myInput%'))"') do set result=%%i
goto show_result

:decode
echo.
set /p "myInput=Masukkan kode Base64 untuk di-DECODE: "
if "%myInput%"=="" goto decode
echo.
echo Memproses Decode...
:: Menggunakan PowerShell untuk DECODE
for /f "delims=" %%i in ('powershell -command "[System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('%myInput%'))"') do set result=%%i
goto show_result

:show_result
echo.
echo ===================================================
echo HASIL:
echo %result%
echo ===================================================
echo.

:: Memasukkan hasil ke Clipboard Windows
powershell -command "Set-Clipboard -Value '%result%'"

echo [SUCCESS] Hasil sudah otomatis disalin (Copy) ke Clipboard!
echo.
echo Tekan tombol apa saja untuk kembali ke menu utama...
pause >nul
goto menu