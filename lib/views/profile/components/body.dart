import 'package:ashri/views/settings/policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:ashri/constants.dart';
import 'package:ashri/controllers/settingsController.dart';
import 'package:ashri/models/Setting.dart';
import 'package:ashri/views/components/social_card.dart';
import 'package:ashri/views/settings/settings_screen.dart';
import 'package:ashri/controllers/authController.dart';
import 'package:ashri/views/favourite/favourite_screen.dart';
import 'package:ashri/views/home/home_screen.dart';
import 'package:ashri/views/orders/orders_screen.dart';
import 'package:ashri/views/user/user_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:ashri/utils/url_launcher.dart';
import 'package:ashri/size_config.dart';
import 'profile_menu.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var provider = context.watch<Auth>(); 
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
            child: Center(
              child: Text(
                "${LocaleKeys.profile_screen_welcome.tr()} ${provider.user.name}",
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            ),
          ), 
          SizedBox(height: getScreenSize(context) * 2.0),
          ProfileMenu(
            icon: "assets/icons/User_Icon.svg",
            text: "${LocaleKeys.profile_screen_profileTab.tr()}", 
            press: () {
              Navigator.pushNamed(context, UserDetailsScreen.routeName);
            }
          ),
          ProfileMenu(
            icon: "assets/icons/Cart_Icon.svg",
            text: "${LocaleKeys.profile_screen_ordersTab.tr()}",
            press: () {
              Navigator.pushNamed(context, OrdersScreen.routeName);
            },
          ),
          ProfileMenu(
            icon: "assets/icons/Heart_Icon.svg",
            text: "${LocaleKeys.profile_screen_favoriteTab.tr()}",
            press: () {
              Navigator.pushNamed(context, FavouriteScreen.routeName);
            },
          ),
          ProfileMenu(
            icon: "assets/icons/Settings.svg",
            text: "${LocaleKeys.profile_screen_settingsTab.tr()}",
            press: () {
              Navigator.pushNamed(context, SettingsScreen.routeName);
            },
          ),
          ProfileMenu(
            icon: "assets/icons/Log out.svg",
            text: "${LocaleKeys.profile_screen_logoutTab.tr()}",
            press: () async{
              await Provider.of<Auth>(context, listen: false).logout(); 
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PolicyScreen.routeName);
                },
                child: Text(
                  "${LocaleKeys.profile_screen_policyTab.tr()}",
                  style: TextStyle(
                    color: kPrimaryLightColor,
                    fontSize: 16
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: FutureBuilder<Setting>(
              future: fetchSetting(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Padding(
                    padding: const EdgeInsets.all(kDefaultPadding / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialCard(
                          icon: "assets/icons/facebook.svg",
                          press: () async{
                            var launcher = new UrlLauncher();
                            await launcher.urlLauncher(snapshot.data!.fbUrl);
                          },
                        ),
                        SocialCard(
                          icon: "assets/icons/twitter.svg",
                          press: () async{
                            var launcher = new UrlLauncher();
                            await launcher.urlLauncher(snapshot.data!.twUrl);
                          }
                        ),
                        SocialCard(
                          icon: "assets/icons/instagram.svg",
                          press: () async{
                            var launcher = new UrlLauncher();
                            await launcher.urlLauncher(snapshot.data!.instUrl);
                          }
                        ),
                      ]
                    ),
                  );
                } else {
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
            ),
          ),
        ],
      ),
    );
  }
}




