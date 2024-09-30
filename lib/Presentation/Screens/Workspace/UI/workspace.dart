import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:finote_birhan_mobile/Data/Repositories/abal.dart';
import 'package:finote_birhan_mobile/Data/Services/firebase_service.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Abals/UI/Abal-List.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Home/UI/Dashboard.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/UI/kifile_selector.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/UI/registeration.dart';

import '../../../../Business Logic/Bloc/cubit/abals/abal_cubit.dart';
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
        child: NavigationBar(
          indicatorColor: Colors.transparent,
          indicatorShape: const CircleBorder(),
          height: 80,
          selectedIndex: selectedIndex,
          backgroundColor: Colors.white,
          destinations: const [
            NavigationDestination(
                icon: Icon(
                  Icons.travel_explore_outlined,
                  size: 25,
                  color: Colors.black,
                ),
                selectedIcon: Icon(
                  Icons.travel_explore_outlined,
                  color: ColorResources.primaryColor,
                  size: 25,
                ),
                label: 'ዳሽቦርድ'),
            NavigationDestination(
                icon: Icon(
                  Icons.message_outlined,
                  size: 25,
                  color: Colors.black,
                ),
                selectedIcon: Icon(
                  Icons.message_outlined,
                  color: ColorResources.primaryColor,
                  size: 25,
                ),
                label: 'መልዕክቶች'),
            NavigationDestination(
                icon: Icon(
                  Icons.person_outline,
                  size: 25,
                  color: Colors.black,
                ),
                selectedIcon: Icon(
                  Icons.person_outline,
                  color: ColorResources.primaryColor,
                  size: 25,
                ),
                label: 'አባሎች'),
            NavigationDestination(
                icon: Icon(
                  Icons.settings_outlined,
                  color: Colors.black,
                  size: 25,
                ),
                selectedIcon: Icon(
                  Icons.settings_outlined,
                  color: ColorResources.primaryColor,
                  size: 25,
                ),
                label: 'ገጽታዎች'),
          ],
          onDestinationSelected: (int index) {
            switch (index) {
              case 0:
                // CurrentUser().userAccount?.accountType == 'superAdmin' ||
                //         CurrentUser().userAccount?.isAdmin == true
                //     ? GoRouter.of(context).go('/dashboard')
                // :
                GoRouter.of(context).go('/dashboard');
                break;
              case 1:
                GoRouter.of(context).go('/donate');
                break;
              case 2:
                GoRouter.of(context).go('/account');
                break;
              case 3:

                //   GoRouter.of(context).go('/resources/my-orders');
                // } else {
                // }
                GoRouter.of(context).go('/resources');

                break;
              default:
                onDestinationSelected(index);
            }
          },
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
