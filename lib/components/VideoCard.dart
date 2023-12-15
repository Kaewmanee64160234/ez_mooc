import 'dart:ffi';

import 'package:card_loading/card_loading.dart';
import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:ez_mooc/app/modules/profile/views/profile_view.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class VideoCard extends StatelessWidget {
  final String videoUrl;
  final VdoDetail vdoDetail;
  final Subject subject;

  VideoCard(
      {required this.videoUrl, required this.subject, required this.vdoDetail});

  final SubjectService subjectService = Get.find<SubjectService>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: subjectService
          .getChannelProfileImageUrlFromVideoUrl(vdoDetail.videoURL),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return _buildSkeletonLoader();
        } else if (asyncSnapshot.hasError) {
          return Text('Error loading channel image');
        } else if (asyncSnapshot.hasData) {
          // Use _buildVideoCard and pass the fetched image URL
          return _buildVideoCard(
            vdoDetail,
            asyncSnapshot.data!,
            subject.description,
          );
        } else {
          return Text('Channel image not available');
        }
      },
    );
  }

  Widget _buildSkeletonLoader() {
    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5.0,
      child: CardLoading(
        height: 80,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        width: 100,
        margin: EdgeInsets.only(bottom: 10),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder<VdoDetail>(
  //     future: extractPlaylistInfo(videoUrl),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return SkeletonLoader(
  //           builder: _buildSkeletonLoader(),
  //           items: 10, // Number of skeleton loaders
  //           period: Duration(seconds: 2), // Duration of the animation loop
  //         );
  //       } else if (snapshot.hasError) {
  //         return Text('Error loading video details');
  //       } else if (snapshot.hasData) {
  //         VdoDetail vdoDetail = snapshot.data!;

  //         return _buildVideoCard(vdoDetail, snapshot.data!.videoTitle,
  //             snapshot.data!.channelName, subject.description, subject);
  //       } else {
  //         return Text('Unknown error occurred');
  //       }
  //     },
  //   );
  // }

  Widget _buildVideoCard(
    VdoDetail vdoDetail,
    String channelImageUrl,
    String descriptionPlaylist,
  ) {
    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5.0,
      child: Column(
        children: <Widget>[
          Container(
            height: 70.0,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: Colors.white, // Choose a color for the header
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            width: double.infinity,
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(channelImageUrl),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    '${vdoDetail.channelName} • ${_formatUploadDate(DateTime.parse(subject.createdAt))}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                // Icon(Icons.more_vert),
              ],
            ),
          ),
          ClipRRect(
            child: Image.network(
              vdoDetail.thumbnail ?? '',
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  subject.subjectName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    descriptionPlaylist,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Other Widgets
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatUploadDate(DateTime uploadDate) {
    var daysSinceUpload = DateTime.now().difference(uploadDate).inDays;

    if (daysSinceUpload == 0) {
      return 'Today';
    } else if (daysSinceUpload == 1) {
      return 'Yesterday';
    } else {
      return '$daysSinceUpload days ago';
    }
  }
}

Future<VdoDetail> extractPlaylistInfo(String playlistUrl) async {
  var ytClient = YoutubeExplode();

  try {
    var playlistId = PlaylistId(playlistUrl);
    var playlist = await ytClient.playlists.get(playlistId);

    var firstVideo = await ytClient.playlists.getVideos(playlistId).first;

    var vdoDetail = VdoDetail(
        category: [],
        videoId: 1,
        subjectId: 1,
        videoTitle: playlist.title,
        videoURL: firstVideo.url.toString(),
        thumbnail: firstVideo.thumbnails.highResUrl,
        channelName: playlist.author,
        videoCode: '',
        createdAt: '',
        updatedAt: '');

    return vdoDetail;
  } catch (e) {
    print('Error: $e');
    return VdoDetail(
        category: [],
        videoId: 1,
        subjectId: 1,
        videoTitle: '',
        videoURL: '',
        thumbnail: '',
        channelName: '',
        videoCode: '',
        createdAt: '',
        updatedAt: '');
  } finally {
    ytClient.close();
  }
}
