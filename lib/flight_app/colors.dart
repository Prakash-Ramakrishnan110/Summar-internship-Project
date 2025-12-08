import 'package:flutter/material.dart';

class FlightColors {
  static const Color primaryPurple = Color(0xFF6B5CE7);
  static const Color darkPurple = Color(0xFF1A1147);
  static const Color lightPurple = Color(0xFFE8E5FF);
  static const Color accentBlue = Color(0xFF5EC8F2);
  static const Color accentPink = Color(0xFFFF6B9D);
  static const Color accentOrange = Color(0xFFFF8A5B);
  static const Color greenButton = Color(0xFF7FE7A3);
  
  static const LinearGradient purpleGradient = LinearGradient(
    colors: [Color(0xFF7B6FE8), Color(0xFF5B52D8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFE8E5FF), Color(0xFFF5F4FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
