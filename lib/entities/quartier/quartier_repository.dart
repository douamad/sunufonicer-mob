import 'package:sunufoncier/entities/quartier/quartier_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class QuartierRepository {
    QuartierRepository();

  static final String uriEndpoint = '/quartiers';

  Future<List<Quartier>?> getAllQuartiers() async {
    final allQuartiersRequest = await HttpUtils.getRequest(uriEndpoint);
    return JsonMapper.deserialize<List<Quartier>>(allQuartiersRequest.body);
  }

  Future<Quartier?> getQuartier(int? id) async {
    final quartierRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return JsonMapper.deserialize<Quartier>(quartierRequest.body);
  }

  Future<Quartier?> create(Quartier quartier) async {
    final quartierRequest = await HttpUtils.postRequest('$uriEndpoint', quartier);
    return JsonMapper.deserialize<Quartier>(quartierRequest.body);
  }

  Future<Quartier?> update(Quartier quartier) async {
    final quartierRequest = await HttpUtils.putRequest('$uriEndpoint', quartier);
    return JsonMapper.deserialize<Quartier>(quartierRequest.body);
  }

  Future<void> delete(int id) async {
    final quartierRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
