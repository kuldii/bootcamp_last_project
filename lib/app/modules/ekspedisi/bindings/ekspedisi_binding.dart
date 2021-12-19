import 'package:get/get.dart';

import '../controllers/ekspedisi_controller.dart';

class EkspedisiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EkspedisiController>(
      () => EkspedisiController(),
    );
  }
}
