import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/data_controller.dart';
import '../../models/vendor_model.dart';
import '../../models/user_model.dart';
import '../../widgets/custom_button.dart';
import '../../services/firestore_service.dart';
import 'vendor_main_screen.dart';

class VendorRegistrationScreen extends ConsumerStatefulWidget {
  final UserModel user;
  const VendorRegistrationScreen({Key? key, required this.user}) : super(key: key);

  @override
  ConsumerState<VendorRegistrationScreen> createState() => _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends ConsumerState<VendorRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _experienceController = TextEditingController();
  bool _isLoading = false;

  void _registerVendor() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final vendor = VendorModel(
      id: widget.user.id,
      name: widget.user.name,
      category: _categoryController.text,
      price: double.parse(_priceController.text),
      experience: int.parse(_experienceController.text),
      lat: 37.422, // Dummy location for now, should use Geolocator
      lng: -122.084,
      profileImage: widget.user.profileImage,
    );

    if (widget.user.id == 'test_user_id') {
      // Test Mode
      ref.read(currentUserProvider.notifier).state = widget.user;
       Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const VendorMainScreen()),
        (route) => false,
      );
      return;
    }

    // Save user role as vendor first
    await ref.read(authServiceProvider).saveUser(widget.user);
    // Create vendor profile
    await ref.read(firestoreServiceProvider).createVendorProfile(vendor);

    setState(() => _isLoading = false);
    // Navigation handled by main stream
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vendor Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Service Category (e.g. Plumber)'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Hourly Price (\$)'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _experienceController,
                decoration: const InputDecoration(labelText: 'Years of Experience'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Complete Registration',
                onPressed: _registerVendor,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
