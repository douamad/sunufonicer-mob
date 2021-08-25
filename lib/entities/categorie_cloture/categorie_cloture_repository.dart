import 'package:sunufoncier/entities/categorie_cloture/categorie_cloture_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class CategorieClotureRepository {
    CategorieClotureRepository();

  static final String uriEndpoint = '/categorie-clotures';

  Future<List<CategorieCloture>?> getAllCategorieClotures() async {
    final allCategorieCloturesRequest = await HttpUtils.getRequest(uriEndpoint);
    return JsonMapper.deserialize<List<CategorieCloture>>(allCategorieCloturesRequest.body);
  }

  Future<CategorieCloture?> getCategorieCloture(int? id) async {
    final categorieClotureRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return JsonMapper.deserialize<CategorieCloture>(categorieClotureRequest.body);
  }

  Future<CategorieCloture?> create(CategorieCloture categorieCloture) async {
    final categorieClotureRequest = await HttpUtils.postRequest('$uriEndpoint', categorieCloture);
    return JsonMapper.deserialize<CategorieCloture>(categorieClotureRequest.body);
  }

  Future<CategorieCloture?> update(CategorieCloture categorieCloture) async {
    final categorieClotureRequest = await HttpUtils.putRequest('$uriEndpoint', categorieCloture);
    return JsonMapper.deserialize<CategorieCloture>(categorieClotureRequest.body);
  }

  Future<void> delete(int id) async {
    final categorieClotureRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
