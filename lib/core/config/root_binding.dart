import 'package:gemini_getx/presentation/controllers/starter_controller.dart';
import 'package:get/get.dart';

import '../../presentation/controllers/home_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => StarterController(), fenix: true);
  }
}
