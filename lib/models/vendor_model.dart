class VendorModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final double lat;
  final double lng;
  final bool isAvailable;
  final int experience; // Years of experience
  final String? idProofUrl;
  final String? profileImage;

  VendorModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.rating = 0.0,
    required this.lat,
    required this.lng,
    this.isAvailable = true,
    required this.experience,
    this.idProofUrl,
    this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'rating': rating,
      'lat': lat,
      'lng': lng,
      'isAvailable': isAvailable,
      'experience': experience,
      'idProofUrl': idProofUrl,
      'profileImage': profileImage,
    };
  }

  factory VendorModel.fromMap(Map<String, dynamic> map) {
    return VendorModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      rating: (map['rating'] ?? 0).toDouble(),
      lat: (map['lat'] ?? 0).toDouble(),
      lng: (map['lng'] ?? 0).toDouble(),
      isAvailable: map['isAvailable'] ?? true,
      experience: map['experience'] ?? 0,
      idProofUrl: map['idProofUrl'],
      profileImage: map['profileImage'],
    );
  }
}
