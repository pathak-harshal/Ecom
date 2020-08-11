import 'package:Ecom/data/model/api_result_model.dart';
import 'package:Ecom/res/strings/strings.dart';
import 'package:http/http.dart' as http;

abstract class DataRepository {
  Future<ApiResultModel> getAllData();
}

class DataRepositoryImpl implements DataRepository {
  @override
  Future<ApiResultModel> getAllData() async {
    var response = await http.get(AppStrings.ecomDataUrl);
    if (response.statusCode == 200) {
      final apiResultModel = apiResultModelFromJson(response.body);
      return apiResultModel;
    } else {
      throw Exception();
    }
  }
}
