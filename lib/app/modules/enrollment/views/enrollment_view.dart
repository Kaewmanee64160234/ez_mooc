import 'dart:ui';

import 'package:ez_mooc/services/enrollment_service.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EnrollmentView extends GetView {
  const EnrollmentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('คอร์สเรียนของคุณ'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() {
          if (Get.find<EnrollmentService>().enrollments.isNotEmpty) {
            return ListView.builder(
              itemCount: Get.find<EnrollmentService>().enrollments.length,
              itemBuilder: (context, index) {
                var enrollment =
                    Get.find<EnrollmentService>().enrollments[index];
                var subject = Get.find<SubjectService>().currentPlaylist.value;

                return Column(
                  children: [
                    ExpansionTile(
                      title: ListTile(
                        title: Text(subject.subjectName),
                        leading: Icon(Icons.queue_music_rounded),
                      ),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: enrollment.progress.length,
                          itemBuilder: (context, index) {
                            var vdo = enrollment.progress.elementAt(index);
                            var percentage = enrollment.progress
                                .elementAt(index)
                                .progressPercentage;
                            return ListTile(
                              title: Text(subject.subjectName.toString()),
                              subtitle: Text(subject.description.toString()),
                              leading: CircularPercentIndicator(
                                radius: 15.0,
                                lineWidth: 5.0,
                                percent: enrollment.progress
                                        .elementAt(index)
                                        .progressPercentage /
                                    100,
                                center:
                                    enrollment.progress.elementAt(index) == 100
                                        ? Text(
                                            "100%",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 8.0,
                                            ),
                                          )
                                        : Text(
                                            "${enrollment.progress.elementAt(index).progressPercentage.toStringAsPrecision(2)}%",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 8.0,
                                            ),
                                          ),
                                backgroundColor:
                                    Color.fromARGB(255, 254, 236, 236),
                                progressColor:
                                    const Color.fromARGB(255, 37, 243, 33),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Container(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FAProgressBar(
                          maxValue: 100,
                          borderRadius: BorderRadius.circular(40),
                          currentValue: enrollment.progress
                                  .map(
                                      (progress) => progress.progressPercentage)
                                  .reduce((value, element) => value + element) /
                              enrollment.progress.length,
                          displayText: '%',
                          progressGradient: LinearGradient(
                            colors: [
                              Colors.blue.withOpacity(0.75),
                              Colors.green.withOpacity(0.75),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return Text('ไม่มีข้อมูล');
          }
        }),
      ),
    );
  }

  Future<String> getThumbnailUrl(String videoUrl) async {
    var ytClient = yt.YoutubeExplode();
    try {
      var regExp = RegExp(
          r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})');

      var match = regExp.firstMatch(videoUrl);
      if (match != null && match.groupCount >= 1) {
        var videoId = match.group(1);
        var video = await ytClient.videos.get(yt.VideoId(videoId.toString()));
        ytClient.close();
        return video.thumbnails.highResUrl ?? '';
      } else {
        // Invalid YouTube URL
        throw Exception('Invalid YouTube URL');
      }
    } finally {
      ytClient.close();
    }
  }
}
