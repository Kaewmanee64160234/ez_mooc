import 'dart:ffi';

import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:ez_mooc/components/VdoComponent.dart';
import 'package:ez_mooc/services/enrollment_service.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:ez_mooc/services/vdo_detail_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/vdo_category_controller.dart';

class VdoCategoryView extends GetView<VdoCategoryController> {
  const VdoCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //   child: Center(
      //       child: Text(
      //     'VdoCategoryView is working ${Get.find<VdoDetailService>().currentVdoList.value.length}}',
      //     style: TextStyle(fontSize: 20),
      //   )),
      // );
      child: ListView.builder(
          itemCount: Get.find<VdoDetailService>().currentVdoList.value.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                child: VdoComponent(
                    vdoDetail: Get.find<VdoDetailService>()
                        .currentVdoList
                        .value[index]),
                onTap: () {
                  VdoDetail video =
                      Get.find<VdoDetailService>().currentVdoList.value[index];
                  Subject sub = Get.find<SubjectService>().playlists.firstWhere(
                      (element) => element.subjectId == video.subjectId);
                  //set current playlist
                  Get.find<SubjectService>().setCurrentPlaylist(sub);

                  //ser vdoplaylist
                  Get.find<VdoDetailService>().setVdoPlaylists(sub.videos);
                  //sert current subject
                  Get.find<VdoDetailService>().currentSubject.value = sub;

                  Get.find<VdoDetailService>().setCurrentVdo(video);

                  print(Get.find<VdoDetailService>().getCurrentVdo().videoId);

                  Get.find<EnrollmentService>().addEnrollment(sub);

                  Get.find<VdoDetailService>().currentSubject = sub.obs;
                  Get.find<EnrollmentService>().currentVdoId =
                      video.videoId.obs;
                  print(
                      'Current vdoId : ${Get.find<EnrollmentService>().currentVdoId.value}');
                  Get.toNamed('/playlist');
                });
          }),
    );
  }
}
