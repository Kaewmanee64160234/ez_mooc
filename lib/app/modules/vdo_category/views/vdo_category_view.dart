import 'dart:ffi';

import 'package:ez_mooc/components/VdoComponent.dart';
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
            return VdoComponent(
                vdoDetail:
                    Get.find<VdoDetailService>().currentVdoList.value[index]);
          }),
    );
  }
}
