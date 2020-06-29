@echo off
setlocal EnableDelayedExpansion

@rem -----script description-----
@rem files of a directory are added suffixes
@rem the number of files in directory must be 
@rem        less than or equal to lines in file
@rem first line in the names.txt file is appended to 
@rem         first file in the directory and so on



@rem names_arr stores each line of file
set "names_arr[0]=0"
set "iter=0"

@rem regarding more info about FOR type <HELP FOR> in cmd
@rem use ! around variables in case of DelayedExpansion 
@rem       else the updated values aren't used
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

@rem main block of script for renaming files
set "iter=0"
@rem the directory of files which are required to be renamed
@rem files are restricted to the given regular expression
@rem *.mp4 indicates only mp4 files are to be considered
set "FOLDER_PATH=E:\test\*.mp4"

for  %%f in ("!FOLDER_PATH!") do (

	set "origname=%%f"
	set "suff="

	@rem suff is supposed to contain names_arr[iter]
	@rem I couldn't figure how to make !names_arr[!iter!]! work
	@rem I know this isn't an efficient method and any suggestions are welcome
	@rem So go ahead and give a PR
	for /l %%n in (0,1,!iter!) do (
		set "suff=!names_arr[%%n]!"
	)

	@rem ~8 indicates substring starting at index 8
	@rem -4 indicates excluding last 4 characters
	@rem -4 is used so that the extension is not to be changed
	@rem Again I agree this is not a generic method to achieve this task
	@rem this is the string to which current file will be renamed
	set "filename=!origname:~8,-4!-!suff!.mp4"

	@rem for debugging uncomment below line
	@rem echo !filename!

	@rem rename param1 param2
	@rem param1 has to be full path and param2 has to be only the filename
	@rem when ren command is used param2 also has to be full path in filesystem
	rename "%%f" "!filename!"

	@rem rename using next line
	set /a "iter=iter+1"
)

endlocal
