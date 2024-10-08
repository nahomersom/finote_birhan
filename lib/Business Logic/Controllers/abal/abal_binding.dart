import 'package:finote_birhan_mobile/Business%20Logic/Controllers/abal/abal_controller.dart';
import 'package:finote_birhan_mobile/Data/Repositories/abal.dart';
import 'package:finote_birhan_mobile/Data/Services/firebase_service.dart';
import 'package:get/get.dart';

class AbalBinding extends Bindings {
  @override
  void dependencies() {
    // Lazily inject the controller when needed
    Get.lazyPut<AbalController>(() => AbalController(
          abalRepository: AbalRepository(
              abalService:
                  FirestoreService()), // Pass your repository to the controller
        ));
  }
}
