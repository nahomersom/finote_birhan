import 'package:finote_birhan_mobile/Business%20Logic/Controllers/abal/abal_binding.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Abals/UI/Abal-List.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Home/UI/Dashboard.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Login/UI/login.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/views/kifile_selector.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/views/registeration.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/widgets/abal_form.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/widgets/family_form.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Workspace/UI/workspace.dart';

import 'package:get/get.dart';
part 'app_routes.dart';

class RouteConfig {
  static String initialLocation = AppRoutes.WORKSPACE.toRoute();

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.LOGIN.toRoute(),
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.WORKSPACE.toRoute(),
      page: () => const Workspace(),
    ),
    GetPage(
      name: AppRoutes.DASHOBARD.toRoute(),
      page: () => DashboardScreen(),
      children: [
        GetPage(
          name: AppRoutes.KIFILE.toRoute(),
          page: () => const KifileSelector(),
          children: [
            GetPage(
              name: AppRoutes.ABALFORM.toRoute(),
              page: () => AbalF
              
              orm(),
            ),
            GetPage(
              name: AppRoutes.FAMILYFORM.toRoute(),
              page: () => FamilyForm(),
            ),
          ],
        ),
        GetPage(
          name: AppRoutes.ABALS.toRoute(),
          page: () => const AbalListScreen(),
          binding: AbalBinding(),
          children: [
            GetPage(
              name: AppRoutes.REGISTRAION.toRoute(),
              page: () => const RegistrationScreen(),
            ),
          ],
        ),
      ],
    ),
  ];
}
