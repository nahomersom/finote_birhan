import 'package:flutter/material.dart';

class TabIndicator extends StatelessWidget implements PreferredSizeWidget {
  const TabIndicator({
    required this.selectedIndex, // current selected screen index
    required this.title,
    super.key,
  });
  final int selectedIndex;
  final String title;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return AppBar(
      title: Text(
        title,
        style: textTheme.bodyMedium
            ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(4.0), // Height of the bottom border
          child: Row(
            children: [
              for (int i = 0; i < 3; i++) ...[
                if (i > 0)
                  const SizedBox(
                    width: 5,
                  ), // Spacing between indicators if it's not the first indicatior add space
                Expanded(child: _buildTabIndicator(i)),
              ],
            ],
          )),
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

  // Implement preferredSize, which defines the height of the AppBar
  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + 10); // Customize height if needed
}
