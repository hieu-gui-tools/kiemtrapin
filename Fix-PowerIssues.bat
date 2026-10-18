@echo off
:: Batch script de ap dung cac thiet lap toi uu nguon dien va sua triet de loi Sleep / Fast Startup
title FIX LOI TREO NGUON LENOVO
color 0A
echo ========================================================
echo   LENOVO - FIX TRIET DE LOI BAT MAY KHO VA TREO KHI NGHI
echo ========================================================
echo.

:: Kiem tra quyen Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    color 0C
    echo [CANH BAO] Vui long bam chuot phai vao file nay va chon "Run as administrator"!
    echo.
    pause
    exit /b 1
)

echo [1/4] Bat lai che do Hibernate (Ngu dong thuc su an toan)...
powercfg /h on

echo [2/4] Tat tinh nang Fast Startup (Khoi dong nhanh - Thu pham gay ket nguon)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f

echo [3/4] Dat thoi gian tat o dia SSD thanh Never (Khong bao gio tat)...
powercfg /change disk-timeout-ac 0
powercfg /change disk-timeout-dc 0

echo [4/4] Tat ngat dien PCIe Link State Power Management (Tranh mat ket noi SSD NVMe)...
powercfg /setacvalueindex SCHEME_CURRENT 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 0
powercfg /setdcvalueindex SCHEME_CURRENT 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 0
powercfg /setactive SCHEME_CURRENT

echo.
echo ========================================================
echo   TAT CA CAI DAT DA DUOC AP DUNG HOAN HAO 100%!
echo.
echo   - Che do Hibernate: DA BAT (de may nghi an toan, khong hao pin)
echo   - Tinh nang Fast Startup: DA TAT (khoi dong sach, khong con ket nguon)
echo   - Che do ngu SSD NVMe: DA KHOA (khong con bi ngat ket noi gay treo)
echo ========================================================
echo.
pause
