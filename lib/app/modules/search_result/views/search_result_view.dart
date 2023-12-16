import 'dart:ffi';

import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/components/VdoComponent.dart';
import 'package:ez_mooc/services/enrollment_service.dart';
import 'package:ez_mooc/services/home_service.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:ez_mooc/services/vdo_detail_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_result_controller.dart';

class SearchResultView extends GetView<SearchResultController> {
  const SearchResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vdoList = Get.find<VdoDetailService>().currentVdoList.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ผลการค้นหา",
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: 'Kanit',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.find<NavigationService>().changeSelectedItem(2);
          },
        ),
        centerTitle: true,
        backgroundColor: Color(0xff551E68),
      ),
      body: vdoList.isEmpty
          ? Center(
              child: Text('No Results Found')) // Show this if the list is empty
          : ListView.builder(
              itemCount: vdoList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: VdoComponent(vdoDetail: vdoList[index]),
                  onTap: () {
                    Subject sub = Get.find<SubjectService>()
                        .playlists
                        .firstWhere((element) =>
                            element.subjectId == vdoList[index].subjectId);
                    //set current playlist
                    Get.find<SubjectService>().setCurrentPlaylist(sub);

                    //ser vdoplaylist
                    Get.find<VdoDetailService>().setVdoPlaylists(sub.videos);
                    //sert current subject
                    Get.find<VdoDetailService>().currentSubject.value = sub;

                    Get.find<VdoDetailService>().setCurrentVdo(vdoList[index]);

                    print(Get.find<VdoDetailService>().getCurrentVdo().videoId);

                    Get.find<EnrollmentService>().addEnrollment(sub);

                    Get.find<VdoDetailService>().currentSubject = sub.obs;
                    Get.find<EnrollmentService>().currentVdoId =
                        vdoList[index].videoId.obs;
                    print(
                        'Current vdoId : ${Get.find<EnrollmentService>().currentVdoId.value}');
                    Get.toNamed('/playlist');
                  },
                );
              },
            ),
    );
  }
}
