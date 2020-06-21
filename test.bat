@echo off
setlocal EnableDelayedExpansion
set "names_arr[0]=0"
set "iter=0"
for /f "tokens=*" %%a in (names.txt) do (
	set names_arr[!iter!]=%%a
	set /a "iter=iter+1"
)
set "len=0"
:lenfin
if defined names_arr[!len!] (
	set /a "len=len+1" 
	GOTO :lenfin
)
echo !len!
for /l %%n in (0,1,!len!-1) do (
	echo !names_arr[%%n]!
)