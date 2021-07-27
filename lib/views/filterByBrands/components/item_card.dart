import 'package:flutter/material.dart';
import 'package:ashri/utils/.env.dart';
import 'package:ashri/models/Product.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';

import '../../../constants.dart';
import '../../../size_config.dart';


class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key, 
    required this.product,
    required this.press,
  }) : super(key: key);

  final Product product;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press, 
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              height: getScreenSize(context) * 15.0,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(color: kPrimaryLightColor.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Hero(
                tag: product.id,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: FadeInImage.assetNetwork(
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/images/spinner.gif",
                      );
                    },
                    placeholder: "assets/images/spinner.gif", 
                    image: "$uploadUri/products/${product.images[0]}"
                  )
                )
              ),
            ),
            SizedBox(height: getScreenSize(context) * 1.5),
            Container(
              child: Text( 
                "${context.locale}" == 'ar' ?  product.name : product.nameEn,
                style: TextStyle(color: Colors.black),
              ),
            ),
            Text(
              "${product.sellingPrice} ${LocaleKeys.currency.tr()}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: kTextColor
              ),
            ),
            product.price != 0.0 ?
            Stack(
              children: [
                Text(
                  "${product.price} ${LocaleKeys.currency.tr()}",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Positioned(
                  top: 6,
                  child: Container(
                    width: 60,
                    height: 1.5,
                    color: kTextColor,
                  ),
                )
              ],
            ): Text(""),
          ],
        ),
      ),
    );
  }
}



