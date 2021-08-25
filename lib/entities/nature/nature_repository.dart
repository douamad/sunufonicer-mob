import 'package:sunufoncier/entities/nature/nature_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class NatureRepository {
    NatureRepository();

  static final String uriEndpoint = '/natures';

  Future<List<Nature>?> getAllNatures() async {
    final allNaturesRequest = await HttpUtils.getRequest(uriEndpoint);
    return JsonMapper.deserialize<List<Nature>>(allNaturesRequest.body);
  }

  Future<Nature?> getNature(int? id) async {
    final natureRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return JsonMapper.deserialize<Nature>(natureRequest.body);
  }

  Future<Nature?> create(Nature nature) async {
    final natureRequest = await HttpUtils.postRequest('$uriEndpoint', nature);
    return JsonMapper.deserialize<Nature>(natureRequest.body);
  }

  Future<Nature?> update(Nature nature) async {
    final natureRequest = await HttpUtils.putRequest('$uriEndpoint', nature);
    return JsonMapper.deserialize<Nature>(natureRequest.body);
  }

  Future<void> delete(int id) async {
    final natureRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
