import 'package:ashri/views/orders/components/order_complete.dart';
import 'package:flutter/material.dart';
import 'package:ashri/controllers/ordersController.dart';
import 'package:ashri/controllers/settingsController.dart';
import 'package:ashri/models/Setting.dart';
import 'package:ashri/views/signin/sign_in_screen.dart';
import 'package:ashri/controllers/authController.dart';
import 'package:provider/provider.dart';
import 'package:ashri/views/components/default_button.dart';
import 'package:ashri/utils/cart_db_helper.dart';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';
import '../../../constants.dart';
import '../../../size_config.dart';


class CheckOutCard extends StatefulWidget {
  const CheckOutCard({
    Key? key,
    required this.cart,
    required this.cartTotal
  }) : super(key: key);

  final List cart;
  final double cartTotal;

  @override
  _CheckOutCardState createState() => _CheckOutCardState();
}

class _CheckOutCardState extends State<CheckOutCard> {

  bool isPressed = false;
  double deliveryCost = 0;
  double cartTotal = 0;
  double discount = 0;
  String couponErrorMsg = '';
  bool couponBtnPressed = false;
  TextEditingController _couponController =  TextEditingController();
 
 Future<void> fetchDeliveryCost() async{
   Setting setting = await fetchSetting();
   setState(() {
     deliveryCost = double.parse(setting.deliveryCost);
   });
 }


 @override
  void initState() {
    super.initState();
    fetchDeliveryCost();
  }

  @override
  Widget build(BuildContext context) {

    var provider = context.watch<Auth>();
    Size size =MediaQuery.of(context).size;
     
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 30
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), 
          topRight: Radius.circular(30)
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0 , -15),
            blurRadius: 20,
            color: Color(0xFFDADADA)
          )
        ]
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: size.width,
              height: 60,
              child: Row(
                children: [
                  Text(
                    "${LocaleKeys.cart_screen_deliveryCost.tr()} :", 
                    style: TextStyle(
                      fontSize: 16
                    )
                  ),
                  SizedBox(width: 5),
                  deliveryCost != 0 ? Text(
                    " $deliveryCost ${LocaleKeys.currency.tr()}",
                    style: TextStyle(
                      fontSize: 16
                    )
                  ) : SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(),
                  )
                ]
              )
            ),
            Container(
              width: size.width,
              height: 60,
              child: Text.rich( 
                TextSpan(
                  text: "${LocaleKeys.cart_screen_subTotal.tr()} :",
                  style: TextStyle(
                    fontFamily: kFontFamily
                  ),
                  children: [
                    TextSpan(
                      text: " ${widget.cartTotal} ${LocaleKeys.currency.tr()}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16
                      )
                    )
                  ]
                )
              )
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10) 
                        ),
                        child: TextFormField(
                          controller: _couponController,
                          decoration: InputDecoration(
                            hintText: "${LocaleKeys.order_confirmation_screen_couponLable.tr()}",
                            hintStyle: TextStyle(
                              fontSize: 12
                            )
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      !couponBtnPressed ? Container(
                        width: size.width * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade100
                        ),
                        child: TextButton(
                          child: Text(
                            "${LocaleKeys.order_confirmation_screen_applyCouponBtn.tr()}",
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 12
                            )
                          ),
                          onPressed: () async {
                            setState(() => couponBtnPressed = true);
                            Map data = {"code": _couponController.text};
                            var coupon = await fetchCoupon(data: data);
                            if(coupon != null){
                              if(double.parse(coupon.discount) > 0){
                                setState(() {
                                  if(discount == 0)
                                    discount = double.parse(coupon.discount);
                                  couponErrorMsg = '';
                                  couponBtnPressed = false;
                                });
                              }else {
                                setState(() {
                                  couponErrorMsg = "${LocaleKeys.order_confirmation_screen_couponError.tr()}";
                                  couponBtnPressed = false;
                                });
                              }
                            }
                            else {
                              setState(() {
                                couponErrorMsg = "${LocaleKeys.order_confirmation_screen_couponError.tr()}";
                                couponBtnPressed = false;
                              });
                            }
                          },
                        ),
                      ) : SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator()
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    couponErrorMsg, 
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: kDefaultPadding),
            Row( 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich( 
                  TextSpan(
                    text: "${LocaleKeys.cart_screen_total.tr()}:\n",
                    style: TextStyle(
                      fontFamily: kFontFamily
                    ),
                    children: [
                      TextSpan(
                        text: "${(widget.cartTotal + deliveryCost) - (discount * (widget.cartTotal + deliveryCost) / 100)} جنيه",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16
                        )
                      )
                    ]
                  )
                ),
                !isPressed ? SizedBox(
                    width: getScreenSize(context) * 19.0,
                    child: DefaultButton(
                      text: "${LocaleKeys.order_confirmation_screen_sendOrderBtn.tr()}",
                      press: () async{
                        setState(() {
                          isPressed = true;
                        });
                        if(provider.authenticated){
                          var user = provider.user;
                          List cartList = [];
                          for(var i=0; i< widget.cart.length; i++){
                            var cartMap = widget.cart[i].toMap();
                            cartList.add(cartMap);
                          }
                          Map data = {
                            'userId': user.id,
                            'cart': jsonEncode(cartList),
                            'discount': discount,
                            'status': 0
                          };  
                          await checkout(data: data);
                          var db = new CartDatabaseHelper(); 
                          for(var i=0; i< widget.cart.length; i++){
                            await db.deleteItem(widget.cart[i].id);
                          }
                          Navigator.pushReplacementNamed(context, OrderCompleteScreen.routeName);
                        }else {
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        }
                      }
                    ),
                  ) : Center(child: CircularProgressIndicator()) 
              ],
            )
          ],
        ),
      ),
    );
  }
}


