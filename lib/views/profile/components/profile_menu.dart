import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';
import '../../../size_config.dart';


class ProfileMenu extends StatelessWidget {
  final String text , icon;
  final VoidCallback press;
  const ProfileMenu({
    Key? key, 
    required this.text, 
    required this.icon, 
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding / 4),
      child: Container(
        padding: EdgeInsets.all(kDefaultPadding ),
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
        ),
        child: TextButton(
          onPressed: press, 
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                width: getScreenSize(context) * 2.2,
                color: kPrimaryColor
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ),
              Icon(Icons.arrow_forward_ios, color: kPrimaryColor)
            ]
          ),
        ),
      ),
    );
  }
}
