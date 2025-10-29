import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smart_meter/services/auth_services.dart';
import 'package:smart_meter/providers/user_provider.dart';
import 'package:smart_meter/widgets/components/alert_dialog.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _authService = FirebaseAuthService();

  Future<void> _handlelogout() async {
    try {
      await _authService.signOut();
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout failed: ${e.toString()}'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(firebaseUserProvider);
    final userImage = ref.watch(userImageProvider);
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Theme(
        data: ThemeData.dark().copyWith(
          dividerColor: Colors.grey[700],
          cardTheme: const CardThemeData(
            color: Color(0xFF1E1E1E),
            elevation: 3,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: userImage != null
                          ? FileImage(userImage)
                          : const AssetImage("assets/images/light-logo.png")
                                as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () async {
                          await ref
                              .read(userImageProvider.notifier)
                              .pickImage();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              userAsync.when(
                data: (data) => Text(
                  data?.userName ?? 'User',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                error: (_, __) => const Text(
                  'User',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                loading: () => const CircularProgressIndicator(),
              ),
              userAsync.when(
                data: (data) => Text(
                  '${data?.email}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                error: (error, e) => Text('Eror: $error'),
                loading: () => const CircularProgressIndicator(),
              ),

              const SizedBox(height: 15),
              const Divider(height: 30, thickness: 1),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.notifications),
                      title: const Text("Notifications"),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        AppDialogs.showConfirmationDialog(
                          context: context,
                          title: "Coming soon",
                          message:
                              "Notifications feature will be available in future updates.",
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.dark_mode),
                      title: const Text("Dark Mode"),
                      trailing: Switch(
                        value: Theme.of(context).brightness == Brightness.dark,
                        onChanged: (value) {},
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.security),
                      title: const Text("Privacy & Security"),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        AppDialogs.showConfirmationDialog(
                          context: context,
                          title: "Coming soon",
                          message:
                              "Privacy & Security feature will be available in future updates.",
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.red),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: const Color(0xFF1E1E1E),
                            title: const Text("Confirm Logout"),
                            titleTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                            content: const Text(
                              "Are you sure you want to logout?",
                            ),
                            contentTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  _handlelogout();
                                },
                                child: const Text(
                                  "Logout",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Card(
                margin: EdgeInsets.only(top: 20),
                child: ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text("App Version"),
                  trailing: Text(
                    "1.0.0",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.only(top: 20),
                child: ListTile(
                  leading: const Icon(Icons.contact_mail_outlined),
                  title: const Text("Contact Support"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    AppDialogs.showConfirmationDialog(
                      context: context,
                      title: 'Contact Support',
                      message:
                          'For support, contact via Whatsapp +2348101564160',
                    );
                  },
                ),
              ),
              const Card(
                margin: EdgeInsets.only(top: 20),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.info_outline),
                        SizedBox(width: 10),
                        Text(
                          "About SmartMeter",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(
                          'Smart Meter is an intelligent energy monitoring system that tracks your real-time power consumption.',
                          style: TextStyle(height: 1.4),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Features:',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 3),
                        Text(
                          '• Integration with IoT sensors and devices\n'
                          '• Real-time energy consumption tracking\n'
                          '• Power usage analytics and visualization\n'
                          '• Smart notifications for usage summary\n',
                          style: TextStyle(height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
