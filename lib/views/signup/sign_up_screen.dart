import 'package:ashri/views/components/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/body.dart';
import 'package:ashri/translations/local_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../constants.dart';
import '../../enums.dart';


class SignUpScreen extends StatelessWidget {
  static String routeName = '/signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading:IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Padding(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              child: SvgPicture.asset("assets/icons/arrow_right.svg", color: Colors.white)
            )
          ),
          title: Text(
            "${LocaleKeys.sign_up_screen_title.tr()}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16
            ),
          )
        ),
        body: Body(),
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.signup),
    );
  }
}