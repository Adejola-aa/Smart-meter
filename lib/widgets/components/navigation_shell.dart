import 'package:flutter/material.dart';

import 'package:smart_meter/widgets/components/navbar.dart';
import 'package:smart_meter/screens/dashboard/dashboard_screen.dart';
import 'package:smart_meter/screens/analytics/Analytics_Screen.dart';
import 'package:smart_meter/screens/settings/settings_screen.dart';

class NavigationShell extends StatefulWidget {
  const NavigationShell({super.key});

  @override
  State<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends State<NavigationShell> {
  int _selectedIndex = 0;
  final _pageController = PageController();

  final List<Widget> _pages = [
    const DashboardScreen(),
    const AnalyticsScreen(),
    const SettingsScreen(),
  ];

  void onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavBar(
        selectedindex: _selectedIndex,
        onTabChange: onTabChange,
      ),
      body: PageView(
        controller: _pageController,
        physics: ClampingScrollPhysics(),
        onPageChanged: (index) => setState(() {
          _selectedIndex = index;
        }),
        children: _pages,
      ),
    );
  }
}
