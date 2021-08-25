import 'package:sunufoncier/entities/arrondissement/arrondissement_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class ArrondissementRepository {
    ArrondissementRepository();

  static final String uriEndpoint = '/arrondissements';

  Future<List<Arrondissement>?> getAllArrondissements() async {
    final allArrondissementsRequest = await HttpUtils.getRequest(uriEndpoint);
    return JsonMapper.deserialize<List<Arrondissement>>(allArrondissementsRequest.body);
  }

  Future<Arrondissement?> getArrondissement(int? id) async {
    final arrondissementRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return JsonMapper.deserialize<Arrondissement>(arrondissementRequest.body);
  }

  Future<Arrondissement?> create(Arrondissement arrondissement) async {
    final arrondissementRequest = await HttpUtils.postRequest('$uriEndpoint', arrondissement);
    return JsonMapper.deserialize<Arrondissement>(arrondissementRequest.body);
  }

  Future<Arrondissement?> update(Arrondissement arrondissement) async {
    final arrondissementRequest = await HttpUtils.putRequest('$uriEndpoint', arrondissement);
    return JsonMapper.deserialize<Arrondissement>(arrondissementRequest.body);
  }

  Future<void> delete(int id) async {
    final arrondissementRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
