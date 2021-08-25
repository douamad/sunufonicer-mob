import 'package:sunufoncier/entities/categorie_batie/categorie_batie_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class CategorieBatieRepository {
    CategorieBatieRepository();

  static final String uriEndpoint = '/categorie-baties';

  Future<List<CategorieBatie>?> getAllCategorieBaties() async {
    final allCategorieBatiesRequest = await HttpUtils.getRequest(uriEndpoint);
    return JsonMapper.deserialize<List<CategorieBatie>>(allCategorieBatiesRequest.body);
  }

  Future<CategorieBatie?> getCategorieBatie(int? id) async {
    final categorieBatieRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return JsonMapper.deserialize<CategorieBatie>(categorieBatieRequest.body);
  }

  Future<CategorieBatie?> create(CategorieBatie categorieBatie) async {
    final categorieBatieRequest = await HttpUtils.postRequest('$uriEndpoint', categorieBatie);
    return JsonMapper.deserialize<CategorieBatie>(categorieBatieRequest.body);
  }

  Future<CategorieBatie?> update(CategorieBatie categorieBatie) async {
    final categorieBatieRequest = await HttpUtils.putRequest('$uriEndpoint', categorieBatie);
    return JsonMapper.deserialize<CategorieBatie>(categorieBatieRequest.body);
  }

  Future<void> delete(int id) async {
    final categorieBatieRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
