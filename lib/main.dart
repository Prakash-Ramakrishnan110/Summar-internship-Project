import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'controllers/auth_controller.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/role_selection_screen.dart';
import 'screens/customer/customer_main_screen.dart';
import 'screens/vendor/vendor_main_screen.dart';
import 'screens/splash_screen.dart';
import 'utils/dummy_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Initialize dummy data (only populates if empty)
    await DummyData.initializeApp();
  } catch (e) {
    print('Firebase initialization error (Test Mode): $e');
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We can just return SplashScreen here. 
    // The SplashScreen will handle navigation based on auth state.
    return MaterialApp(
      title: 'HyperLocal Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authServiceProvider).currentUser;
    final userModelAsync = ref.watch(userModelProvider(user?.uid ?? ''));

    return userModelAsync.when(
      data: (userModel) {
        if (userModel == null) {
          return const RoleSelectionScreen();
        }
        
        // Update current user provider
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(currentUserProvider.notifier).state = userModel;
        });

        if (userModel.role == 'vendor') {
          return const VendorMainScreen();
        } else {
          return const CustomerMainScreen();
        }
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }
}
