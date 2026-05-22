import 'package:flutter/material.dart';

class SelectorTabs extends StatelessWidget {
  final String activeTab;
  final ValueChanged<String> onTabChanged;

  const SelectorTabs({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFFE24C4C);
    const textDark = Color(0xFF4A1A17);

    return Container(
      height: 52,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged('sabores'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: activeTab == 'sabores' ? activeColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(26),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Sabores',
                  style: TextStyle(
                    color: activeTab == 'sabores' ? Colors.white : textDark.withOpacity(0.6),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged('categorias'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: activeTab == 'categorias' ? activeColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(26),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Categorías',
                  style: TextStyle(
                    color: activeTab == 'categorias' ? Colors.white : textDark.withOpacity(0.6),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
