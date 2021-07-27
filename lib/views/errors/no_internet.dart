import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';

import '../../constants.dart';
import '../../size_config.dart';


class NoInternetScreen extends StatelessWidget {
  static String routeName = "/no-internet";
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "${LocaleKeys.app_name.tr()}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                width: getScreenSize(context) * 40.0,
                height: getScreenSize(context) * 20.0,
                child: SvgPicture.asset("assets/icons/signal_searching.svg")
              ), 
              SizedBox(height: kDefaultPadding),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      "${LocaleKeys.no_internet_meg1.tr()}",
                      style: TextStyle(
                        fontSize: 14,
                        color: kTextColor
                      ),
                    ),
                    Text(
                      "${LocaleKeys.no_internet_meg2.tr()}",
                      style: TextStyle(
                        fontSize: 14,
                        color: kTextColor
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}


