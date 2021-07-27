import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';

import '../../../constants.dart';


AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "${LocaleKeys.cart_screen_title.tr()}",
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
    );
  }