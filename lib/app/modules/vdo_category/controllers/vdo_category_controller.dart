import 'package:ez_mooc/services/vdo_detail_service.dart';
import 'package:get/get.dart';

class VdoCategoryController extends GetxController {
  //TODO: Implement VdoCategoryController

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Get.find<VdoDetailService>()
        .getVdoByCategory(Get.find<VdoDetailService>().currentCategory.value);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
