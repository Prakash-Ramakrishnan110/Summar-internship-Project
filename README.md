# HyperLocal Pro - Setup Guide

## 🚀 Complete Setup Instructions

### 1. Firebase Setup

#### Step 1: Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add Project"
3. Enter project name: `HyperLocal Pro`
4. Follow the setup wizard

#### Step 2: Enable Authentication
1. In Firebase Console, go to **Authentication**
2. Click "Get Started"
3. Enable **Phone** sign-in method
4. Configure your test phone numbers if needed

#### Step 3: Enable Firestore
1. Go to **Firestore Database**
2. Click "Create Database"
3. Start in **Test Mode** (for development)
4. Choose your region

#### Step 4: Add Android App
1. Click the Android icon in Project Overview
2. Package name: `com.hyperlocalpro.hyperlocal_pro`
3. Download `google-services.json`
4. Place it in `android/app/` directory

#### Step 5: Add iOS App (Optional)
1. Click the iOS icon in Project Overview
2. Bundle ID: `com.hyperlocalpro.hyperlocalPro`
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/` directory

---

### 2. Google Maps Setup

#### Step 1: Get API Key
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing
3. Enable these APIs:
   - Maps SDK for Android
   - Maps SDK for iOS
   - Places API
   - Geocoding API

#### Step 2: Create API Key
1. Go to **Credentials**
2. Click "Create Credentials" → "API Key"
3. Copy your API key

#### Step 3: Add to Android
1. Open `android/app/src/main/AndroidManifest.xml`
2. Replace `YOUR_GOOGLE_MAPS_API_KEY_HERE` with your actual key

#### Step 4: Add to iOS
1. Open `ios/Runner/AppDelegate.swift`
2. Add this import: `import GoogleMaps`
3. In `application` method, add:
   ```swift
   GMSServices.provideAPIKey("YOUR_API_KEY_HERE")
   ```

---

### 3. Razorpay Setup

#### Step 1: Create Account
1. Go to [Razorpay Dashboard](https://dashboard.razorpay.com/)
2. Sign up for an account
3. Complete KYC (for production)

#### Step 2: Get Test Keys
1. Go to **Settings** → **API Keys**
2. Copy your **Test Key ID**
3. Open `lib/utils/constants.dart`
4. Replace `rzp_test_1234567890` with your actual test key

---

### 4. Running the App

#### Install Dependencies
```bash
flutter pub get
```

#### Run on Android
```bash
flutter run
```

#### Run on iOS
```bash
cd ios
pod install
cd ..
flutter run
```

---

### 5. Populate Dummy Data

To add sample vendors for testing:

1. Open `lib/utils/dummy_data.dart`
2. In your app, call `DummyData.populateVendors()` once
3. You can add a temporary button in the login screen or run it from debug console

---

### 6. Project Structure

```
lib/
├── models/              # Data models
│   ├── user_model.dart
│   ├── vendor_model.dart
│   ├── booking_model.dart
│   └── chat_model.dart
├── services/            # Firebase & Location services
│   ├── auth_service.dart
│   ├── firestore_service.dart
│   └── location_service.dart
├── controllers/         # Riverpod providers
│   ├── auth_controller.dart
│   └── data_controller.dart
├── screens/             # UI screens
│   ├── auth/
│   ├── customer/
│   ├── vendor/
│   ├── chat/
│   ├── profile/
│   └── onboarding/
├── widgets/             # Reusable components
│   ├── custom_button.dart
│   └── glass_container.dart
├── theme/               # App theming
│   └── app_theme.dart
├── utils/               # Constants & helpers
│   ├── constants.dart
│   └── dummy_data.dart
└── main.dart            # Entry point
```

---

### 7. Features Implemented

✅ **Authentication**
- Firebase Phone OTP Login
- Role-based access (Customer/Vendor)
- Profile setup

✅ **Customer App**
- Modern home screen with categories
- Search functionality
- Nearby vendors (GPS-based)
- Service details with reviews
- Booking flow with date/time picker
- Google Maps location picker
- Razorpay payment integration
- Real-time booking tracking
- Chat with vendors
- Booking history

✅ **Vendor App**
- Vendor registration
- Animated dashboard
- Earnings & stats display
- Accept/Reject bookings
- Availability toggle
- Chat with customers
- Booking management

✅ **UI/UX**
- Glassmorphism design
- Smooth animations
- Gradient backgrounds
- Bottom navigation
- Dark mode support
- Responsive design

---

### 8. Testing

#### Test Phone Authentication
Use Firebase test phone numbers:
- Phone: +1 650-555-3434
- OTP: 123456

#### Test Payment
Razorpay test cards:
- Card: 4111 1111 1111 1111
- CVV: Any 3 digits
- Expiry: Any future date

---

### 9. Troubleshooting

**Issue: Firebase not initialized**
- Ensure `google-services.json` is in `android/app/`
- Run `flutter clean` and `flutter pub get`

**Issue: Maps not showing**
- Verify API key is correct
- Check if Maps SDK is enabled
- Ensure billing is enabled in Google Cloud

**Issue: Build errors**
- Update Flutter: `flutter upgrade`
- Clean project: `flutter clean`
- Get dependencies: `flutter pub get`

---

### 10. Production Deployment

Before releasing to production:

1. **Firebase**: Switch from Test Mode to Production rules
2. **Razorpay**: Use Production keys instead of Test keys
3. **Google Maps**: Restrict API key to your app
4. **App Icons**: Replace default launcher icons
5. **Signing**: Configure Android signing and iOS certificates

---

## 📱 Screenshots & Demo

The app includes:
- Splash screen with animation
- Onboarding flow (3 screens)
- Phone authentication
- Role selection
- Customer home with categories
- Vendor dashboard
- Booking flow
- Real-time chat
- Profile management

---

## 🎨 Customization

### Change Primary Color
Edit `lib/utils/constants.dart`:
```dart
static const Color primary = Color(0xFF6C63FF); // Your color
```

### Add New Service Category
1. Update category tiles in `customer/home_screen.dart`
2. Add category icon
3. Update Firestore queries if needed

---

## 📞 Support

For issues or questions:
- Check the troubleshooting section
- Review Firebase and Flutter documentation
- Ensure all API keys are correctly configured

---

**Built with Flutter 💙**
