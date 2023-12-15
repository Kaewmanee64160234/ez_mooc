import 'dart:ffi';
import 'dart:ui';

import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:ez_mooc/components/BuildCard.dart';
import 'package:ez_mooc/components/VideoCard.dart';
import 'package:ez_mooc/services/category_service.dart';
import 'package:ez_mooc/services/enrollment_service.dart';
import 'package:ez_mooc/services/home_service.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:ez_mooc/services/vdo_detail_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Remove shadow
        backgroundColor: Color(0xff551E68),
        leading: Image.asset(
          'images/logo.png', // Replace with your logo asset
          height: 75.0,
        ),
        title: Text(
          'MOOC',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: 'Kanit',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'images/find_icon.png', // Replace with your search icon asset
              height: 50.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => Container(
                color: Color(0xFFEDE4FF),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Section
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 15.0),
                      child: Text(
                        'หมวดหมู่',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'Kanit',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 155.0,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (var element
                              in Get.find<CategoryService>().categories)
                            GestureDetector(
                              child: _buildAllCardDetail(
                                  element.categoryImage, element.categoryName),
                              onTap: () {
                                Get.find<NavigationService>()
                                    .changeSelectedItem(5);
                              },
                            )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'แนะนำสำหรับคุณ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'Kanit',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: Get.find<SubjectService>().playlists.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: VideoCard(
                            videoUrl: Get.find<SubjectService>()
                                .playlists[index]
                                .playlistLink,
                            subject:
                                Get.find<SubjectService>().playlists[index],
                            vdoDetail: Get.find<SubjectService>()
                                .playlists[index]
                                .videos[0],
                          ),
                          onTap: () {
                            for (var element in Get.find<SubjectService>()
                                .playlists[index]
                                .videos) {
                              print(element.videoURL);
                            }
                            //set current playlist
                            Get.find<SubjectService>().setCurrentPlaylist(
                                Get.find<SubjectService>().playlists[index]);
                            //ser vdoplaylist
                            Get.find<VdoDetailService>().setVdoPlaylists(
                              Get.find<SubjectService>()
                                  .playlists[index]
                                  .videos
                                  .toList(),
                            );
                            //sert current subject
                            Get.find<VdoDetailService>().currentSubject.value =
                                Get.find<SubjectService>().playlists[index];

                            Get.find<VdoDetailService>().setCurrentVdo(
                                Get.find<VdoDetailService>()
                                    .currentSubject
                                    .value
                                    .videos[0]);

                            print(Get.find<VdoDetailService>()
                                .getCurrentVdo()
                                .videoId);

                            Get.find<EnrollmentService>().addEnrollment(
                                Get.find<SubjectService>().playlists[index]);

                            Get.find<VdoDetailService>().currentSubject =
                                Get.find<SubjectService>().playlists[index].obs;
                            Get.find<EnrollmentService>().currentVdoId =
                                Get.find<SubjectService>()
                                    .playlists[index]
                                    .videos[0]
                                    .videoId
                                    .obs;
                            print(
                                'Current vdoId : ${Get.find<EnrollmentService>().currentVdoId.value}');
                            Get.toNamed('/playlist');
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildAllCardDetail(String imagePath, String nameCat) {
  return CategoryCard(imagePath: imagePath, categoryName: nameCat);
}
