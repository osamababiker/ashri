import 'package:ashri/controllers/settingsController.dart';
import 'package:ashri/models/Setting.dart';
import 'package:flutter/material.dart';
import 'package:ashri/views/components/custom_bottom_nav_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';
import '../../constants.dart';
import '../../enums.dart';
 

class PolicyScreen extends StatelessWidget {
  static String routeName = "/policy";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Padding(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            child: SvgPicture.asset("assets/icons/arrow_right.svg", color: Colors.white)
          ),
          onPressed: () {Navigator.pop(context);},
        ),
        title: Text(
          "${LocaleKeys.policy_screen_title.tr()}",  
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          )
        ),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.settings),
    );
  }
}


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<Setting>(
      future: fetchSetting(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${LocaleKeys.policy_screen_title.tr()}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: kFontFamily
                      ),
                    ),
                    SizedBox(height: kDefaultPadding / 2),
                    Text(
                      "${context.locale}" == 'ar' ?  "${snapshot.data!.policy}" 
                      : "${snapshot.data!.policyEn}",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: kFontFamily
                      ),
                    )
                  ]
                ),
              ),
            )
          );
        }else {
          if(snapshot.hasError){
            return Padding(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: Center(
                child: Text(
                  "${LocaleKeys.no_internet_meg1.tr()}, ${LocaleKeys.no_internet_meg2.tr()}",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 12
                  )
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            child: Center(child: CircularProgressIndicator())
          );
        }
      }
    );
  }
}