import 'package:sunufoncier/entities/dossier/dossier_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class DossierRepository {
    DossierRepository();

  static final String uriEndpoint = '/dossiers';

  Future<List<Dossier>?> getAllDossiers() async {
    final allDossiersRequest = await HttpUtils.getRequest(uriEndpoint);
    return JsonMapper.deserialize<List<Dossier>>(allDossiersRequest.body);
  }

  Future<Dossier?> getDossier(int? id) async {
    final dossierRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return JsonMapper.deserialize<Dossier>(dossierRequest.body);
  }

  Future<Dossier?> create(Dossier dossier) async {
    final dossierRequest = await HttpUtils.postRequest('$uriEndpoint', dossier);
    return JsonMapper.deserialize<Dossier>(dossierRequest.body);
  }

  Future<Dossier?> update(Dossier dossier) async {
    final dossierRequest = await HttpUtils.putRequest('$uriEndpoint', dossier);
    return JsonMapper.deserialize<Dossier>(dossierRequest.body);
  }

  Future<void> delete(int id) async {
    final dossierRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
