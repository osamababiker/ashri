import 'package:flutter/material.dart';

import '../../../constants.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key, required this.label, required this.info,
  }) : super(key: key);

  final String label, info;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 18,
          fontFamily: kFontFamily,
          color: kTextColor
        ),
        children: [
          TextSpan(
            text: "$label : \n"
          ),
          TextSpan(
            text: "$info"
          )
        ]
      )
    );
  }
}