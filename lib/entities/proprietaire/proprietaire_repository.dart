import 'package:sunufoncier/entities/proprietaire/proprietaire_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class ProprietaireRepository {
    ProprietaireRepository();

  static final String uriEndpoint = '/proprietaires';

  Future<List<Proprietaire>?> getAllProprietaires() async {
    final allProprietairesRequest = await HttpUtils.getRequest(uriEndpoint);
    return JsonMapper.deserialize<List<Proprietaire>>(allProprietairesRequest.body);
  }

  Future<Proprietaire?> getProprietaire(int? id) async {
    final proprietaireRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return JsonMapper.deserialize<Proprietaire>(proprietaireRequest.body);
  }

  Future<Proprietaire?> create(Proprietaire proprietaire) async {
    final proprietaireRequest = await HttpUtils.postRequest('$uriEndpoint', proprietaire);
    return JsonMapper.deserialize<Proprietaire>(proprietaireRequest.body);
  }

  Future<Proprietaire?> update(Proprietaire proprietaire) async {
    final proprietaireRequest = await HttpUtils.putRequest('$uriEndpoint', proprietaire);
    return JsonMapper.deserialize<Proprietaire>(proprietaireRequest.body);
  }

  Future<void> delete(int id) async {
    final proprietaireRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
