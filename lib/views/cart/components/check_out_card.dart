import 'package:ashri/controllers/authController.dart';
import 'package:ashri/views/signin/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:ashri/controllers/settingsController.dart';
import 'package:ashri/models/Setting.dart';
import 'package:ashri/views/checkout/check_out_screen.dart';
import 'package:provider/provider.dart';
import 'package:ashri/utils/cart_db_helper.dart';
import 'package:ashri/views/components/default_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';
import '../../../constants.dart';
import '../../../size_config.dart'; 


class CheckOutCard extends StatefulWidget {
  const CheckOutCard({
    Key? key, required this.cartTotal,
  }) : super(key: key);

  final double cartTotal;


  @override
  _CheckOutCardState createState() => _CheckOutCardState();
}

class _CheckOutCardState extends State<CheckOutCard> {

 double deliveryCost = 0;
 double cartTotal = 0;
 
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

    Size size =MediaQuery.of(context).size;
     
    return Container(
      width: size.width,
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
                    "${LocaleKeys.cart_screen_deliveryCost.tr()}",
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
                  text: "${LocaleKeys.cart_screen_subTotal.tr()}: ",
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
            Row( 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder(
                  future: context.watch<CartDatabaseHelper>().getCartTotal(), 
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return Text.rich( 
                        TextSpan(
                          text: "${LocaleKeys.cart_screen_total.tr()}:\n",
                          style: TextStyle(
                            fontFamily: kFontFamily
                          ),
                          children: [
                            TextSpan(
                              text: " ${widget.cartTotal + deliveryCost} ${LocaleKeys.currency.tr()}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16
                              )
                            )
                          ]
                        )
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
                SizedBox(
                  width: getScreenSize(context) * 19.0,
                  height: getScreenSize(context) * 8.0,
                  child: DefaultButton( 
                    text: "${LocaleKeys.cart_screen_confirmBtn.tr()}",
                    press: (){  
                      var provider = Provider.of<Auth>(context, listen: false); 
                      if(!provider.authenticated){
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      } else {
                        Navigator.pushNamed(
                          context, CheckOutScreen.routeName,
                          arguments: widget.cartTotal
                        );
                      }                
                    }
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}