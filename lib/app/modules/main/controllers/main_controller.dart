import 'package:ez_mooc/services/category_service.dart';
import 'package:ez_mooc/services/enrollment_service.dart';
import 'package:ez_mooc/services/favorites_service.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:ez_mooc/services/user_service.dart';
import 'package:get/get.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class MainController extends GetxController {
  //TODO: Implement MainController

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  void onInit() {
    super.onInit();
    Get.find<SubjectService>().fetchAllSubjects();
    Get.find<CategoryService>().fetchAllCategories();
    Get.find<EnrollmentService>().getEnrolmentsByUserId();
    Get.find<FavoritesService>().fetchFavoritesByUserId(
        Get.find<UserService>().currentUser.value.user_id);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void logEvent(String eventName, Map<String, dynamic> parameters) async {
    await _analytics.logEvent(name: eventName, parameters: parameters);
  }
}
