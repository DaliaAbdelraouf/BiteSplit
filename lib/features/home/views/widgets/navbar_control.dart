import 'package:bitesplit/features/home/views/home_view.dart';
import 'package:flutter/material.dart';

import 'package:bitesplit/features/bill_split/views/bill_split_view.dart';
import 'package:bitesplit/features/home/views/widgets/custom_navbar.dart';

class NavbarControl extends StatefulWidget {
  const NavbarControl({super.key});
  static const String id = 'NavbarControl';

  @override
  State<NavbarControl> createState() => _NavbarControlState();
}

class _NavbarControlState extends State<NavbarControl> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeView(),   
    const BillSplitView(),  
    Container(),            
  ];

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context); 
    return Scaffold(
      backgroundColor:  theme.brightness == Brightness.dark
                ? const Color(0xFF1F1F1F)
                : const Color(0xffeffcf5), 
      extendBody: true, 
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onNavTap: _onNavTap,
      ),
    );
  }
}
