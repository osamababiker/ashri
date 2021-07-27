import 'package:dio/dio.dart' as Dio;
import 'package:ashri/models/Slides.dart';
import 'package:ashri/utils/dio.dart';


List<Slides> parseSlides(List responseBody) {
  return responseBody.map<Slides>((json) => Slides.fromJson(json)).toList();
}

Future<List<Slides>> fetchSlides() async { 
  Dio.Response response = await dio().get('/slides');
  if (response.statusCode == 200) {
    return parseSlides(response.data['data']);  
  } else {
    throw Exception('Failed to load');
  }
}


