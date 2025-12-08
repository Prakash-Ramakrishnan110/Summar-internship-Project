import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String id;
  final String customerId;
  final String vendorId;
  final DateTime dateTime;
  final String status; // pending, accepted, ongoing, completed, cancelled
  final double? liveLat;
  final double? liveLng;
  final double totalAmount;

  BookingModel({
    required this.id,
    required this.customerId,
    required this.vendorId,
    required this.dateTime,
    this.status = 'pending',
    this.liveLat,
    this.liveLng,
    required this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'vendorId': vendorId,
      'dateTime': Timestamp.fromDate(dateTime),
      'status': status,
      'liveLat': liveLat,
      'liveLng': liveLng,
      'totalAmount': totalAmount,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'] ?? '',
      customerId: map['customerId'] ?? '',
      vendorId: map['vendorId'] ?? '',
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      status: map['status'] ?? 'pending',
      liveLat: map['liveLat']?.toDouble(),
      liveLng: map['liveLng']?.toDouble(),
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
    );
  }
}
