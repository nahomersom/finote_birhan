import 'package:finote_birhan_mobile/Business%20Logic/Controllers/abal/abal_controller.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';
import 'package:finote_birhan_mobile/Data/Repositories/abal.dart';
import 'package:finote_birhan_mobile/Data/Services/firebase_service.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Abals/UI/Abal-List.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Home/UI/Dashboard.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/views/kifile_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// MainController to manage navigation for bottom tabs
class MainController extends GetxController {
  var selectedIndex = 0.obs;
// Reference to AbalController
  final AbalController abalController = Get.put(AbalController(
      abalRepository: AbalRepository(abalService: FirestoreService())));

  void changeTabIndex(int index) {
    selectedIndex.value = index;
    // Check if the 'አባሎች' tab is selected (assuming it's index 2)
    if (index == 2) {
      // Call the getAbals() method from AbalController when 'አባሎች' is selected
      abalController.getAbals();
    }
  }
}

class Workspace extends StatelessWidget {
  const Workspace({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.put(MainController());

    return Obx(() => Scaffold(
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: [
              DashboardScreen(),
              DashboardScreen(),
              AbalListScreen(),
              DashboardScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeTabIndex,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            selectedItemColor: ColorResources
                .primaryColor, // Can be removed, since we are applying gradient
            unselectedItemColor: Colors.black,
            items: [
              _buildBottomNavigationBarItem(
                iconData: Icons.travel_explore_outlined,
                selectedIconData: Icons.travel_explore,
                label: 'ዳሽቦርድ',
                isSelected: controller.selectedIndex.value == 0,
              ),
              _buildBottomNavigationBarItem(
                iconData: Icons.message_outlined,
                selectedIconData: Icons.message,
                label: 'መልዕክቶች',
                isSelected: controller.selectedIndex.value == 1,
              ),
              _buildBottomNavigationBarItem(
                iconData: Icons.person_outline,
                selectedIconData: Icons.person,
                label: 'አባሎች',
                isSelected: controller.selectedIndex.value == 2,
              ),
              _buildBottomNavigationBarItem(
                iconData: Icons.settings_outlined,
                selectedIconData: Icons.settings,
                label: 'ገጽታዎች',
                isSelected: controller.selectedIndex.value == 3,
              ),
            ],
          ),
        ));
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required IconData iconData,
    required IconData selectedIconData,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: isSelected
            ? ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [
                      Color(0xff6115da),
                      Color(0xffbd2aec),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: Icon(
                  selectedIconData,
                  size: 24,
                  color: Colors.white, // Gradient will override this color
                ),
              )
            : Icon(
                iconData,
                size: 20,
              ),
      ),
      label: label,
    );
  }
}
