import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

final userModelProvider = FutureProvider.family<UserModel?, String>((ref, uid) async {
  return ref.watch(authServiceProvider).getUserData(uid);
});

final currentUserProvider = StateProvider<UserModel?>((ref) => null);
