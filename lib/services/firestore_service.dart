import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vendor_model.dart';
import '../models/booking_model.dart';
import '../models/chat_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Vendors
  Stream<List<VendorModel>> getVendors() {
    return _firestore.collection('vendors').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => VendorModel.fromMap(doc.data())).toList();
    });
  }

  Stream<List<VendorModel>> getVendorsByCategory(String category) {
    return _firestore
        .collection('vendors')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => VendorModel.fromMap(doc.data())).toList();
    });
  }

  Future<void> createVendorProfile(VendorModel vendor) async {
    await _firestore.collection('vendors').doc(vendor.id).set(vendor.toMap());
  }

  // Bookings
  Future<void> createBooking(BookingModel booking) async {
    await _firestore.collection('bookings').doc(booking.id).set(booking.toMap());
  }

  Stream<List<BookingModel>> getUserBookings(String userId, {bool isVendor = false}) {
    if (userId == 'test_user_id') {
      return Stream.value([
        BookingModel(
          id: 'dummy_booking_1',
          customerId: 'test_user_id',
          vendorId: 'vendor_1',
          dateTime: DateTime.now().add(const Duration(days: 1)),
          status: 'pending',
          totalAmount: 50.0,
          liveLat: 37.422,
          liveLng: -122.084,
        ),
        BookingModel(
          id: 'dummy_booking_2',
          customerId: 'test_user_id',
          vendorId: 'vendor_2',
          dateTime: DateTime.now().subtract(const Duration(days: 2)),
          status: 'completed',
          totalAmount: 120.0,
          liveLat: 37.422,
          liveLng: -122.084,
        ),
      ]);
    }

    String field = isVendor ? 'vendorId' : 'customerId';
    return _firestore
        .collection('bookings')
        .where(field, isEqualTo: userId)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => BookingModel.fromMap(doc.data())).toList();
    });
  }

  Future<void> updateBookingStatus(String bookingId, String status) async {
    await _firestore.collection('bookings').doc(bookingId).update({'status': status});
  }

  // Chats
  Stream<List<ChatModel>> getChats(String userId, String otherId) {
    if (userId == 'test_user_id') {
      return Stream.value([
        ChatModel(
          chatId: '1',
          senderId: otherId,
          receiverId: userId,
          message: 'Hello! How can I help you?',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
        ChatModel(
          chatId: '2',
          senderId: userId,
          receiverId: otherId,
          message: 'I have a question about my booking.',
          timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
        ),
      ]);
    }

    List<String> ids = [userId, otherId];
    ids.sort();
    String chatId = ids.join('_');
    
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ChatModel.fromMap(doc.data())).toList();
    });
  }

  Future<void> sendMessage(ChatModel chat) async {
    if (chat.senderId == 'test_user_id') {
      // Simulate sending
      await Future.delayed(const Duration(milliseconds: 500));
      return;
    }

    List<String> ids = [chat.senderId, chat.receiverId];
    ids.sort();
    String chatId = ids.join('_');

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(chat.toMap());
  }
}
