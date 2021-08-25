import 'package:sunufoncier/entities/ref_parcelaire/ref_parcelaire_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class RefParcelaireRepository {
    RefParcelaireRepository();

  static final String uriEndpoint = '/ref-parcelaires';

  Future<List<RefParcelaire>?> getAllRefParcelaires() async {
    final allRefParcelairesRequest = await HttpUtils.getRequest(uriEndpoint);
    return JsonMapper.deserialize<List<RefParcelaire>>(allRefParcelairesRequest.body);
  }

  Future<RefParcelaire?> getRefParcelaire(int? id) async {
    final refParcelaireRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return JsonMapper.deserialize<RefParcelaire>(refParcelaireRequest.body);
  }

  Future<RefParcelaire?> create(RefParcelaire refParcelaire) async {
    final refParcelaireRequest = await HttpUtils.postRequest('$uriEndpoint', refParcelaire);
    return JsonMapper.deserialize<RefParcelaire>(refParcelaireRequest.body);
  }

  Future<RefParcelaire?> update(RefParcelaire refParcelaire) async {
    final refParcelaireRequest = await HttpUtils.putRequest('$uriEndpoint', refParcelaire);
    return JsonMapper.deserialize<RefParcelaire>(refParcelaireRequest.body);
  }

  Future<void> delete(int id) async {
    final refParcelaireRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
