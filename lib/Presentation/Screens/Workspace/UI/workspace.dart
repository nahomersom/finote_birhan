import 'package:finote_birhan_mobile/Business%20Logic/Controllers/abal/abal_controller.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';
import 'package:finote_birhan_mobile/Data/Repositories/abal.dart';
import 'package:finote_birhan_mobile/Data/Services/firebase_service.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Abals/UI/Abal-List.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Home/UI/Dashboard.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/UI/kifile_selector.dart';
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
    // Instantiate the MainController
    final MainController controller = Get.put(MainController());

    return Obx(() => Scaffold(
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: const [
              // Replace these with your actual screens
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
              fontWeight:
                  FontWeight.w600, // Increased font weight for selected item
            ),
            selectedItemColor: ColorResources.primaryColor,
            unselectedItemColor: Colors.black,
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
        ));
  }
}
