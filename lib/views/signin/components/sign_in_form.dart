import 'dart:io';
import 'package:ashri/views/otp/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:ashri/controllers/authController.dart';
import 'package:provider/provider.dart';
import 'package:device_info/device_info.dart';
import 'package:ashri/views/components/custom_suffix_icon.dart';
import 'package:ashri/views/components/default_button.dart';
import 'package:ashri/views/components/form_error.dart';
import 'package:ashri/translations/local_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../constants.dart'; 



class SignInform extends StatefulWidget {
  @override
  _SignInformState createState() => _SignInformState();
}

class _SignInformState extends State<SignInform> {
  final _formKey = GlobalKey<FormState>(); 
  TextEditingController _phoneController = TextEditingController(); 
  TextEditingController _passwordController = TextEditingController();
  // device info
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  late String _deviceName;
  final List<String> errors = []; 

  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    getDeviceName();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void getDeviceName() async {
    try{
      if(Platform.isAndroid){
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        _deviceName = androidInfo.model;
      } else if(Platform.isIOS){
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        _deviceName = iosInfo.utsname.machine;
      }
    } catch(e){
      print(e);
    }
  }

  void addError({required String error}){
    if(!errors.contains(error)){
      setState(() {
        errors.add("$error");
      });
    }
  }

  void removeError({required String error}){
    if(errors.contains(error)){
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPhoneFormField(),
          SizedBox(height: 30),
          buildPasswordFormField(),
          SizedBox(height: 15),
          FormError(errors: errors),
          SizedBox(height: 15),
          !isPressed ? 
            DefaultButton(
              text: "${LocaleKeys.sign_in_screen_head.tr()}",
              press: () async{
                Map creds = { 
                  'phone': _phoneController.text,
                  'password': _passwordController.text,
                  'device_name': _deviceName
                };
                if(_formKey.currentState!.validate()){
                  errors.clear();
                  setState(() { 
                    isPressed = true;
                  });
                  var provider = Provider.of<Auth>(context, listen: false); 
                  await provider.login(creds: creds);
                  if(provider.authenticated){
                    if(provider.user.isVerify == 1){
                      Navigator.pop(context); 
                    } else{
                      Map data = {
                        'userId': provider.user.id
                      };
                      await provider.reSendOtp(data: data);
                      Navigator.pushReplacementNamed(
                        context, OtpScreen.routeName,
                        arguments: provider.user
                      );
                    }
                  } else {
                    addError(error: "${LocaleKeys.sign_in_screen_login_error.tr()}");
                    setState(() {
                      isPressed = false;
                    });
                    _passwordController.text = '';
                  }
                } 
              }
            )
          :
          Center(child: CircularProgressIndicator()) 
        ],
      ),
    );
  }



  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: _passwordController,
      onChanged: (value){
        if(value.isNotEmpty){
          removeError(error: kPassNullError);
        }else if(value.length >= 8){
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value){
        if(value!.isEmpty){
          addError(error: kPassNullError);
          return "";
        }else if(value.length < 8){
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${LocaleKeys.sign_in_screen_password_lable.tr()}",
        hintText: "${LocaleKeys.sign_in_screen_password_hint.tr()}",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg",),
        
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: _phoneController,
      onChanged: (value){
        if(value.isNotEmpty){
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value){
        if(value!.isEmpty){
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${LocaleKeys.sign_in_screen_phone_lable.tr()}",
        hintText: "${LocaleKeys.sign_in_screen_phone_hint.tr()}",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Phone.svg",),
        
      ),
    );
  }




}