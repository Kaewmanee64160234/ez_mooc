import 'package:ez_mooc/services/home_service.dart';
import 'package:ez_mooc/services/vdo_detail_service.dart';
import 'package:get/get.dart';

import '../controllers/search_result_controller.dart';

class SearchResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchResultController>(
      () => SearchResultController(),
    );
    Get.lazyPut(() => VdoDetailService());
    Get.lazyPut(() => NavigationService());
  }
}
