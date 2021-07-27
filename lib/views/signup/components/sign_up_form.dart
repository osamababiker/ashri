import 'package:ashri/models/User.dart';
import 'package:ashri/views/otp/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:ashri/controllers/authController.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:ashri/views/components/custom_suffix_icon.dart';
import 'package:ashri/views/components/default_button.dart';
import 'package:ashri/views/components/form_error.dart';
import 'package:ashri/translations/local_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../constants.dart';


class SignUpform extends StatefulWidget {
  @override
  _SignUpformState createState() => _SignUpformState();
}

class _SignUpformState extends State<SignUpform> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirm_passwordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
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
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirm_passwordController.dispose();
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
          buildNameFormField(),
          SizedBox(height: 30),
          buildEmailFormField(),
          SizedBox(height: 30),
          buildPhoneFormField(),
          SizedBox(height: 30),
          buildAddressFormField(),
          SizedBox(height: 30),
          buildPasswordFormField(),
          SizedBox(height: 30),
          buildConfPasswordFormField(),
          SizedBox(height: 15),
          FormError(errors: errors),
          SizedBox(height: 15),
          !isPressed ? 
          DefaultButton(
            text: "${LocaleKeys.sign_up_screen_head.tr()}",
            press: () async{
              Map fields = {
                'name': _nameController.text,
                'email': _emailController.text,
                'password': _passwordController.text,
                'password_confirmation': _confirm_passwordController.text,
                'address': _addressController.text,
                'phone': _phoneController.text,
                'device_name': _deviceName
              };
              if(_formKey.currentState!.validate()){
                errors.clear();
                setState(() {
                  isPressed = true;
                });
                var provider = Provider.of<Auth>(context, listen: false);
                var apiResult = await provider.register(fields: fields);
                if(apiResult['data'] != ''){ 
                  Navigator.pushReplacementNamed(
                    context, OtpScreen.routeName,
                    arguments: User.fromJson(apiResult['data']) 
                  );
                } else {
                  addError(error: "${apiResult['message']}");
                  setState(() {
                    isPressed = false;
                  });
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

  TextFormField buildConfPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: _confirm_passwordController,
      onChanged: (value){
        if(_passwordController.text == value){
          removeError(error: kMatchPassError);
        }
        return null;
      },
      validator: (value){
        if(value!.isEmpty){
          return "";
        }else if(_passwordController.text != value){
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${LocaleKeys.sign_up_screen_confirm_password_lable.tr()}",
        hintText: "${LocaleKeys.sign_up_screen_confirm_password_hint.tr()}",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg",),
        floatingLabelBehavior: FloatingLabelBehavior.always,
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
        labelText: "${LocaleKeys.sign_up_screen_password_lable.tr()}",
        hintText: "${LocaleKeys.sign_up_screen_password_hint.tr()}",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg",),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      onChanged: (value){
        if(value.isNotEmpty){
          removeError(error: kEmailNullError);
        }else if(emailValidatorRegExp.hasMatch(value)){
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value){
        if(value!.isEmpty){
          addError(error: kEmailNullError);
          return "";
        }else if(!emailValidatorRegExp.hasMatch(value)){
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${LocaleKeys.sign_up_screen_email_lable.tr()}",
        hintText: "${LocaleKeys.sign_up_screen_email_hint.tr()}",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg",),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: _nameController,
      onChanged: (value){
        if(value.isNotEmpty){
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value){
        if(value!.isEmpty){
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${LocaleKeys.sign_up_screen_name_lable.tr()}",
        hintText: "${LocaleKeys.sign_up_screen_name_hint.tr()}",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg",),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      controller: _addressController,
      onChanged: (value){
        if(value.isNotEmpty){
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value){
        if(value!.isEmpty){
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${LocaleKeys.sign_up_screen_address_lable.tr()}",
        hintText: "${LocaleKeys.sign_up_screen_address_hint.tr()}",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Location_point.svg",),
        floatingLabelBehavior: FloatingLabelBehavior.always,
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
        labelText: "${LocaleKeys.sign_up_screen_phone_lable.tr()}",
        hintText: "${LocaleKeys.sign_up_screen_phone_hint.tr()}",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Phone.svg",),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

}