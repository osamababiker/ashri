import 'package:dio/dio.dart' as Dio;
import 'package:ashri/models/Offer.dart';
import 'package:ashri/utils/dio.dart';


List<Offer> parseOffers(List responseBody) {
  return responseBody.map<Offer>((json) => Offer.fromJson(json)).toList();
}

Future<List<Offer>> fetchOffers() async { 
  try{
    Dio.Response response = await dio().get('/offers/limit');
    if (response.statusCode == 200) {
      return parseOffers(response.data['data']); 
    } else {
      throw Exception('Failed to load');
    }
  } catch(ex){
    print(ex);
    throw Exception(ex);
  }
}

Future<List<Offer>> fetchAllOffers() async { 
  Dio.Response response = await dio().get('/offers');
  if (response.statusCode == 200) {
    return parseOffers(response.data['data']); 
  } else {
    throw Exception('Failed to load');
  }
}


