import 'package:sunufoncier/entities/usage/usage_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class UsageRepository {
    UsageRepository();

  static final String uriEndpoint = '/usages';

  Future<List<Usage>?> getAllUsages() async {
    final allUsagesRequest = await HttpUtils.getRequest(uriEndpoint);
    return JsonMapper.deserialize<List<Usage>>(allUsagesRequest.body);
  }

  Future<Usage?> getUsage(int? id) async {
    final usageRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return JsonMapper.deserialize<Usage>(usageRequest.body);
  }

  Future<Usage?> create(Usage usage) async {
    final usageRequest = await HttpUtils.postRequest('$uriEndpoint', usage);
    return JsonMapper.deserialize<Usage>(usageRequest.body);
  }

  Future<Usage?> update(Usage usage) async {
    final usageRequest = await HttpUtils.putRequest('$uriEndpoint', usage);
    return JsonMapper.deserialize<Usage>(usageRequest.body);
  }

  Future<void> delete(int id) async {
    final usageRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
