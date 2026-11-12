@echo off
title MEHEDY WhatsApp Automation - Setup
echo ==========================================
echo   MEHEDY WhatsApp Automation Setup
echo ==========================================
where node >nul 2>nul
if errorlevel 1 (
  echo Node.js was not found. Install Node.js 20 LTS or newer first.
  echo https://nodejs.org/
  pause
  exit /b 1
)
for /f "tokens=1 delims=v" %%v in ('node -v') do set NODE_VERSION=%%v
echo Node.js detected: 
node -v
if not exist .env (
  copy .env.example .env >nul
  echo Created .env from .env.example.
  echo IMPORTANT: Open .env and set OWNER_NUMBER, DASHBOARD_PASSWORD and TOKEN_SECRET.
) else (
  echo Existing .env found. Leaving it unchanged.
)
echo.
echo Installing packages...
call npm install
if errorlevel 1 (
  echo Package installation failed. Check internet and Node.js version.
  pause
  exit /b 1
)
echo.
echo Checking JavaScript syntax...
call npm run check
if errorlevel 1 (
  echo Syntax check failed. See the error above.
  pause
  exit /b 1
)
echo.
echo Setup completed. Edit .env, then run START-WINDOWS.bat
pause
