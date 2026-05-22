import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userEmail = authProvider.userEmail ?? 'saneejmsm@gmail.com';
    final userName = authProvider.userName ?? 'saneejmsm';

    // Get initials
    String initials = '';
    if (userName.isNotEmpty) {
      initials = userName.trim().substring(0, 1).toUpperCase();
      if (userName.trim().contains(' ') && userName.trim().split(' ').length > 1) {
        final parts = userName.trim().split(' ');
        initials += parts[1].substring(0, 1).toUpperCase();
      } else if (userName.length > 1) {
        initials += userName.substring(1, 2).toUpperCase();
      }
    } else {
      initials = 'S';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // User Info with Initials Avatar
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                      initials,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    userName,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userEmail,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Menu Items
            _buildProfileItem(
              context,
              icon: Icons.shopping_bag_outlined,
              title: 'My Orders',
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.orders),
            ),
            _buildProfileItem(
              context,
              icon: Icons.person_outline,
              title: 'Personal Info',
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.personalInfo),
            ),
            _buildProfileItem(
              context,
              icon: Icons.location_on_outlined,
              title: 'Addresses',
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.addresses),
            ),
            _buildProfileItem(
              context,
              icon: Icons.payment_outlined,
              title: 'Payment Methods',
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.paymentMethods),
            ),
            _buildProfileItem(
              context,
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.settingsScreen),
            ),
            _buildProfileItem(
              context,
              icon: Icons.help_outline,
              title: 'Help Center',
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.helpCenter),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    authProvider.logout();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.login,
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Logout'),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Theme.of(context).primaryColor),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
    );
  }
}
