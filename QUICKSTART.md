# 🚀 Quick Start Guide - HyperLocal Pro

## Immediate Next Steps

### 1. Install FlutterFire CLI (Easiest Method)
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase automatically
flutterfire configure
```
This will automatically:
- Create a Firebase project (or use existing)
- Generate `firebase_options.dart` with your credentials
- Set up Android and iOS apps

### 2. Manual Firebase Setup (Alternative)
If you prefer manual setup:
1. Create Firebase project at https://console.firebase.google.com/
2. Download `google-services.json` → place in `android/app/`
3. Download `GoogleService-Info.plist` → place in `ios/Runner/`
4. Update `lib/firebase_options.dart` with your project details

### 3. Google Maps API Key
```bash
# Get your key from: https://console.cloud.google.com/
# Then update:
# - android/app/src/main/AndroidManifest.xml (line 15)
# - lib/utils/constants.dart (line 28)
```

### 4. Run the App
```bash
flutter pub get
flutter run
```

## 📋 Checklist

- [ ] Firebase configured (use `flutterfire configure`)
- [ ] Google Maps API key added
- [ ] Razorpay test key added (optional for testing)
- [ ] Run `flutter pub get`
- [ ] Run app on emulator/device

## 🎯 Test the App

### Login Flow
1. App opens with splash screen
2. Swipe through onboarding (3 screens)
3. Enter phone number (use Firebase test number: +1 650-555-3434)
4. Enter OTP (123456 for test numbers)
5. Select role (Customer or Vendor)
6. Complete profile

### Customer Flow
1. Browse categories on home screen
2. View nearby vendors
3. Tap vendor → See details
4. Book service → Select date/time
5. Pick location on map
6. Pay (use Razorpay test card: 4111 1111 1111 1111)

### Vendor Flow
1. Register as vendor
2. View dashboard with stats
3. See incoming bookings
4. Accept/Reject bookings
5. Toggle availability

## 🐛 Common Issues

**"Firebase not initialized"**
→ Run `flutterfire configure`

**"Maps not showing"**
→ Add Google Maps API key to AndroidManifest.xml

**"Build failed"**
→ Run `flutter clean && flutter pub get`

## 📱 What's Included

✅ Complete authentication system
✅ Customer & Vendor apps
✅ Real-time booking system
✅ Google Maps integration
✅ Payment integration (Razorpay)
✅ Chat functionality
✅ Beautiful UI with animations
✅ Dark mode support

## 🎨 Your App Logo

Your logo has been added to `assets/images/app_logo.jpg`
Update the splash screen and app icon to use it!

---

**Need help?** Check the full README.md for detailed instructions.
