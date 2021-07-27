import 'package:flutter/material.dart';
import 'package:ashri/models/Cart.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';


class CartInfo extends StatelessWidget { 
  const CartInfo({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text(
                "${LocaleKeys.order_confirmation_screen_productLable.tr()} :",
                style: TextStyle(
                  fontSize: 16
                )
              ),
              SizedBox(width: 15),
              Text(
                "${cart.name}",
                style: TextStyle(
                  fontSize: 16
                )
              )
            ]
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text(
                "${LocaleKeys.order_confirmation_screen_priceLable.tr()} :",
                style: TextStyle(
                  fontSize: 16
                )
              ),
              SizedBox(width: 15),
              Text(
                "${cart.sellingPrice}",
                style: TextStyle(
                  fontSize: 16
                )
              )
            ]
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text(
                "${LocaleKeys.order_confirmation_screen_quantityLable.tr()} :",
                style: TextStyle(
                  fontSize: 16
                )
              ),
              SizedBox(width: 15),
              Text(
                "${cart.quantity}",
                style: TextStyle(
                  fontSize: 16
                )
              )
            ]
          ),
        ),
        Divider(),
        SizedBox(height: 15),
      ],
    );
  }
}