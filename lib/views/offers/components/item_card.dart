import 'package:flutter/material.dart';
import 'package:ashri/views/details/details_screen.dart';
import 'package:ashri/utils/.env.dart';
import 'package:ashri/models/Offer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';
import '../../../constants.dart';
import '../../../size_config.dart';


class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key, 
    required this.offer, 
  }) : super(key: key); 

  final Offer offer; 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed( 
          context, DetailsScreen.routeName,
          arguments: offer.product
        );
      }, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(kDefaultPadding),
            height: getScreenSize(context) * 15.0,
            width: getScreenSize(context) * 16.0,
            decoration: BoxDecoration(
              border: Border.all(color: kPrimaryLightColor.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(16)
            ),
            child: Hero(
              tag: offer.product.id,
              child: AspectRatio(
                aspectRatio: 1,
                child: FadeInImage.assetNetwork(
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/spinner.gif",
                    );
                  },
                  placeholder: "assets/images/spinner.gif", 
                  image: "$uploadUri/products/${offer.product.images[0]}"
                )
              )
            ),
          ),
          SizedBox(height: getScreenSize(context) * 1.5),
          Expanded(
            child: Text(
              "${context.locale}" == 'ar' ?  offer.product.name : offer.product.nameEn,
              style: TextStyle(color: Colors.black),
            ),
          ),
          Text(
            " ${LocaleKeys.offers_screen_discount_hint.tr()}  ${offer.offer}%",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black
            ),
          ),
        ],
      ),
    );
  }
}



