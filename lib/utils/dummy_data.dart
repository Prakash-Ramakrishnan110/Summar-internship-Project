import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vendor_model.dart';

class DummyData {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> populateVendors() async {
    try {
      // Check if vendors already exist
      final snapshot = await _firestore.collection('vendors').limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        print('Vendors already exist, skipping population');
        return;
      }

      final vendors = [
        VendorModel(
          id: 'vendor1',
          name: 'John Smith',
          category: 'Electrician',
          price: 50.0,
          rating: 4.8,
          experience: 5,
          lat: 37.422,
          lng: -122.084,
          isAvailable: true,
          profileImage: 'https://i.pravatar.cc/150?img=12',
        ),
        VendorModel(
          id: 'vendor2',
          name: 'Sarah Johnson',
          category: 'Plumber',
          price: 45.0,
          rating: 4.9,
          experience: 7,
          lat: 37.425,
          lng: -122.087,
          isAvailable: true,
          profileImage: 'https://i.pravatar.cc/150?img=45',
        ),
        VendorModel(
          id: 'vendor3',
          name: 'Mike Davis',
          category: 'Painter',
          price: 40.0,
          rating: 4.7,
          experience: 4,
          lat: 37.420,
          lng: -122.082,
          isAvailable: true,
          profileImage: 'https://i.pravatar.cc/150?img=33',
        ),
        VendorModel(
          id: 'vendor4',
          name: 'Emily Brown',
          category: 'AC Repair',
          price: 60.0,
          rating: 4.9,
          experience: 8,
          lat: 37.428,
          lng: -122.089,
          isAvailable: true,
          profileImage: 'https://i.pravatar.cc/150?img=47',
        ),
        VendorModel(
          id: 'vendor5',
          name: 'David Wilson',
          category: 'Tutor',
          price: 35.0,
          rating: 4.6,
          experience: 3,
          lat: 37.419,
          lng: -122.081,
          isAvailable: true,
          profileImage: 'https://i.pravatar.cc/150?img=68',
        ),
        VendorModel(
          id: 'vendor6',
          name: 'Lisa Anderson',
          category: 'Electrician',
          price: 55.0,
          rating: 4.8,
          experience: 6,
          lat: 37.424,
          lng: -122.086,
          isAvailable: true,
          profileImage: 'https://i.pravatar.cc/150?img=20',
        ),
      ];

      for (var vendor in vendors) {
        await _firestore.collection('vendors').doc(vendor.id).set(vendor.toMap());
      }

      print('✅ Successfully populated ${vendors.length} vendors!');
    } catch (e) {
      print('❌ Error populating vendors: $e');
    }
  }

  // Call this on app start
  static Future<void> initializeApp() async {
    print('🚀 Initializing app with dummy data...');
    await populateVendors();
  }
}
