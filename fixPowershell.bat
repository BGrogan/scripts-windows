@echo off
@REM cmd script that generates the copy-paste command to let powershell run scripts.

cls
echo Run this command to fix the powershell error that occurs after every restart. It has already been copied to your clipboard.
echo ----------------------------------------------------------
echo Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
echo ----------------------------------------------------------
echo Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass | clip