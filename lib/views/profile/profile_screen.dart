import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ashri/views/components/custom_bottom_nav_bar.dart';
import 'components/body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';

import '../../../constants.dart';
import '../../enums.dart';
 

class ProfileScreen extends StatelessWidget {
  static String routeName = 'profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${LocaleKeys.profile_screen_title.tr()}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          ),
        ),
        leading: IconButton(
          icon: Padding(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            child: SvgPicture.asset("assets/icons/arrow_right.svg", color: Colors.white)
          ),
          onPressed: () {Navigator.pop(context);},
        ),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}

