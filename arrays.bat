@echo off
setlocal EnableDelayedExpansion

@rem -----script description----- 
@rem Author: Virinchi Varma
@rem if a file has 5 lines each of the lines is stored into names_arr 
@rem index 0 has first line and so on

set "names_arr[0]=0"
set "iter=0"

@rem regarding more info about FOR type HELP FOR in cmd
@rem use ! around variables in case of DelayedExpansion 
@rem       else the updated values aren't used
@rem note that names.txt has to be in the same directory
for /f "tokens=*" %%a in (names.txt) do (
	set names_arr[!iter!]=%%a
	set /a "iter=iter+1"
)

set "len=0"

@rem this label takes care of finding array length
:lenfin
if defined names_arr[!len!] (
	set /a "len=len+1" 
	GOTO :lenfin
)
echo !len!

@rem displaying contents of array
@rem first param indicates start index and last param indicates last index
@rem second param indicates the gap between indices
for /l %%n in (0,1,!len!-1) do (
	echo !names_arr[%%n]!
)

endlocal
