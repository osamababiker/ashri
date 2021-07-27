import 'package:flutter/material.dart';
import 'package:ashri/models/Product.dart';
import 'package:ashri/views/details/details_screen.dart';
import 'package:ashri/utils/.env.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';

import '../../../constants.dart';
import '../../../size_config.dart';





class SimilarProductCard extends StatelessWidget {
  const SimilarProductCard({
    Key? key,
    required this.product,
    required this.productId,
    required this.numOfProducts
  }) : super(key: key);

  final Product product;
  // so we dont disply the same product
  final int productId;
  final int numOfProducts;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    if(product.id != productId){
      return Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context, DetailsScreen.routeName,
              arguments: product
            );
          },
          child: Container(
            width: getScreenSize(context) * 15.0,
            height: getScreenSize(context) * 25.0,
            padding: EdgeInsets.all(kDefaultPadding / 4),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: kTextColor.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(5)
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: getScreenSize(context) * 10.0,
                    height: getScreenSize(context) * 10.0,
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
                  SizedBox(height: 10),
                  Text(
                    "${context.locale}" == 'ar' ?  product.name : product.nameEn,
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }else if(numOfProducts == 1) 
      return SizedBox(
        width: size.width * 0.9,
        child: Text( 
          "${LocaleKeys.single_product_screen_no_similar_products.tr()}",
          style: TextStyle(
            color: Colors.red,
            fontSize: 14
          )
        ),
      ); else return Text("");
  }
}