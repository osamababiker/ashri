import 'package:flutter/material.dart';
import 'package:ashri/constants.dart';

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key? key, 
    required this.color, 
    required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kDefaultPadding / 2), 
      padding: EdgeInsets.only(top: kDefaultPadding / 2),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10)
        )
      ),
      child: child,
    );
  }
}

