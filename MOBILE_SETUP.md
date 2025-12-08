# 📱 Running HyperLocal Pro on Mobile

## Option 1: Physical Android Device (USB Debugging)

### Step 1: Enable Developer Mode on Your Phone
1. Go to **Settings** → **About Phone**
2. Tap **Build Number** 7 times
3. You'll see "You are now a developer!"

### Step 2: Enable USB Debugging
1. Go to **Settings** → **Developer Options**
2. Turn ON **USB Debugging**
3. Turn ON **Install via USB** (if available)

### Step 3: Connect Your Phone
1. Connect phone to computer via USB cable
2. On phone, tap **Allow USB Debugging** when prompted
3. Select **File Transfer** mode (not just charging)

### Step 4: Verify Connection
```bash
flutter devices
```
You should see your device listed!

### Step 5: Run the App
```bash
flutter run
```
Flutter will automatically detect your phone and install the app!

---

## Option 2: Android Emulator (Virtual Device)

### Step 1: Open Android Studio
1. Open Android Studio
2. Click **More Actions** → **Virtual Device Manager**
3. Click **Create Device**

### Step 2: Create Emulator
1. Select a phone (e.g., Pixel 6)
2. Click **Next**
3. Download a system image (e.g., Android 13)
4. Click **Next** → **Finish**

### Step 3: Start Emulator
1. Click the ▶️ (Play) button next to your virtual device
2. Wait for emulator to boot up

### Step 4: Run the App
```bash
flutter devices
```
You should see the emulator listed!

```bash
flutter run
```

---

## Option 3: Wireless Debugging (Android 11+)

### Step 1: Enable Wireless Debugging
1. Go to **Settings** → **Developer Options**
2. Turn ON **Wireless Debugging**
3. Tap **Wireless Debugging** to see IP and Port

### Step 2: Connect via ADB
```bash
adb pair <IP>:<PAIRING_PORT>
# Enter pairing code shown on phone

adb connect <IP>:<PORT>
```

### Step 3: Run the App
```bash
flutter run
```

---

## 🚀 Quick Commands

### Check Connected Devices
```bash
flutter devices
```

### Run on Specific Device
```bash
flutter run -d <device-id>
```

### Run in Release Mode (Faster)
```bash
flutter run --release
```

### Build APK for Installation
```bash
flutter build apk --release
```
APK will be in: `build/app/outputs/flutter-apk/app-release.apk`

---

## 📱 What You'll See on Mobile

Once running, you'll experience:
- ✨ Beautiful purple gradient UI
- 📱 Smooth animations
- 🎨 Touch-friendly buttons
- 📍 GPS location (if enabled)
- 📸 Camera for profile pics
- 💬 Real-time chat
- 🗺️ Google Maps integration

---

## 🐛 Troubleshooting

**"Device not found"**
- Check USB cable is data cable (not just charging)
- Try different USB port
- Restart ADB: `adb kill-server` then `adb start-server`

**"Unauthorized device"**
- Disconnect and reconnect phone
- Tap "Allow" on USB debugging prompt
- Check "Always allow from this computer"

**"App won't install"**
- Enable "Install via USB" in Developer Options
- Disable "Verify apps over USB" temporarily
- Check phone storage has space

**"Gradle build failed"**
- Make sure Android SDK is installed
- Update Android Studio
- Run: `flutter doctor` to check setup

---

## 🎯 Recommended Setup

**For Best Experience:**
1. Use physical device (better performance)
2. Enable Developer Mode
3. Connect via USB first time
4. Then use wireless debugging

**For Testing:**
1. Use Android Emulator
2. Pixel 6 or similar
3. Android 12 or higher

---

## 📦 Building for Distribution

### Debug APK (for testing)
```bash
flutter build apk --debug
```

### Release APK (for sharing)
```bash
flutter build apk --release
```

### App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

---

**Ready to run on mobile! 🚀**

Connect your device and run `flutter run`!
