import 'package:ez_mooc/services/vdo_detail_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search_Controller extends GetxController {
  var recentSearches = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSearches();
  }

  Future<void> saveSearch(String searchQuery) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    recentSearches.insert(0, searchQuery);
    if (recentSearches.length > 4) {
      recentSearches.removeRange(4, recentSearches.length);
    }

    await prefs.setStringList('recentSearches', recentSearches);
    Get.find<VdoDetailService>().textSearch.value = searchQuery;
    await Get.find<VdoDetailService>().getSearchVdo(searchQuery);
  }

  Future<void> loadSearches() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var storedSearches = prefs.getStringList('recentSearches');
    if (storedSearches != null) {
      recentSearches.value = storedSearches;
    }
  }
}
