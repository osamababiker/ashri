import 'package:ashri/models/User.dart';
import 'package:ashri/views/otp/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:ashri/constants.dart';
import 'package:provider/provider.dart';
import 'package:ashri/controllers/authController.dart';
import 'otp_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';


class Body extends StatefulWidget {

  final User user;

  const Body({Key? key, required this.user}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  bool reSendIsPressed = true;

  @override
  Widget build(BuildContext context) {

    Size size  = MediaQuery.of(context).size;
    var provider = Provider.of<Auth>(context, listen: false);

    return SizedBox(
      width: size.width,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: size.height * 0.05),
              Text(
                "${LocaleKeys.otp_screen_confirm_phone_title.tr()}", 
                style: headingStyle,
              ),
              Text("${LocaleKeys.otp_screen_code_sent_lable.tr()}  ${widget.user.phone} "),
              SizedBox(height: kDefaultPadding),  
              OtpForm(user: widget.user), 
              SizedBox(height: kDefaultPadding),  
              Container(
                child: TweenAnimationBuilder(
                  tween: Tween(begin: 1.0, end: 0.0),
                  duration: Duration(seconds: 60),
                  builder: (_, value, child) => Column(
                    children: [
                      // Text(
                      //   "00:${value!}",
                      //   style: TextStyle(color: kPrimaryColor),
                      // ),
                      // SizedBox(height: kDefaultPadding),
                      value == 0.0 ? GestureDetector(
                        onTap: () async{
                          setState(() => reSendIsPressed = false);
                          Map data = {
                            'userId': widget.user.id
                          };
                          await provider.reSendOtp(data: data);
                          Navigator.pushReplacementNamed(
                            context, OtpScreen.routeName,
                            arguments: widget.user
                          );
                        },
                        child: AbsorbPointer(
                        absorbing: !reSendIsPressed,
                          child: Text(
                            "${LocaleKeys.otp_screen_resend_code_btn.tr()}",
                            style: TextStyle(decoration: TextDecoration.underline),
                          ),
                        ),
                      ): Text("")
                    ]
                  ),
                )
              )         
            ],
          ),
        ),
      ),
    );
  }
}
