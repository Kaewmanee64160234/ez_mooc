import 'package:ez_mooc/app/data/model/category_model.dart';
import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:ez_mooc/app/data/repositories/vdo_detail_repository.dart';
import 'package:get/get.dart';

class VdoDetailService extends GetxService {
  RxList<VdoDetail> vdoPlaylists = RxList<VdoDetail>.of([]).obs();
  RxInt currentCategory = 1.obs;

  Rx<Subject> currentSubject = Subject(
      subjectId: 1,
      subjectName: "",
      description: "",
      playlistLink: "",
      createdAt: '',
      updatedAt: '',
      videos: []).obs;
  Rx<VdoDetail> currentDetail = VdoDetail(
          category: [],
          videoId: 1,
          subjectId: 1,
          videoTitle: "",
          videoURL: "",
          thumbnail: "",
          channelName: "",
          videoCode: "",
          createdAt: "",
          updatedAt: "")
      .obs;
  RxString currentVdoUrl = "".obs;
  Rx<RxList<VdoDetail>> currentVdoList = RxList<VdoDetail>.of([]).obs;

  //get vdoPlaylists
  List<VdoDetail> getVdoPlaylists() {
    return vdoPlaylists.value;
  }

  //set vdoPlaylists
  void setVdoPlaylists(List<VdoDetail> list) {
    vdoPlaylists.value = list;
  }

  //get current vdo
  VdoDetail getCurrentVdo() {
    return currentDetail.value;
  }

  //set current vdo
  void setCurrentVdo(VdoDetail vdo) {
    currentDetail.value = vdo;
  }

  //get currentCategory
  int getCurrentCategory() {
    return currentCategory.value;
  }

  //set current category
  Future<void> setCurrentCategory(int id) async {
    currentCategory.value = id;
    await getVdoByCategory(id);
  }

  // create function get  vdo by category id from repository
  Future<void> getVdoByCategory(int id) async {
    try {
      print(
          "==================get vdo by category id from repository==================");
      List<VdoDetail> list = await VdoDetailRepository().getVdoByCategory(id);
      currentVdoList.value.clear();
      currentVdoList.value.addAll(list);
      print(
          "currentVdoList.value.length : ${currentVdoList.value[0].toJson()}");
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
