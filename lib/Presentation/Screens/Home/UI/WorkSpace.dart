import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../Data/Data Providers/colors.dart';
import 'Dashboard.dart';
class WorkSpace extends StatefulWidget {
   WorkSpace({Key? key}) : super(key: key);

  @override
  State<WorkSpace> createState() => _WorkSpaceState();
}

class _WorkSpaceState extends State<WorkSpace> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
     const DashboardScreen(),
    const  DashboardScreen(),
      const DashboardScreen(),
    ];
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorResources.secondaryColor.withOpacity(0.9),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: ColorResources.textColor.withOpacity(0.6),
        backgroundColor: ColorResources.primaryColor,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 35,
        onTap: (index) => {
          setState(() {
            _currentIndex = index;
          })
        },
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 30,
              ),
              activeIcon: Icon(
                Icons.home_outlined,
                size: 30,
              ),
              label: 'መግቢያ'),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.messenger_outline_outlined,
                size: 30,
              ),

              label: 'መወያያ'),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline_rounded,
                size: 30,
              ),
              label: 'ማስተካከያ'),
        ],
      ),
    );
  }
}
