import 'dart:io';
import 'package:ashri/views/components/form_error.dart';
import 'package:ashri/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:ashri/models/User.dart';
import 'package:ashri/views/components/default_button.dart';
import 'package:provider/provider.dart';
import 'package:ashri/controllers/authController.dart';
import 'package:device_info/device_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';
import '../../../constants.dart';
import '../../../size_config.dart';


class OtpForm extends StatefulWidget {
  final User user;

  const OtpForm({Key? key, required this.user}) : super(key: key);
  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;
  TextEditingController node1 = TextEditingController();
  TextEditingController node2 = TextEditingController();
  TextEditingController node3 = TextEditingController();
  TextEditingController node4 = TextEditingController();
  final List<String> errors = [];
  // device info
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  late String deviceName;
  bool isPressed = false;


  @override
  void initState() {
    super.initState();
    getDeviceName();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    node1.dispose();
    node2.dispose();
    node3.dispose();
    node4.dispose();
    super.dispose();
  }

  void getDeviceName() async {
    try{
      if(Platform.isAndroid){
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceName = androidInfo.model;
      } else if(Platform.isIOS){
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceName = iosInfo.utsname.machine;
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

  void nextField({required String value , required FocusNode focusNode}) {
    if(value.length == 1){
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    var provider = Provider.of<Auth>(context, listen: false);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getScreenSize(context) * 6.0,
                child: TextFormField(
                  controller: node1,
                  autofocus: true,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) { 
                    // also you need to store your value
                    nextField(value: value , focusNode: pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getScreenSize(context) * 6.0,
                child: TextFormField(
                  controller: node2,
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextField(value: value , focusNode: pin3FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getScreenSize(context) * 6.0,
                child: TextFormField(
                  controller: node3,
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextField(value: value , focusNode: pin4FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getScreenSize(context) * 6.0,
                child: TextFormField(
                  controller: node4,
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    pin4FocusNode.unfocus();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          FormError(errors: errors),
          SizedBox(height: 15),
          !isPressed ?
          DefaultButton(
            text: "${LocaleKeys.otp_screen_confirm_btn.tr()}",
            press: () async{
              setState(() => isPressed = true);
              Map data = {
                'userId': widget.user.id,
                'verification_code': "${node1.text}${node2.text}${node3.text}${node4.text}",
                'device_name': deviceName
              };
              bool isVerify = await provider.phoneOtpVerification(data: data);
              if(isVerify){
                Navigator.of(context)
                .pushNamedAndRemoveUntil(HomeScreen.routeName, (Route<dynamic> route) => false);
              }else{
                addError(error: "${LocaleKeys.otp_screen_code_incorrect.tr()}");
                setState(() => isPressed = false);
              }
            }
          ): CircularProgressIndicator()
        ],
      ),
    );
  }
}