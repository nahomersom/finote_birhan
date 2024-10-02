import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages

import '../../../../Data/Data Providers/colors.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 450) {
        return ScaffoldWithNavigationBar(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      } else {
        return ScaffoldWithNavigationRail(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      }
    });
  }
}

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    // Adjust 360 according to your design
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (Set<WidgetState> states) {
              double screenWidth = MediaQuery.of(context).size.width;

              double baseFontSize = 16.0;
              double fontSize = screenWidth /
                  470 *
                  baseFontSize; // Adjust 360 according to your design

              return states.contains(WidgetState.selected)
                  ? TextStyle(
                      color: ColorResources.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                    )
                  : TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                    );
            },
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontWeight:
                FontWeight.w600, // Increased font weight for selected item
          ),
          selectedItemColor: ColorResources.primaryColor,
          unselectedItemColor: Colors.black,
          onTap: (int index) {
            switch (index) {
              case 0:
                GoRouter.of(context).go('/dashboard');
                break;
              case 1:
                GoRouter.of(context).go('/donate');
                break;
              case 2:
                GoRouter.of(context).go('/account');
                break;
              case 3:
                GoRouter.of(context).go('/resources');
                break;
              default:
                onDestinationSelected(index);
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0), // Padding above the icon
                child: Icon(
                  Icons.travel_explore_outlined,
                  size: 20,
                ),
              ),
              label: 'ዳሽቦርድ',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0), // Padding above the icon
                child: Icon(
                  Icons.message_outlined,
                  size: 20,
                ),
              ),
              label: 'መልዕክቶች',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0), // Padding above the icon
                child: Icon(
                  Icons.person_outline,
                  size: 20,
                ),
              ),
              label: 'አባሎች',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0), // Padding above the icon
                child: Icon(
                  Icons.settings_outlined,
                  size: 20,
                ),
              ),
              label: 'ገጽታዎች',
            ),
          ],
        ),
      ),
    );
  }
}

class ScaffoldWithNavigationRail extends StatelessWidget {
  const ScaffoldWithNavigationRail({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                label: Text('Section A'),
                icon: Icon(Icons.home),
              ),
              NavigationRailDestination(
                label: Text('Section B'),
                icon: Icon(Icons.settings),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}
