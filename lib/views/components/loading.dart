import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
    );
  }
  contentBox(context){
    return Container(
      width: double.infinity,
      color: Colors.grey.shade200,
    );
  }
}