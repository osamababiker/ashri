import 'package:ashri/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';
import '../../../size_config.dart';


class OrderCompleteScreen extends StatelessWidget {
  static String routeName = "/order-complete";
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "اشريا",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16
            ),
          ),
        ),
        body: Body(),
      ),
    );
  }
}


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              width: getScreenSize(context) * 40.0,
              height: getScreenSize(context) * 20.0,
              child: SvgPicture.asset("assets/icons/Order_complete.svg")
            ), 
            SizedBox(height: kDefaultPadding),
            Text(
              "تم ارسال الطلب بنجاح",
              style: TextStyle(
                fontSize: 16,
                color: kTextColor
              ),
            ),
            SizedBox(height: kDefaultPadding),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
              child: Container(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "مواصلة التسوق",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white
                  ),
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}