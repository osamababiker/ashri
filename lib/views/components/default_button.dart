import 'package:flutter/material.dart';
import 'package:ashri/constants.dart';

import '../../size_config.dart';


class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key, 
    required this.text, 
    required this.press, 
  }) : super(key: key);
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: getScreenSize(context) * 5.6,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(5)
      ),
      child: TextButton(
        onPressed: press, 
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: kFontFamily
          ),
        ),
      ),
    );
  }
}

