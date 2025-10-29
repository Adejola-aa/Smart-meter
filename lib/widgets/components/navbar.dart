import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    required this.selectedindex,
    required this.onTabChange,
    super.key,
  });

  final int selectedindex;
  final Function(int) onTabChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF003A9B),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
        child: GNav(
          activeColor: Colors.white,
          color: Colors.grey[300],
          tabBackgroundColor: const Color(0xFF003366),
          gap: 8,
          padding: const EdgeInsets.all(12),
          tabs: const [
            GButton(icon: Icons.home, iconSize: 27, text: 'Dashboard'),
            GButton(icon: Icons.bar_chart, iconSize: 27, text: 'Analytics'),
            GButton(icon: Icons.settings, iconSize: 27, text: 'Settings'),
          ],
          selectedIndex: selectedindex,
          onTabChange: onTabChange,
        ),
      ),
    );
  }
}
