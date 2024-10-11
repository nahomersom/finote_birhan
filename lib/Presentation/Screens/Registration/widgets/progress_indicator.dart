import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabIndicator extends StatelessWidget {
  const TabIndicator({
    required this.selectedIndex, // current selected screen index
    super.key,
  });
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 4; i++) ...[
          if (i > 0)
            SizedBox(
                width:
                    5), // Spacing between indicators if it's not the first indicatior add space
          Expanded(child: _buildTabIndicator(i)),
        ],
      ],
    );
  }

  Widget _buildTabIndicator(int index) {
    bool isSelected = selectedIndex >=
        index; // Show gradient for current and all previous tabs
    return Container(
      height: 5.0, // Thickness of the bottom border
      decoration: BoxDecoration(
        gradient: isSelected
            ? const LinearGradient(
                colors: [Color(0xff6115da), Color(0xffbd2aec)],
                stops: [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isSelected
            ? null
            : const Color.fromARGB(
                255, 199, 198, 198), // Non-selected color for future tabs
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
