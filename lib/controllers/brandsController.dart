import 'package:dio/dio.dart' as Dio;
import 'package:ashri/models/Brands.dart';
import 'package:ashri/utils/dio.dart';


List<Brands> parseBrands(List responseBody) {
  return responseBody.map<Brands>((json) => Brands.fromJson(json)).toList();
}

Future<List<Brands>> fetchBrands() async { 
  Dio.Response response = await dio().get('/brands');
  if (response.statusCode == 200) {
    return parseBrands(response.data['data']); 
  } else {
    throw Exception('Failed to load');
  }
}


