@echo off
echo ========================================
echo   HyperLocal Pro - Mobile Build Tool
echo ========================================
echo.

:menu
echo Choose an option:
echo.
echo 1. Check connected devices
echo 2. Run on connected device
echo 3. Run on Android emulator
echo 4. Build debug APK
echo 5. Build release APK
echo 6. Install APK on device
echo 7. Exit
echo.
set /p choice="Enter your choice (1-7): "

if "%choice%"=="1" goto check_devices
if "%choice%"=="2" goto run_device
if "%choice%"=="3" goto run_emulator
if "%choice%"=="4" goto build_debug
if "%choice%"=="5" goto build_release
if "%choice%"=="6" goto install_apk
if "%choice%"=="7" goto end

echo Invalid choice. Please try again.
echo.
goto menu

:check_devices
echo.
echo Checking connected devices...
flutter devices
echo.
pause
goto menu

:run_device
echo.
echo Running app on connected device...
flutter run
pause
goto menu

:run_emulator
echo.
echo Starting emulator and running app...
flutter emulators --launch Pixel_6_API_33
timeout /t 30
flutter run
pause
goto menu

:build_debug
echo.
echo Building debug APK...
flutter build apk --debug
echo.
echo APK built at: build\app\outputs\flutter-apk\app-debug.apk
echo.
pause
goto menu

:build_release
echo.
echo Building release APK...
flutter build apk --release
echo.
echo APK built at: build\app\outputs\flutter-apk\app-release.apk
echo.
pause
goto menu

:install_apk
echo.
echo Installing latest APK on device...
adb install -r build\app\outputs\flutter-apk\app-release.apk
echo.
pause
goto menu

:end
echo.
echo Goodbye!
exit
