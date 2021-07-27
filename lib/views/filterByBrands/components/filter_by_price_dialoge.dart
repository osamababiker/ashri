import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';


class SortByPriceDialogBox extends StatefulWidget {
  @override
  _SortByPriceDialogBoxState createState() => _SortByPriceDialogBoxState();
}

class _SortByPriceDialogBoxState extends State<SortByPriceDialogBox> {
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
      padding: EdgeInsets.all(kDefaultPadding),
      margin: EdgeInsets.only(top: 45),
      height: 165,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(kDefaultPadding),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.5),offset: Offset(0,10),
          blurRadius: 10
          ),
        ]
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${LocaleKeys.sort_by_price_title.tr()}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Divider(color: kTextColor.withOpacity(0.5), height: 2),
            TextButton(
              onPressed: (){
                Navigator.pop(context,'DESC');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${LocaleKeys.sort_by_price_topToBottom.tr()}",
                    style: TextStyle(
                      fontSize: 14,
                      color: kTextColor
                    )
                  ),
                  Icon(Icons.arrow_circle_down, color: kTextColor),
                ],
              )
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context,'ASC');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${LocaleKeys.sort_by_price_bottomToTop.tr()}",
                    style: TextStyle(
                      fontSize: 14,
                      color: kTextColor
                    )
                  ),
                  Icon(Icons.arrow_circle_up, color: kTextColor),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}