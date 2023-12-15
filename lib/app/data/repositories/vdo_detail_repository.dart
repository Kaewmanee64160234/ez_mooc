import 'dart:convert';

import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:ez_mooc/app/data/repositories/repository.dart';
import 'package:http/http.dart' as http;

class VdoDetailRepository extends IRepository<VdoDetail> {
  final url = 'http://10.0.2.2:8000/api';

  @override
  Future<void> delete(VdoDetail t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<VdoDetail>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<VdoDetail?> getOne(int id) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<void> insert(VdoDetail t) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<void> update(VdoDetail t) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<List<VdoDetail>> getVdoByCategory(int id) async {
    try {
      final response = await http.get(Uri.parse('$url/video/category/$id'));
      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        List<dynamic> vdoJson = decodedResponse['data'];
        List<VdoDetail> vdo =
            vdoJson.map((vdoJson) => VdoDetail.fromJson(vdoJson)).toList();
        return vdo;
      } else {
        print('Failed to load vdo - Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load vdo');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
