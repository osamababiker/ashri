import 'package:flutter/material.dart';
import 'package:ashri/constants.dart';
import 'package:ashri/size_config.dart';
import 'package:ashri/views/signup/sign_up_screen.dart';
import 'sign_in_form.dart';
import 'package:ashri/translations/local_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding, horizontal: kDefaultPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getScreenSize(context) * 8.0),
              Text(
                "${LocaleKeys.sign_in_screen_head.tr()}",
                style: TextStyle( 
                  color: kPrimaryColor,
                  fontSize: 24
                ) 
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, SignUpScreen.routeName);
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${LocaleKeys.sign_in_screen_sub_head.tr()}",
                        style: TextStyle(
                          fontFamily: kFontFamily,
                          color: kTextColor
                        )
                      ),
                      TextSpan(
                        text: "${LocaleKeys.sign_in_screen_create_account_btn.tr()}",
                        style: TextStyle(
                          fontFamily: kFontFamily,
                          color: kPrimaryColor,
                          fontSize: 16
                        )
                      )
                    ]
                  )
                ),
              ),
              SizedBox(height: size.height * 0.07), 
              SignInform(),
            ],
          ),
        ),
      ),
    );
  }
}