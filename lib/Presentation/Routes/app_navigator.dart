import 'package:get/get.dart';

import 'app_pages.dart';

class AppNavigator {
  static void backLogin() {
    Get.until((route) => Get.currentRoute == AppRoutes.LOGIN);
  }

  static void startLogin() {
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  static void startWorkspace() {
    Get.offAllNamed(AppRoutes.WORKSPACE);
  }

  static void startDashboard() {
    Get.offAllNamed(AppRoutes.DASHOBARD);
  }

  static void startKifileSelection() {
    Get.toNamed(AppRoutes.KIFILE);
  }

  static void startRegistraion() {
    Get.toNamed(AppRoutes.REGISTRATION);
  }

  static void starAbalList() {
    Get.toNamed(AppRoutes.ABALS);
  }

  static void startAbalFormRegistration() {
    Get.toNamed(
        '${AppRoutes.DASHOBARD.toRoute()}${AppRoutes.KIFILE.toRoute()}${AppRoutes.ABALFORM.toRoute()}');
  }

  static void startFamilyFormRegistration() {
    Get.toNamed(
        '${AppRoutes.DASHOBARD.toRoute()}${AppRoutes.KIFILE.toRoute()}${AppRoutes.FAMILYFORM.toRoute()}');
  }
  // static void startMiniApp({required String url}) {
  //   Get.toNamed(AppRoutes.MINIAPP, arguments: url);
  // }
}
