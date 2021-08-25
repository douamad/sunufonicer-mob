import 'package:sunufoncier/entities/lotissement/lotissement_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class LotissementRepository {
    LotissementRepository();

  static final String uriEndpoint = '/lotissements';

  Future<List<Lotissement>?> getAllLotissements() async {
    final allLotissementsRequest = await HttpUtils.getRequest(uriEndpoint);
    return JsonMapper.deserialize<List<Lotissement>>(allLotissementsRequest.body);
  }

  Future<Lotissement?> getLotissement(int? id) async {
    final lotissementRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return JsonMapper.deserialize<Lotissement>(lotissementRequest.body);
  }

  Future<Lotissement?> create(Lotissement lotissement) async {
    final lotissementRequest = await HttpUtils.postRequest('$uriEndpoint', lotissement);
    return JsonMapper.deserialize<Lotissement>(lotissementRequest.body);
  }

  Future<Lotissement?> update(Lotissement lotissement) async {
    final lotissementRequest = await HttpUtils.putRequest('$uriEndpoint', lotissement);
    return JsonMapper.deserialize<Lotissement>(lotissementRequest.body);
  }

  Future<void> delete(int id) async {
    final lotissementRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
