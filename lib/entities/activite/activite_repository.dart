import 'package:sunufoncier/entities/activite/activite_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class ActiviteRepository {
    ActiviteRepository();

  static final String uriEndpoint = '/activites';

  Future<List<Activite>?> getAllActivites() async {
    final allActivitesRequest = await HttpUtils.getRequest(uriEndpoint);
    return JsonMapper.deserialize<List<Activite>>(allActivitesRequest.body);
  }

  Future<Activite?> getActivite(int? id) async {
    final activiteRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return JsonMapper.deserialize<Activite>(activiteRequest.body);
  }

  Future<Activite?> create(Activite activite) async {
    final activiteRequest = await HttpUtils.postRequest('$uriEndpoint', activite);
    return JsonMapper.deserialize<Activite>(activiteRequest.body);
  }

  Future<Activite?> update(Activite activite) async {
    final activiteRequest = await HttpUtils.putRequest('$uriEndpoint', activite);
    return JsonMapper.deserialize<Activite>(activiteRequest.body);
  }

  Future<void> delete(int id) async {
    final activiteRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
