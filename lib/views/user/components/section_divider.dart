import 'package:flutter/material.dart';

import '../../../size_config.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: getScreenSize(context) * 1.5,
      decoration: BoxDecoration(
        color: Colors.grey.shade300
      ),
    );
  }
}

