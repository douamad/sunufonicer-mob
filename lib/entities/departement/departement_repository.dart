import 'package:sunufoncier/entities/departement/departement_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class DepartementRepository {
    DepartementRepository();

  static final String uriEndpoint = '/departements';

  Future<List<Departement>?> getAllDepartements() async {
    final allDepartementsRequest = await HttpUtils.getRequest(uriEndpoint);
    return JsonMapper.deserialize<List<Departement>>(allDepartementsRequest.body);
  }

  Future<Departement?> getDepartement(int? id) async {
    final departementRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return JsonMapper.deserialize<Departement>(departementRequest.body);
  }

  Future<Departement?> create(Departement departement) async {
    final departementRequest = await HttpUtils.postRequest('$uriEndpoint', departement);
    return JsonMapper.deserialize<Departement>(departementRequest.body);
  }

  Future<Departement?> update(Departement departement) async {
    final departementRequest = await HttpUtils.putRequest('$uriEndpoint', departement);
    return JsonMapper.deserialize<Departement>(departementRequest.body);
  }

  Future<void> delete(int id) async {
    final departementRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
