import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ashri/views/components/custom_bottom_nav_bar.dart';
import '../../enums.dart';
import '../../constants.dart';
import 'components/body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = "/settings";
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
          LocaleKeys.settings_screen_title.tr(),
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