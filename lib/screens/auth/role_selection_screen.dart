import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../models/user_model.dart';
import '../../widgets/custom_button.dart';
import '../../utils/constants.dart';
import '../vendor/vendor_registration_screen.dart';
import '../customer/customer_main_screen.dart';

class RoleSelectionScreen extends ConsumerStatefulWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends ConsumerState<RoleSelectionScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedRole = 'customer';
  bool _isLoading = false;



  void _saveProfile() async {
    if (_nameController.text.isEmpty) return;
    
    final user = ref.read(authServiceProvider).currentUser;
    
    // Handle Test Mode (No Firebase User)
    if (user == null) {
       final dummyUser = UserModel(
        id: 'test_user_id',
        name: _nameController.text,
        phone: '+919876543210',
        role: _selectedRole,
      );
      
      // In a real app we'd save this to local storage or a mock service
      // For now, we just update the provider state if possible or manually navigate
      
      // Manually update the current user provider for the session
      ref.read(currentUserProvider.notifier).state = dummyUser;

      if (_selectedRole == 'vendor') {
         Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => VendorRegistrationScreen(user: dummyUser)),
        );
      } else {
        // Navigate to Customer Main
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const CustomerMainScreen()),
          (route) => false,
        );
      }
      return;
    }

    if (user != null) {
      final userModel = UserModel(
        id: user.uid,
        name: _nameController.text,
        phone: user.phoneNumber ?? '',
        role: _selectedRole,
      );

      if (_selectedRole == 'vendor') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => VendorRegistrationScreen(user: userModel)),
        );
      } else {
        setState(() => _isLoading = true);
        await ref.read(authServiceProvider).saveUser(userModel);
        setState(() => _isLoading = false);
        // AuthWrapper will handle navigation
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            const Text('I am a:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildRoleCard('Customer', Icons.person, 'customer'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildRoleCard('Vendor', Icons.work, 'vendor'),
                ),
              ],
            ),
            const Spacer(),
            CustomButton(
              text: 'Continue',
              onPressed: _saveProfile,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(String title, IconData icon, String role) {
    final isSelected = _selectedRole == role;
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = role),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: isSelected ? AppColors.primary : Colors.grey),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.primary : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
