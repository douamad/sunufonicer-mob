import 'package:sunufoncier/entities/commune/commune_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class CommuneRepository {
    CommuneRepository();

  static final String uriEndpoint = '/communes';

  Future<List<Commune>?> getAllCommunes() async {
    final allCommunesRequest = await HttpUtils.getRequest(uriEndpoint);
    return JsonMapper.deserialize<List<Commune>>(allCommunesRequest.body);
  }

  Future<Commune?> getCommune(int? id) async {
    final communeRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return JsonMapper.deserialize<Commune>(communeRequest.body);
  }

  Future<Commune?> create(Commune commune) async {
    final communeRequest = await HttpUtils.postRequest('$uriEndpoint', commune);
    return JsonMapper.deserialize<Commune>(communeRequest.body);
  }

  Future<Commune?> update(Commune commune) async {
    final communeRequest = await HttpUtils.putRequest('$uriEndpoint', commune);
    return JsonMapper.deserialize<Commune>(communeRequest.body);
  }

  Future<void> delete(int id) async {
    final communeRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
