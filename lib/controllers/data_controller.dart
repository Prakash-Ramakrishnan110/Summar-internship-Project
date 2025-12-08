import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/firestore_service.dart';
import '../models/vendor_model.dart';
import '../models/booking_model.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) => FirestoreService());

final vendorsProvider = StreamProvider<List<VendorModel>>((ref) {
  return ref.watch(firestoreServiceProvider).getVendors();
});

final vendorsByCategoryProvider = StreamProvider.family<List<VendorModel>, String>((ref, category) {
  return ref.watch(firestoreServiceProvider).getVendorsByCategory(category);
});

final userBookingsProvider = StreamProvider.family<List<BookingModel>, String>((ref, userId) {
  return ref.watch(firestoreServiceProvider).getUserBookings(userId, isVendor: false);
});

final vendorBookingsProvider = StreamProvider.family<List<BookingModel>, String>((ref, vendorId) {
  return ref.watch(firestoreServiceProvider).getUserBookings(vendorId, isVendor: true);
});
