import 'package:sunufoncier/entities/refcadastrale/refcadastrale_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class RefcadastraleRepository {
    RefcadastraleRepository();

  static final String uriEndpoint = '/refcadastrales';

  Future<List<Refcadastrale>?> getAllRefcadastrales() async {
    final allRefcadastralesRequest = await HttpUtils.getRequest(uriEndpoint);
    return JsonMapper.deserialize<List<Refcadastrale>>(allRefcadastralesRequest.body);
  }

  Future<Refcadastrale?> getRefcadastrale(int? id) async {
    final refcadastraleRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return JsonMapper.deserialize<Refcadastrale>(refcadastraleRequest.body);
  }

  Future<Refcadastrale?> create(Refcadastrale refcadastrale) async {
    final refcadastraleRequest = await HttpUtils.postRequest('$uriEndpoint', refcadastrale);
    return JsonMapper.deserialize<Refcadastrale>(refcadastraleRequest.body);
  }

  Future<Refcadastrale?> update(Refcadastrale refcadastrale) async {
    final refcadastraleRequest = await HttpUtils.putRequest('$uriEndpoint', refcadastrale);
    return JsonMapper.deserialize<Refcadastrale>(refcadastraleRequest.body);
  }

  Future<void> delete(int id) async {
    final refcadastraleRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
