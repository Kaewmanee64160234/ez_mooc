import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VdoComponent extends StatelessWidget {
  final VdoDetail vdoDetail;
  const VdoComponent({super.key, required this.vdoDetail});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Ink.image(
                image: NetworkImage(vdoDetail.thumbnail),
                height: 250,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Icon(
                  Icons.videocam, // Video icon
                  color: Colors.white,
                  size: 60.0,
                ),
              ),
              // Positioned(
              //   bottom: 20,
              //   right: 20,
              //   left: 20,
              //   child: Text(
              //     vdoDetail.videoTitle,
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       color: Colors.white,
              //       fontSize: 24,
              //     ),
              //   ),
              // ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16).copyWith(bottom: 0),
            child: Text(
              vdoDetail.videoTitle,
              style: TextStyle(fontSize: 25),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // Perform some action
                },
                child: Icon(
                  Icons.thumb_up_alt_outlined,
                  color: Colors.blue,
                  size: 30.0,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    // Perform some action
                  },
                  child: Icon(
                    Icons.bookmark_border,
                    color: Color.fromARGB(255, 240, 121, 48),
                    size: 30.0,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
