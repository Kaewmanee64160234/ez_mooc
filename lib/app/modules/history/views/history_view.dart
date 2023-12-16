import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:ez_mooc/services/bookmark_service.dart';
import 'package:ez_mooc/services/enrollment_service.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:ez_mooc/services/vdo_detail_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Remove shadow
        backgroundColor: Color(0xff551E68),
        centerTitle: true,
        title: Text('Bookmarks',
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'Kanit',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ),
      body: Container(
        child: Get.find<BookmarksService>().bookmarks.length == 0
            ? Center(
                child: Text(
                  "ไม่มีรายการที่บันทึกไว้", // Thai text for "Don't have bookmark"
                  style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Kanit',
                  ),
                ),
              )
            : ListView.builder(
                itemCount: Get.find<BookmarksService>().bookmarks.length,
                itemBuilder: (context, index) {
                  VdoDetail video =
                      Get.find<BookmarksService>().bookmarks[index].vdoDetail;
                  return GestureDetector(
                    child: Card(
                      // Add custom styling and layout to match the image
                      child: Column(
                        children: [
                          Image.network(
                              video.thumbnail), // Display video thumbnail
                          ListTile(
                              title:
                                  Text(video.videoTitle), // Display video title
                              subtitle: Text(
                                  video.channelName), // Display channel name
                              // Add a custom progress indicator here
                              onTap: () {}),
                        ],
                      ),
                    ),
                    onTap: () {
                      Subject sub = Get.find<SubjectService>()
                          .playlists
                          .firstWhere((element) =>
                              element.subjectId == video.subjectId);
                      //set current playlist
                      Get.find<SubjectService>().setCurrentPlaylist(sub);

                      //ser vdoplaylist
                      Get.find<VdoDetailService>().setVdoPlaylists(sub.videos);
                      //sert current subject
                      Get.find<VdoDetailService>().currentSubject.value = sub;

                      Get.find<VdoDetailService>().setCurrentVdo(video);

                      print(
                          Get.find<VdoDetailService>().getCurrentVdo().videoId);

                      Get.find<EnrollmentService>().addEnrollment(sub);

                      Get.find<VdoDetailService>().currentSubject = sub.obs;
                      Get.find<EnrollmentService>().currentVdoId =
                          video.videoId.obs;
                      print(
                          'Current vdoId : ${Get.find<EnrollmentService>().currentVdoId.value}');
                      Get.toNamed('/playlist');
                    },
                  );
                },
              ),
      ),
    );
  }
}
