import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';



class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({
    Key? key, 
    required this.title, 
    required this.press,
  }) : super(key: key);

  final String title; 
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        width: size.width,
        height: getScreenSize(context) * 8.0,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )
              ),
              Container(
                width: getScreenSize(context) * 10.0,
                height: getScreenSize(context) * 4.3,
                decoration: BoxDecoration(
                  border: Border.all(color: kPrimaryLightColor),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: TextButton(
                  onPressed: press,
                  child: Text(
                    "${LocaleKeys.home_screen_more_btn.tr()}",
                    style: TextStyle(
                      fontSize: 10,
                      color: kPrimaryLightColor
                    )
                  )
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}
