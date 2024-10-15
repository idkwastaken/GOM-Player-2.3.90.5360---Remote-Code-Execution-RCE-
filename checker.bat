@echo off
setlocal

:: Vulnerability Check for GOM Player 2.3.90.5360 RCE
echo =====================================================
echo GOM Player 2.3.90.5360 - Remote Code Execution (RCE)
echo Vulnerability Checker
echo =====================================================

:: Checking GOM Player version
set "gomPath=C:\Program Files (x86)\GOM\GOMPlayer\GOM.exe"
if exist "%gomPath%" (
    echo [*] GOM Player found at %gomPath%
) else (
    echo [!] GOM Player not found on this system.
    exit /b
)

:: Extract version info using PowerShell
for /f "delims=" %%A in ('powershell -Command "(Get-Item '%gomPath%').VersionInfo.ProductVersion"') do set version=%%A
echo [*] GOM Player version detected: %version%

:: Check if vulnerable version is installed
set "vulnerableVersion=2.3.90.5360"
if "%version%"=="%vulnerableVersion%" (
    echo [!] Warning: GOM Player version %vulnerableVersion% is vulnerable to RCE!
    echo [*] Please update to a patched version.
) else (
    echo [*] GOM Player version is not vulnerable.
)

:: Optional: Check for insecure HTTP connections (related to IE component)
echo [*] Checking for insecure HTTP connections...
for /f "delims=" %%B in ('netsh winhttp show proxy') do set proxyCheck=%%B
if "%proxyCheck%"=="    Direct access (no proxy server)." (
    echo [*] No proxy detected. Insecure HTTP connections may occur.
) else (
    echo [*] Proxy detected: %proxyCheck%
)

echo [*] Check complete.
pause
endlocal