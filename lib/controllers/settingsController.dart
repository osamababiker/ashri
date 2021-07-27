import 'package:dio/dio.dart' as Dio;
import 'package:ashri/models/Setting.dart';
import 'package:ashri/utils/dio.dart';



Future<Setting> fetchSetting() async {
  try{ 
    Dio.Response response = await dio().get('/settings');
    if (response.statusCode == 200) {
      
      return Setting.fromJson(response.data['data']); 
    } else {
      throw Exception('Failed to load');
    }
  } catch(ex){
    throw Exception(ex);
  }
}


