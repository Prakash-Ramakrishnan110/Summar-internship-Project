# 🎯 HyperLocal Pro - Developer Guide

## 📚 Complete File Reference

### Core Files

#### `lib/main.dart`
- App entry point
- Firebase initialization
- Riverpod setup
- Auth state management
- Navigation logic

#### `lib/firebase_options.dart`
- Firebase configuration
- Platform-specific settings
- **ACTION REQUIRED**: Run `flutterfire configure` to generate

---

## 🗂️ Directory Guide

### Models (`lib/models/`)
Data structures for the app:

| File | Purpose | Key Fields |
|------|---------|------------|
| `user_model.dart` | User data | id, name, phone, role, profileImage |
| `vendor_model.dart` | Vendor profiles | category, price, rating, lat/lng, experience |
| `booking_model.dart` | Booking info | customerId, vendorId, dateTime, status, amount |
| `chat_model.dart` | Chat messages | senderId, receiverId, message, timestamp |

### Services (`lib/services/`)
Business logic layer:

| File | Purpose | Key Methods |
|------|---------|-------------|
| `auth_service.dart` | Authentication | verifyPhoneNumber(), signIn(), signOut() |
| `firestore_service.dart` | Database ops | getVendors(), createBooking(), sendMessage() |
| `location_service.dart` | GPS functions | getCurrentLocation(), calculateDistance() |

### Controllers (`lib/controllers/`)
Riverpod state management:

| File | Providers | Usage |
|------|-----------|-------|
| `auth_controller.dart` | authStateProvider, currentUserProvider | Watch auth state |
| `data_controller.dart` | vendorsProvider, bookingsProvider | Stream data |

### Screens (`lib/screens/`)

#### Auth Flow
```
splash_screen.dart → onboarding_screen.dart → login_screen.dart → role_selection_screen.dart
```

#### Customer Flow
```
customer_main_screen.dart (Bottom Nav)
├── home_screen.dart (Tab 1)
│   └── service_details_screen.dart
│       └── booking_screen.dart
│           └── booking_details_screen.dart
├── my_bookings_screen.dart (Tab 2)
└── profile_screen.dart (Tab 3)
```

#### Vendor Flow
```
vendor_registration_screen.dart → vendor_main_screen.dart (Bottom Nav)
├── vendor_dashboard_screen.dart (Tab 1)
└── profile_screen.dart (Tab 2)
```

#### Shared
```
chat/chat_screen.dart (Accessible from booking details)
```

### Widgets (`lib/widgets/`)
Reusable components:

| Widget | Description | Props |
|--------|-------------|-------|
| `custom_button.dart` | Gradient button | text, onPressed, isLoading, color |
| `glass_container.dart` | Glassmorphism effect | child, blur, opacity, borderRadius |

### Theme (`lib/theme/`)
- `app_theme.dart`: Light & dark themes, Google Fonts integration

### Utils (`lib/utils/`)
- `constants.dart`: Colors, gradients, API keys
- `dummy_data.dart`: Test data generator

---

## 🎨 Customization Guide

### Change Primary Color
```dart
// lib/utils/constants.dart
static const Color primary = Color(0xFFYOURCOLOR);
```

### Add New Category
```dart
// lib/screens/customer/home_screen.dart
_buildCategoryTile('Your Category', Icons.your_icon),
```

### Modify Onboarding
```dart
// lib/screens/onboarding/onboarding_screen.dart
final List<Map<String, String>> _pages = [
  // Add/edit pages here
];
```

---

## 🔌 API Integration Points

### Firebase
**Files to configure:**
- `firebase_options.dart` (auto-generated)
- `android/app/google-services.json` (download from Firebase)
- `ios/Runner/GoogleService-Info.plist` (download from Firebase)

### Google Maps
**Files to update:**
```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_KEY_HERE"/>
```

```dart
// lib/utils/constants.dart
static const String googleMapsApiKey = 'YOUR_KEY_HERE';
```

### Razorpay
```dart
// lib/utils/constants.dart
static const String razorpayKey = 'rzp_test_YOUR_KEY';
```

---

## 🧪 Testing Guide

### Test Phone Authentication
```dart
// Use Firebase test numbers
Phone: +1 650-555-3434
OTP: 123456
```

### Test Payment
```dart
// Razorpay test card
Card: 4111 1111 1111 1111
CVV: 123
Expiry: 12/25
```

### Populate Test Data
```dart
// Call once from anywhere in the app
import 'package:hyperlocal_pro/utils/dummy_data.dart';
DummyData.populateVendors();
```

---

## 🐛 Debugging Tips

### Firebase Issues
```bash
# Check Firebase setup
flutterfire configure

# Verify google-services.json exists
ls android/app/google-services.json
```

### Build Issues
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

### Maps Not Showing
1. Verify API key in AndroidManifest.xml
2. Enable Maps SDK in Google Cloud Console
3. Check billing is enabled

---

## 📱 Screen Flow Diagram

```
App Start
    ↓
Splash Screen (2s animation)
    ↓
First Time? → Yes → Onboarding (3 screens) → Login
           → No  → Login (if not authenticated)
                → Home (if authenticated)
    ↓
Login (Phone OTP)
    ↓
Role Selection (Customer/Vendor)
    ↓
Customer Path              Vendor Path
    ↓                          ↓
Profile Setup          Vendor Registration
    ↓                          ↓
Customer Main          Vendor Main
(3 tabs)               (2 tabs)
```

---

## 🔐 Security Checklist

Before production:
- [ ] Update Firestore security rules
- [ ] Restrict Google Maps API key
- [ ] Use production Razorpay keys
- [ ] Enable app signing (Android)
- [ ] Configure certificates (iOS)
- [ ] Add ProGuard rules
- [ ] Enable crash reporting
- [ ] Add analytics

---

## 📦 Build Commands

### Development
```bash
flutter run
```

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

---

## 🚀 Deployment

### Google Play Store
1. Build app bundle: `flutter build appbundle`
2. Sign with keystore
3. Upload to Play Console
4. Complete store listing
5. Submit for review

### Apple App Store
1. Build iOS: `flutter build ios`
2. Open Xcode
3. Archive and upload
4. Complete App Store Connect
5. Submit for review

---

## 📊 Performance Tips

1. **Images**: Use `cached_network_image` for vendor photos
2. **Lists**: Implement pagination for large datasets
3. **Maps**: Load markers on demand
4. **Animations**: Use `AnimatedBuilder` for complex animations
5. **State**: Use `select` in Riverpod to minimize rebuilds

---

## 🎓 Learning Resources

- [Flutter Docs](https://flutter.dev/docs)
- [Riverpod Docs](https://riverpod.dev)
- [Firebase Flutter](https://firebase.flutter.dev)
- [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter)

---

## 💡 Feature Ideas for Future

- [ ] Push notifications
- [ ] In-app reviews
- [ ] Vendor verification badge
- [ ] Loyalty points system
- [ ] Referral program
- [ ] Multi-language support
- [ ] Voice/video calls
- [ ] Service packages
- [ ] Subscription plans
- [ ] Analytics dashboard

---

**Happy Coding! 🚀**
