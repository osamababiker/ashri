import 'package:flutter/material.dart';
import 'package:ashri/constants.dart';
import 'package:ashri/models/User.dart';

import '../../../size_config.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({
    Key? key,
    required this.user
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name, 
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: getScreenSize(context) * 0.5),
            Text(
              user.email,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ]
        ),
      ),
    );
  }
}