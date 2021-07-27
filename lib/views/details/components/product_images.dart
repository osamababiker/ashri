import 'package:ashri/constants.dart';
import 'package:flutter/material.dart';
import 'package:ashri/utils/.env.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ashri/models/Product.dart';
import 'package:easy_localization/easy_localization.dart';


import '../../../size_config.dart';
 


class ProductImages extends StatefulWidget {

  final Product product;

  const ProductImages({
    Key? key, required this.product,
  }) : super(key: key); 

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: kDefaultPadding),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "${context.locale}" == 'ar' ?  widget.product.name : widget.product.nameEn,
              style: Theme.of(context).textTheme.headline6!.copyWith(color: kTextColor),
            ),
          ),
          SizedBox(height: getScreenSize(context) * 1.0),
          CarouselSlider(
            options: CarouselOptions(),
            items: widget.product.images.map((image) => Container(
              child: Center(
                child: FadeInImage.assetNetwork( 
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/spinner.gif",
                    );
                  },
                  placeholder: "assets/images/spinner.gif", 
                  image: "$uploadUri/products/$image",  
                )
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}