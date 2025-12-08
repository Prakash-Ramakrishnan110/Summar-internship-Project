# 🚀 Quick Firebase Setup Guide

## Option 1: Automatic Setup (Recommended)

### Step 1: Install FlutterFire CLI
```bash
dart pub global activate flutterfire_cli
```

### Step 2: Add to PATH
After installation, you need to add Dart's global bin to your PATH:
- Windows: `C:\Users\YourUsername\AppData\Local\Pub\Cache\bin`
- Close and reopen your terminal

### Step 3: Configure Firebase
```bash
flutterfire configure
```

This will:
1. Ask you to login to Google
2. Let you select or create a Firebase project
3. Automatically generate `firebase_options.dart`
4. Configure Android and iOS apps

---

## Option 2: Manual Setup

### Step 1: Create Firebase Project
1. Go to https://console.firebase.google.com/
2. Click "Add Project"
3. Name it "HyperLocal Pro"
4. Follow the wizard

### Step 2: Enable Authentication
1. In Firebase Console → Authentication
2. Click "Get Started"
3. Enable "Phone" sign-in method
4. Add test phone number: `+1 650-555-3434` with code `123456`

### Step 3: Enable Firestore
1. Go to Firestore Database
2. Click "Create Database"
3. Start in Test Mode
4. Choose your region

### Step 4: Add Android App
1. Click Android icon in Project Overview
2. Package name: `com.hyperlocalpro.hyperlocal_pro`
3. Download `google-services.json`
4. Place in `android/app/` folder

### Step 5: Update firebase_options.dart
Replace the template values in `lib/firebase_options.dart` with your actual values from Firebase Console.

---

## Option 3: Test Mode (No Firebase Required)

I've added a "Test Mode" button that lets you skip Firebase setup for now!

Just click "Skip (Test Mode)" on the login screen to:
- Bypass phone authentication
- Use dummy user data
- Test all features without Firebase

---

## 📍 Google Maps Setup

### Get API Key
1. Go to https://console.cloud.google.com/
2. Enable these APIs:
   - Maps SDK for Android
   - Maps SDK for iOS (if needed)
   - Places API
   - Geocoding API

3. Create API Key in Credentials

### Add to App
Update `android/app/src/main/AndroidManifest.xml` line 15:
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_ACTUAL_API_KEY_HERE"/>
```

Update `lib/utils/constants.dart` line 28:
```dart
static const String googleMapsApiKey = 'YOUR_ACTUAL_API_KEY_HERE';
```

---

## 💳 Razorpay Setup

### Get Test Keys
1. Sign up at https://dashboard.razorpay.com/
2. Go to Settings → API Keys
3. Copy Test Key ID

### Add to App
Update `lib/utils/constants.dart`:
```dart
static const String razorpayKey = 'rzp_test_YOUR_ACTUAL_KEY';
```

---

## 🧪 Testing

### Test Phone Numbers (Firebase)
- Phone: `+1 650-555-3434`
- OTP: `123456`

### Test Payment (Razorpay)
- Card: `4111 1111 1111 1111`
- CVV: `123`
- Expiry: Any future date

### Add Dummy Vendors
The app automatically populates dummy vendors on first run!
Or manually call from debug console:
```dart
DummyData.populateVendors()
```

---

## ✅ Quick Start (Test Mode)

1. Run the app: `flutter run -d chrome`
2. Click "Skip (Test Mode)" on login
3. Explore the app with dummy data!

---

## 🔧 Troubleshooting

**"flutterfire not found"**
- Add Dart global bin to PATH
- Restart terminal
- Or use manual setup

**"Firebase not initialized"**
- Use Test Mode for now
- Or complete Firebase setup above

**"Maps not showing"**
- Add Google Maps API key
- Enable billing in Google Cloud

---

**Need help?** Check README.md for detailed instructions!
