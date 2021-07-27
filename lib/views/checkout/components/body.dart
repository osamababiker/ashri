import 'package:flutter/material.dart';
import 'package:ashri/views/user/components/user_info_form.dart';
import 'package:ashri/controllers/authController.dart';
import 'package:provider/provider.dart';
import 'cart_info.dart';
import 'user_info.dart';
import 'check_out_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';
import '../../../constants.dart';


// ignore: must_be_immutable
class Body extends StatefulWidget {

  List cart;
  double cartTotal;
  Body({required this.cart, required this.cartTotal});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {

    var provider = context.watch<Auth>();
    Size size = MediaQuery.of(context).size;
    
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding, horizontal: kDefaultPadding/2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${LocaleKeys.order_confirmation_screen_userInfoTitle.tr()}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryLightColor),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context, UserInfoForm.routeName, 
                              arguments: provider.user
                            );
                          },
                          child: Text(
                            "${LocaleKeys.order_confirmation_screen_editBtn.tr()}",
                            style: TextStyle(
                              fontSize: 10,
                              color: kPrimaryLightColor
                            )
                          )
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  UserInfo(label: "${LocaleKeys.order_confirmation_screen_emailLable.tr()}",info: '${provider.user.name}'),
                  SizedBox(height: 15),
                  UserInfo(label: "${LocaleKeys.order_confirmation_screen_emailLable.tr()}",info: '${provider.user.email}'),
                  SizedBox(height: 15),
                  UserInfo(label: "${LocaleKeys.order_confirmation_screen_phoneLable.tr()}",info: '${provider.user.phone}'),
                  SizedBox(height: 15),
                  UserInfo(label: "${LocaleKeys.order_confirmation_screen_addressLable.tr()}",info: '${provider.user.address}'),
                ]
              ),
            ),
            Divider(color: kTextColor, height: 50),
            Container(
              width: size.width,
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${LocaleKeys.order_confirmation_screen_orderInfoTitle.tr()}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: List.generate(
                      widget.cart.length, (index) =>
                      CartInfo(
                        cart: widget.cart[index],
                      )
                    )
                  )
                ]
              )
            ),
            CheckOutCard(
              cart: widget.cart,
              cartTotal: widget.cartTotal,
            ) 
          ],
        ),
      ),
    );
  }
}



