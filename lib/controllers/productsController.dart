import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ashri/models/Favorites.dart';
import 'package:ashri/models/Product.dart';
import 'package:ashri/utils/dio.dart';


final storage = new FlutterSecureStorage();


List<Product> parseProducts(List responseBody) {
  return responseBody.map<Product>((json) => Product.fromJson(json)).toList();
}

Future<List<Product>> fetchProducts({required String endPoint}) async {
  try{
    Dio.Response response = await dio().get(endPoint); 
    if (response.statusCode == 200) {
      return parseProducts(response.data['data']);
    } else {
      throw Exception('Failed to load');
    }
  } catch(ex) {
    print(ex);
    throw Exception(ex); 
  }
}

Future<List<Product>> filterProducts({required String endPoint, required Map data}) async {
  try{
    Dio.Response response = await dio().post(endPoint, data: data); 
    if (response.statusCode == 200) {
      return parseProducts(response.data['data']);
    } else {
      throw Exception('Failed to load');
    }
  } catch(ex) {
    print(ex);
    throw Exception(ex);
  }
}



Future<Product> fetchSingleProduct({required int productId}) async {
  Dio.Response response = await dio().get('/products/single/$productId'); 
  if (response.statusCode == 200) {
    return Product.fromJson(response.data['data']);
  } else {
    throw Exception('Failed to load');
  }
}



Future<List<Product>> searchProductsByName({required String endPoint, required String query}) async {
  try{
    Map data = {'name': query};
    Dio.Response response = await dio().post(endPoint, data: data);
    if (response.statusCode == 200) {
      return parseProducts(response.data['data']);
    } else {
      throw Exception('Failed to load');
    }
  } catch(ex){
    print(ex);
    throw Exception(ex);
  }
}


Future<bool> addToFavorites({required Map data}) async {
  String token = await storage.read(key: 'token') as String;
  Dio.Response response = await dio().post(
    '/favorites/add', 
    data: data,
    options: Dio.Options(headers: {'Authorization': 'Bearer $token'})
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to load');
  }
}


List<Favorites> parseFavorites(List responseBody) {
  return responseBody.map<Favorites>((json) => Favorites.fromJson(json)).toList();
}
Future<List<Favorites>> favoritesList({required int userId}) async {
  try{
    String token = await storage.read(key: 'token') as String;
    Dio.Response response = await dio().get(
      '/favorites/$userId', 
      options: Dio.Options(headers: {'Authorization': 'Bearer $token'})
    );
    if (response.statusCode == 200) {
      return parseFavorites(response.data['data']);
    } else {
      throw Exception('Failed to load');
    }
  } catch(ex){
    print(ex);
    throw Exception(ex);
  }
}

Future<bool> deleteFavorite({required int favoriteId}) async {
  String token = await storage.read(key: 'token') as String;
  Dio.Response response = await dio().get(
    '/favorites/delete/$favoriteId', 
    options: Dio.Options(headers: {'Authorization': 'Bearer $token'})
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to load');
  }
}

