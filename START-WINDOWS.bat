@echo off
title MEHEDY WhatsApp Automation
if not exist .env (
  echo .env is missing. Run SETUP-WINDOWS.bat first.
  pause
  exit /b 1
)
call npm start
pause
