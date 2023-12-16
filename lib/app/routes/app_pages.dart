import 'package:get/get.dart';

import '../modules/enrollment/bindings/enrollment_binding.dart';
import '../modules/enrollment/views/enrollment_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/likeVdo/bindings/like_vdo_binding.dart';
import '../modules/likeVdo/views/like_vdo_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/playlist/bindings/playlist_binding.dart';
import '../modules/playlist/views/playlist_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/search_result/bindings/search_result_binding.dart';
import '../modules/search_result/views/search_result_view.dart';
import '../modules/vdo_category/bindings/vdo_category_binding.dart';
import '../modules/vdo_category/views/vdo_category_view.dart';
import '../modules/vdo_page/bindings/vdo_page_binding.dart';
import '../modules/vdo_page/views/vdo_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PLAYLIST,
      page: () => const PlaylistView(),
      binding: PlaylistBinding(),
    ),
    GetPage(
      name: _Paths.ENROLLMENT,
      page: () => const EnrollmentView(),
      binding: EnrollmentBinding(),
    ),
    GetPage(
      name: _Paths.VDO_PAGE,
      page: () => const VdoPageView(),
      binding: VdoPageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.LIKE_VDO,
      page: () => const LikeVdoView(),
      binding: LikeVdoBinding(),
    ),
    GetPage(
      name: _Paths.VDO_CATEGORY,
      page: () => const VdoCategoryView(),
      binding: VdoCategoryBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_RESULT,
      page: () => const SearchResultView(),
      binding: SearchResultBinding(),
    ),
  ];
}
