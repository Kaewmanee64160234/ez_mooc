import 'package:ez_mooc/services/vdo_detail_service.dart';
import 'package:get/get.dart';

import '../controllers/vdo_category_controller.dart';

class VdoCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VdoCategoryController>(
      () => VdoCategoryController(),
    );
    Get.put(VdoDetailService());
  }
}
