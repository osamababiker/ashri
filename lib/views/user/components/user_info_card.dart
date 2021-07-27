import 'package:ashri/views/user/components/password_form.dart';
import 'package:ashri/views/user/components/user_info_form.dart';
import 'package:flutter/material.dart';
import 'package:ashri/models/User.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ashri/translations/local_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../constants.dart';

class UserInfoCard extends StatelessWidget {
 
  final User user;

  const UserInfoCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${LocaleKeys.user_screen_head.tr()}",
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 16
                    ),
                  ),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryLightColor),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context, UserInfoForm.routeName, 
                          arguments: user
                        );
                      },
                      child: Text(
                        "${LocaleKeys.user_screen_editBtn.tr()}",
                        style: TextStyle(
                          fontSize: 10,
                          color: kPrimaryLightColor
                        )
                      )
                    ),
                  ),
                ],
              ),
              SizedBox(height: kDefaultPadding / 2),
              Divider(color: kTextColor.withOpacity(0.5),height: kDefaultPadding),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset("assets/icons/User.svg"),
                  ),
                  SizedBox(width: kDefaultPadding / 4),
                  Text(
                    user.name,
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 14
                    ),
                  ),
                ],
              ),
              Divider(color: kTextColor.withOpacity(0.5),height: kDefaultPadding),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset("assets/icons/Phone.svg"),
                  ),
                  SizedBox(width: kDefaultPadding / 4),
                  Text(
                    user.phone,
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 14
                    ),
                  ),
                ],
              ),
              Divider(color: kTextColor.withOpacity(0.5),height: kDefaultPadding),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset("assets/icons/Mail.svg"),
                  ),
                  SizedBox(width: kDefaultPadding / 4),
                  Text(
                    user.email,
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 14
                    ),
                  ),
                ],
              ),
              Divider(color: kTextColor.withOpacity(0.5),height: kDefaultPadding),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset("assets/icons/Location_point.svg"),
                  ),
                  SizedBox(width: kDefaultPadding / 4),
                  Text(
                    user.address,
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 14
                    ),
                  ),
                ],
              ),
              Divider(color: kTextColor.withOpacity(0.5),height: kDefaultPadding),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset("assets/icons/Lock.svg"),
                  ),
                  SizedBox(width: kDefaultPadding / 4),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryLightColor),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, PasswordForm.routeName);
                      },
                      child: Text(
                        "${LocaleKeys.user_screen_editPasswordBtn.tr()}",
                        style: TextStyle(
                          fontSize: 12,
                          color: kPrimaryLightColor
                        )
                      )
                    ),
                  )
                ],
              ),
            ],    
          )
        ),
      ),
    );
  }
}


