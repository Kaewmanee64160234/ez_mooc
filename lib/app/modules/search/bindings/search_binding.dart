import 'package:ez_mooc/services/home_service.dart';
import 'package:ez_mooc/services/vdo_detail_service.dart';
import 'package:get/get.dart';

import '../controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Search_Controller>(
      () => Search_Controller(),
    );
    Get.lazyPut(() => VdoDetailService());
    Get.lazyPut(() => NavigationService());
  }
}
