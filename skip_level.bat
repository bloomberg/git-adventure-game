@echo off
::
:: Copyright 2018 Bloomberg Finance L.P.
::
:: Licensed under the Apache License, Version 2.0 (the "License");
:: you may not use this file except in compliance with the License.
:: You may obtain a copy of the License at
::
::     http://www.apache.org/licenses/LICENSE-2.0
::
:: Unless required by applicable law or agreed to in writing, software
:: distributed under the License is distributed on an "AS IS" BASIS,
:: WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
:: See the License for the specific language governing permissions and
:: limitations under the License.
::

:: Look for bash relative to git.exe
for /f "delims=" %%i in ('where git') do set GIT="%%i"
for %%F in (%GIT%) do set GIT_CMD=%%~dpF

cls && type .\.game_data\skip_level.txt
set /p answer="Are you sure? [y/N]: "

if /I "%answer%" == "y" (
    "%GIT_CMD%\..\bin\bash.exe" ".game_scripts/unlock_next_level.sh" "skiplevel"
    exit /b
)

echo.
echo That's the spirit!  Good luck at having another go!
echo.

