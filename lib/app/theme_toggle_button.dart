import 'package:flutter/material.dart';

class ThemeToggleButton extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onToggle;

  const ThemeToggleButton({
    super.key,
    required this.isDarkMode,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggle(!isDarkMode),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 100,
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isDarkMode ? Color(0xFF171717) : Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!isDarkMode)
              Icon(Icons.wb_sunny, color: Colors.yellow, size: 28),
            AnimatedAlign(
              duration: Duration(milliseconds: 300),
              alignment: isDarkMode ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: isDarkMode
                    ? Icon(Icons.nightlight_round, color: Colors.yellow, size: 22)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
