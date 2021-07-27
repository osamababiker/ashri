import 'package:ashri/models/User.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';  
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';


class OtpScreen extends StatelessWidget {
  static String routeName = '/otp';
  @override
  Widget build(BuildContext context) {
    final User arguments = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "${LocaleKeys.otp_screen_title.tr()}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          ),
        ),
      ),
      body: Body(user: arguments),
    );
  }
}