@echo off
setlocal

pushd %~dp0\..

set VSCODEUSERDATADIR=%TMP%\vscodeuserfolder-%RANDOM%-%TIME:~6,5%

:: Tests in the extension host
:: TODO port over an re-enable API tests
:: call .\scripts\code.bat %~dp0\..\extensions\vscode-api-tests\testWorkspace --extensionDevelopmentPath=%~dp0\..\extensions\vscode-api-tests --extensionTestsPath=%~dp0\..\extensions\vscode-api-tests\out --disableExtensions --user-data-dir=%VSCODEUSERDATADIR%
call .\scripts\code.bat %~dp0\..\extensions\vscode-colorize-tests\test --extensionDevelopmentPath=%~dp0\..\extensions\vscode-colorize-tests --extensionTestsPath=%~dp0\..\extensions\vscode-colorize-tests\out --disableExtensions --user-data-dir=%VSCODEUSERDATADIR%
call .\scripts\code.bat %~dp0\..\extensions\markdown-language-features\test-fixtures --extensionDevelopmentPath=%~dp0\..\extensions\markdown-language-features --extensionTestsPath=%~dp0\..\extensions\markdown-language-features\out\test --disableExtensions --user-data-dir=%VSCODEUSERDATADIR%
call .\scripts\code.bat %~dp0\..\extensions\azure\test-fixtures --extensionDevelopmentPath=%~dp0\..\extensions\azure --extensionTestsPath=%~dp0\..\extensions\azure\out\test --disableExtensions --user-data-dir=%VSCODEUSERDATADIR%
if %errorlevel% neq 0 exit /b %errorlevel%

call .\scripts\code.bat $%~dp0\..\extensions\emmet\test-fixtures --extensionDevelopmentPath=%~dp0\..\extensions\emmet --extensionTestsPath=%~dp0\..\extensions\emmet\out\test --disableExtensions --user-data-dir=%VSCODEUSERDATADIR% .
if %errorlevel% neq 0 exit /b %errorlevel%

:: Integration & performance tests in AMD
call .\scripts\test.bat --runGlob **\*.integrationTest.js %*

# Tests in commonJS (HTML, CSS, JSON language server tests...)
call .\scripts\node-electron.bat .\node_modules\mocha\bin\_mocha .\extensions\*\server\out\test\**\*.test.js
if %errorlevel% neq 0 exit /b %errorlevel%

rmdir /s /q %VSCODEUSERDATADIR%

popd

endlocal
