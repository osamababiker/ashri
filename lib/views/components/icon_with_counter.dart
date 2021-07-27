import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants.dart';
import '../../size_config.dart';


class IconWithCounter extends StatelessWidget {
  const IconWithCounter({
    Key? key, 
    required this.icon, 
    required this.numOfItems,
    required this.press,
  }) : super(key: key);

  final String icon ;
  final int numOfItems;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Stack(
        children: [
          Container(
            width: getScreenSize(context) * 5.5,
            height: getScreenSize(context) * 5.5,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SvgPicture.asset(icon,color: Colors.white),
            ),
          ),
          numOfItems != 0 ?
            Positioned(
              top: 3, 
              right: -3,
              child: Container(
                width: getScreenSize(context) * 2.0,
                height: getScreenSize(context) * 2.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  shape: BoxShape.circle
                ),
                child: Text(
                  "$numOfItems",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          : Text("")
        ],
      ),
    );
  }
}