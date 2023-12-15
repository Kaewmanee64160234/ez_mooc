import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/vdo_category_controller.dart';

class VdoCategoryView extends GetView<VdoCategoryController> {
  const VdoCategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'VdoCategoryView is working',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
