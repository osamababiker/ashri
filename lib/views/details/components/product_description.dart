import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:ashri/models/Product.dart';

import 'package:easy_localization/easy_localization.dart';


class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: kDefaultPadding 
          ),
          child: Text(
            "${context.locale}" == 'ar' ?  product.description : product.descriptionEn,
          ),
        ),
      ],
    );
  }
}

