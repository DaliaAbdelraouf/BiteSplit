import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final Function(int) onNavTap;
  final int selectedIndex;

  CustomNavBar({
    required this.onNavTap,
    required this.selectedIndex,
    super.key,
  });

  final List<String> _titles = ["Home", "Split", "More"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, -2),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              _titles.length,
              (index) => _menuItem(_titles[index], index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuItem(String title, int index) {
    bool isActive = selectedIndex == index;

    return GestureDetector(
      onTap: () => onNavTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: isActive
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.white,
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
