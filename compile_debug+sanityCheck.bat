@echo off
:: Sugarcube Basic Compiler - Windows

:: Set working directory
pushd %~dp0

:: See if we can find a git installation
setlocal enabledelayedexpansion

for %%k in (HKCU HKLM) do (
    for %%w in (\ \Wow6432Node\) do (
        for /f "skip=2 delims=: tokens=1*" %%a in ('reg query "%%k\SOFTWARE%%wMicrosoft\Windows\CurrentVersion\Uninstall\Git_is1" /v InstallLocation 2^> nul') do (
            for /f "tokens=3" %%z in ("%%a") do (
                set GIT=%%z:%%b
				set GITFOUND=yes
                goto FOUND
            )
        )
    )
)
:FOUND
if %GITFOUND% == yes (
	set "PATH=%GIT%bin;%PATH%"
	bash --login -c ./sanityCheck
)

:: Compile the game
call "%~dp0compile.bat"

if %GITFOUND% == yes (
	:: Make the output prettier, replacing \t with a tab and \n with a newline
	bash -c "sed -i -e '/^.*<div id=\"store-area\".*$/s/\\\t/\t/g' -e '/^.*<div id=\"store-area\".*$/s/\\\n/\n/g' Degrees_of_Lewdity_mod.html"
)

popd
PAUSE
