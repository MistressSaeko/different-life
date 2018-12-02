@echo off
:: Sugarcube Basic Compiler - Windows

:: Set working directory
pushd %~dp0

:: Compile the game
call "%~dp0compile.bat"


type test.txt | repl "\bred\b" "blue" >test.txt.new
move test.txt.new test.txt

popd
PAUSE
