import 'package:ashri/size_config.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';

import '../../constants.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";


  @override 
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center ( 
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.8,
                height: size.height * 0.5,
                padding: EdgeInsets.all(kDefaultPadding / 2),
                child: Image.asset("assets/images/logo.jpg"),
              ),
              SizedBox(height: 10),
              Text(
                "${LocaleKeys.slogan.tr()}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                )
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                child: Center(child: CircularProgressIndicator())
              ),
            ]
          ),
        ),
      )
    );
  }
}