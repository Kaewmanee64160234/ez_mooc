import 'package:ez_mooc/app/modules/enrollment/views/enrollment_view.dart';
import 'package:ez_mooc/app/modules/history/views/history_view.dart';
import 'package:ez_mooc/app/modules/home/views/home_view.dart';
import 'package:ez_mooc/app/modules/likeVdo/views/like_vdo_view.dart';
import 'package:ez_mooc/app/modules/profile/views/profile_view.dart';
import 'package:ez_mooc/app/modules/search_result/views/search_result_view.dart';
import 'package:ez_mooc/app/modules/vdo_category/views/vdo_category_view.dart';
import 'package:ez_mooc/services/home_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return _getBody(Get.find<NavigationService>().selectedItem.value);
      }),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        child: SizedBox(
          height: 80.0,
          child: BottomNavigationBar(
            unselectedItemColor: Colors.black54,
            backgroundColor: Color(0xff551E68),
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 0.0,
            unselectedFontSize: 0.0,
            currentIndex: Get.find<NavigationService>().selectedItem.value,
            onTap: (index) {
              Get.find<NavigationService>().changeSelectedItem(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'images/vdo_nav.png', // Replace with the path to your play_circle image
                  height: 50.0,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'images/bookmark_nav.png', // Replace with the path to your bookmark image
                  height: 50.0,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'images/home_nav.png', // Replace with the path to your home image
                  height: 50.0,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'images/heart_nav.png', // Replace with the path to your history_rounded image
                  height: 50.0,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'images/old_nav.png', // Replace with the path to your person_2 image
                  height: 50.0,
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBody(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        controller.logEvent('enrollment', {'enrollment': 'enrollment'});
        return EnrollmentView();
      case 1:
        controller.logEvent('history', {'history': 'history'});
        return HistoryView();
      case 2:
        controller.logEvent('home', {'home': 'home'});
        return HomeView();
      case 3:
        controller.logEvent('likeVdo', {'likeVdo': 'likeVdo'});
        return LikeVdoView();
      case 4:
        controller.logEvent('profile', {'profile': 'profile'});
        return ProfileView();
      case 5:
        return VdoCategoryView();
      case 6:
        return SearchResultView();
      default:
        return Container(); // Handle default case or return an empty container.
    }
  }
}
