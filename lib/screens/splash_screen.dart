import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/constants.dart';
import '../controllers/auth_controller.dart';
import 'onboarding/onboarding_screen.dart';
import '../main.dart'; // To access AuthWrapper

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();

    // Check auth status after animation
    Future.delayed(const Duration(seconds: 3), () {
      final user = ref.read(authServiceProvider).currentUser;
      if (user != null) {
        // User is logged in, go to AuthWrapper (which handles role check)
        // But we can't navigate to a widget that is part of the tree in a weird way.
        // Actually, main.dart handles the stream. 
        // So if we are in Splash, we might just want to let the main stream decide.
        // But usually Splash is the "home" of MaterialApp until decided.
        // Let's make Splash navigate to Onboarding if no user, or just let Main handle it.
        
        // Better approach: Main.dart shows Splash while loading, then switches.
        // But here I'm making a dedicated screen.
        // Let's just navigate.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AuthWrapper()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.location_on,
                  size: 100,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Text(
                  'HyperLocal Pro',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
