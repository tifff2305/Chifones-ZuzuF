import 'package:flutter/material.dart';

class AdminNavBar extends StatelessWidget {
  final int currentTab;
  final ValueChanged<int> onTabSelected;

  const AdminNavBar({
    Key? key,
    required this.currentTab,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_rounded),
          _buildNavItem(1, Icons.shopping_bag_outlined),
          _buildNavItem(2, Icons.bar_chart_rounded),
          _buildNavItem(3, Icons.person_outline_rounded),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    const buttonRed = Color(0xFFE24C4C);
    final isSelected = currentTab == index;

    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isSelected ? buttonRed : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          icon,
          size: 26,
          color: isSelected ? Colors.white : const Color(0xFFB39896),
        ),
      ),
    );
  }
}
