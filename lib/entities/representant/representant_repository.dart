import 'package:sunufoncier/entities/representant/representant_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class RepresentantRepository {
    RepresentantRepository();

  static final String uriEndpoint = '/representants';

  Future<List<Representant>?> getAllRepresentants() async {
    final allRepresentantsRequest = await HttpUtils.getRequest(uriEndpoint);
    return JsonMapper.deserialize<List<Representant>>(allRepresentantsRequest.body);
  }

  Future<Representant?> getRepresentant(int? id) async {
    final representantRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return JsonMapper.deserialize<Representant>(representantRequest.body);
  }

  Future<Representant?> create(Representant representant) async {
    final representantRequest = await HttpUtils.postRequest('$uriEndpoint', representant);
    return JsonMapper.deserialize<Representant>(representantRequest.body);
  }

  Future<Representant?> update(Representant representant) async {
    final representantRequest = await HttpUtils.putRequest('$uriEndpoint', representant);
    return JsonMapper.deserialize<Representant>(representantRequest.body);
  }

  Future<void> delete(int id) async {
    final representantRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
