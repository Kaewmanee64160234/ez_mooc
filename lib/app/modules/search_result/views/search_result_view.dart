import 'dart:ffi';

import 'package:ez_mooc/services/vdo_detail_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_result_controller.dart';

class SearchResultView extends GetView<SearchResultController> {
  const SearchResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SearchResultView'),
          centerTitle: true,
        ),
        //body kis list view get from  current vdolist
        //listview.builder
        body: ListView.builder(
            itemCount: Get.find<VdoDetailService>().currentVdoList.value.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                    width: 100,
                    height: 100,
                    child: Image.network(Get.find<VdoDetailService>()
                        .currentVdoList
                        .value[index]
                        .thumbnail)),
                title: Text(Get.find<VdoDetailService>()
                    .currentVdoList
                    .value[index]
                    .videoTitle),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  // Implement action on tapping a recent search item, if needed
                },
              );
            }));
  }
}
