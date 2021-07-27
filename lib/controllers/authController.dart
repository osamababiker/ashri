import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:ashri/models/User.dart';
import 'package:ashri/utils/dio.dart'; 

class Auth extends ChangeNotifier{
  
  bool _isLoggedIn = false;
  late User _user;
  late String _token;
  final storage = new FlutterSecureStorage();

  bool get authenticated => _isLoggedIn;
  User get user => _user; 


  Future<bool> login({required Map creds}) async{
    try{
      Dio.Response response = await dio().post('/sanctum/token', data: creds);
      String token = response.data.toString();
      if(response.statusCode == 401){
        return false; 
      }
      await this.tryToken(token: token);
      return true;
    } catch(ex){
      print(ex);
      return false;
    }
  }

  Future<Map> register({required Map fields}) async{ 
    Map apiResult = {};
    try{
      Dio.Response response = await dio().post('/register', data: fields);
      if(response.data['errors'] == ''){
        apiResult = {
          'errors': false,
          'message': '',
          'data': response.data['user']
        }; 
      } else {
        if(response.data['errors']['email'] != null){
          apiResult = {
            'errors': true,
            'message': response.data['errors']['email'][0],
            'data': ''
          };
        }
        else if(response.data['errors']['phone'] != null){
          apiResult = {
            'errors': true,
            'message': response.data['errors']['phone'][0],
            'data': ''
          };
        }
      }      
      return apiResult;
    } catch(ex){
      throw Exception(ex);
    }
  }

  Future<bool> phoneOtpVerification({required Map data}) async {
    try{
      Dio.Response response = await dio().post(
        '/otp/verify', 
        data: data,
      );
      if(response.statusCode == 200){
        String token = response.data['token'].toString();
        await this.tryToken(token: token);
        return true;
      }   
      return false;
    } catch(ex){
      print(ex);
      return false;
    }
  }

  Future<bool> reSendOtp({required Map data}) async {
    try{
      Dio.Response response = await dio().post(
        '/otp/resend', 
        data: data,
      );
      if(response.statusCode == 200){
        return true;
      }   
      return false;
    } catch(ex){
      print(ex);
      return false;
    }
  }


  Future<bool> update({required Map data}) async {
    try{
      String token = await storage.read(key: 'token') as String;
      Dio.Response response = await dio().post(
        '/user/update', 
        data: data,
        options: Dio.Options(headers: {'Authorization': 'Bearer $token'})
      );
      if(response.statusCode == 200){
        this._user = User.fromJson(response.data['user']);
        notifyListeners();
        return true;
      }   
      return false;
    } catch(ex){
      print(ex);
      return false;
    }
  }

  Future<bool> changePassword({required Map data}) async {
    try{
      String token = await storage.read(key: 'token') as String;
      Dio.Response response = await dio().post(
        '/user/changePassword', 
        data: data,
        options: Dio.Options(headers: {'Authorization': 'Bearer $token'})
      );
      if(response.statusCode == 200){
        this._user = User.fromJson(response.data['user']);
        notifyListeners();
        return true;
      }   
      return false;
    } catch(ex){
      print(ex);
      return false;
    }
  }

  Future<void> tryToken({required String token}) async{
    try{
      Dio.Response response = await dio().get(
        '/user', 
        options: Dio.Options(headers: {'Authorization': 'Bearer $token'})
      );
      this._token = token;
      this._isLoggedIn = true;
      this._user = User.fromJson(response.data); 
      await this.storeToken(token: token);
      notifyListeners();
    } catch(ex){  
      print(ex);
    }
  }

  Future<void> storeToken({required String token}) async{
    await  this.storage.write(key: 'token', value: token);
  }
 
  Future<String> readToken() async {
    String token = await storage.read(key: 'token') as String;
    return token;
  }

  Future<void> logout() async{
    try{
      Dio.Response response = await dio().get(
        '/user/revoke',
        options: Dio.Options(headers: {'Authorization': 'Bearer $_token'})
      );
      cleanToken();
      notifyListeners();
    } on Dio.DioError catch(ex){
      print(ex);
    }
  }

  void cleanToken() async {
    this._isLoggedIn = false;
    this._token = '';
    await storage.delete(key: 'token');
  }

}