import 'package:flutter/material.dart';

class AppColors {
  // Primary Purple Colors
  static const Color primary = Color(0xFF6B5CE7);
  static const Color primaryDark = Color(0xFF5B52D8);
  static const Color darkPurple = Color(0xFF1A1147);
  static const Color lightPurple = Color(0xFFE8E5FF);
  
  // Accent Colors
  static const Color secondary = Color(0xFF5EC8F2); // Blue
  static const Color accentBlue = Color(0xFF5EC8F2);
  static const Color accentPink = Color(0xFFFF6B9D);
  static const Color accentOrange = Color(0xFFFF8A5B);
  static const Color greenButton = Color(0xFF7FE7A3);
  
  // Background Colors
  static const Color background = Color(0xFF1A1147);
  static const Color surface = Color(0xFFF5F4FF);
  static const Color error = Color(0xFFFF6B9D);
  static const Color onPrimary = Colors.white;
  static const Color onBackground = Colors.white;
  static const Color onSurface = Color(0xFF1A1147);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF7B6FE8), Color(0xFF5B52D8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFE8E5FF), Color(0xFFF5F4FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient glassGradient = LinearGradient(
    colors: [Colors.white10, Color(0x0DFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppConstants {
  static const String appName = 'HyperLocal Pro';
  static const String googleMapsApiKey = 'YOUR_API_KEY_HERE'; // User to replace
  static const String razorpayKey = 'rzp_test_1234567890'; // Test key
}
