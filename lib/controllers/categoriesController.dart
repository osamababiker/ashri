import 'package:dio/dio.dart' as Dio;
import 'package:ashri/models/Category.dart';
import 'package:ashri/utils/dio.dart';


List<Category> parseCategories(List responseBody) {
  return responseBody.map<Category>((json) => Category.fromJson(json)).toList();
}

Future<List<Category>> fetchCategories() async {
  Dio.Response response = await dio().get('/categories');
  if (response.statusCode == 200) {
    return parseCategories(response.data['data']); 
  } else {
    throw Exception('Failed to load');
  }
}

Future<List<Category>> fetchSubCategories({required int categoryId}) async {
  Dio.Response response = await dio().get('/categories/getSub/$categoryId');
  if (response.statusCode == 200) {
    return parseCategories(response.data['data']); 
  } else {
    throw Exception('Failed to load');
  }
}


