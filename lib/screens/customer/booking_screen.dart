import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../models/vendor_model.dart';
import '../../models/booking_model.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/data_controller.dart';
import '../../widgets/custom_button.dart';
import '../../utils/constants.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final VendorModel vendor;

  const BookingScreen({Key? key, required this.vendor}) : super(key: key);

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  late Razorpay _razorpay;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  LatLng _selectedLocation = const LatLng(37.42796133580664, -122.085749655962); // Default
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Payment successful, create booking
    _createBooking();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Failed: ${response.message}')),
    );
    setState(() => _isLoading = false);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
  }

  void _initiatePayment() {
    final user = ref.read(currentUserProvider);
    if (user?.id == 'test_user_id') {
      // Test Mode: Skip Payment
      _createBooking();
      return;
    }

    setState(() => _isLoading = true);
    var options = {
      'key': AppConstants.razorpayKey,
      'amount': (widget.vendor.price * 100).toInt(), // in paise
      'name': 'HyperLocal Pro',
      'description': 'Booking for ${widget.vendor.name}',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
      setState(() => _isLoading = false);
    }
  }

  void _createBooking() async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    final booking = BookingModel(
      id: const Uuid().v4(),
      customerId: user.id,
      vendorId: widget.vendor.id,
      dateTime: DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      ),
      status: 'pending',
      totalAmount: widget.vendor.price,
      liveLat: _selectedLocation.latitude,
      liveLng: _selectedLocation.longitude,
    );

    if (user.id != 'test_user_id') {
      await ref.read(firestoreServiceProvider).createBooking(booking);
    } else {
      // Simulate delay for test mode
      await Future.delayed(const Duration(seconds: 1));
    }
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking Successful!')),
      );
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Service')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Date & Time', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _selectDate(context),
                    icon: const Icon(Icons.calendar_today),
                    label: Text("${_selectedDate.toLocal()}".split(' ')[0]),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _selectTime(context),
                    icon: const Icon(Icons.access_time),
                    label: Text(_selectedTime.format(context)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Select Location', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _selectedLocation,
                    zoom: 14,
                  ),
                  onTap: (latLng) {
                    setState(() {
                      _selectedLocation = latLng;
                    });
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId('selected-loc'),
                      position: _selectedLocation,
                    ),
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Total Amount: \$${widget.vendor.price}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Pay & Book',
              onPressed: _initiatePayment,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
