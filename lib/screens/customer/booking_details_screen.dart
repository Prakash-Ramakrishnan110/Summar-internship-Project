import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/booking_model.dart';
import '../../utils/constants.dart';
import '../../widgets/glass_container.dart';
import '../chat/chat_screen.dart';

class BookingDetailsScreen extends StatelessWidget {
  final BookingModel booking;
  final bool isVendor;

  const BookingDetailsScreen({
    Key? key,
    required this.booking,
    this.isVendor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy location for vendor tracking if not set
    final vendorLoc = LatLng(
      booking.liveLat ?? 37.422,
      booking.liveLng ?? -122.084,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    otherUserId: isVendor ? booking.customerId : booking.vendorId,
                    otherUserName: isVendor ? 'Customer' : 'Vendor', // Ideally fetch name
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: vendorLoc,
                    zoom: 14,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('vendor'),
                      position: vendorLoc,
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
                      infoWindow: const InfoWindow(title: 'Vendor Location'),
                    ),
                  },
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: GlassContainer(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Status',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _getStatusColor(booking.status),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                booking.status.toUpperCase(),
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.access_time, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text(
                              booking.dateTime.toString().split('.')[0],
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        if (booking.status == 'accepted' || booking.status == 'ongoing')
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: const Text(
                              'Vendor is on the way!',
                              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.blue;
      case 'ongoing':
        return Colors.purple;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
