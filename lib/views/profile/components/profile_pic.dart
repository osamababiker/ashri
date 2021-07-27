import 'package:flutter/material.dart';
import 'package:ashri/controllers/authController.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ashri/constants.dart';

import '../../../size_config.dart';


class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    var provider = context.watch<Auth>();  
    
    return SizedBox(
      height: getScreenSize(context) * 11.5,
      width: getScreenSize(context) * 11.5,
      child: Padding(
        padding: const EdgeInsets.only(top: kDefaultPadding /  2),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child:  AspectRatio(
                aspectRatio: 1,
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/spinner.gif", 
                  image: "${provider.user.avatar}",
                )
              ),
            ),
            Positioned(
              right: -10,
              bottom: 0,
              child: Container(
                width: getScreenSize(context) * 4.6,
                height: getScreenSize(context) * 4.6,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                  color: Color(0xFFF5F6F9),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: SvgPicture.asset("assets/icons/Camera Icon.svg", color: kPrimaryColor,),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}