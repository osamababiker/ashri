import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ashri/views/components/custom_bottom_nav_bar.dart';
import 'components/body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';
import '../../enums.dart';
import '../../constants.dart';


class OffersScreen extends StatelessWidget {
  static String routeName = '/offers';
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
          "${LocaleKeys.offers_screen_title.tr()}",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white
          ),
        ),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}