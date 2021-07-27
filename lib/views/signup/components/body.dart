import 'package:flutter/material.dart';
import 'package:ashri/constants.dart';
import 'sign_up_form.dart';
import 'package:ashri/translations/local_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding, horizontal: kDefaultPadding / 2),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.02),
              Text(
                "${LocaleKeys.sign_up_screen_head.tr()}",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 24
                ) 
              ),
              Text(
                "${LocaleKeys.sign_up_screen_sub_head.tr()}",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.07), // 7% of total hight
              SignUpform(),
            ],
          ),
        ),
      ),
    );
  }
}