import 'package:flutter/material.dart';
import 'package:ashri/constants.dart';
import 'package:ashri/models/Brands.dart';
import 'package:ashri/utils/.env.dart';
import '../../../size_config.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    Key? key,
    required this.brand,
    required this.press
  }) : super(key: key);

  final Brands brand;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: SizedBox(
          width: getScreenSize(context) * 5.0,
          height: getScreenSize(context) * 5.0,
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 4),
            child: AspectRatio(
              aspectRatio: 1,
              child: FadeInImage.assetNetwork(
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/spinner.gif",
                  );
                },
                placeholder: "assets/images/spinner.gif", 
                image: "$uploadUri/brands/${brand.image}"
              )
            ),
          ),
        ),
      ),
    );
  }
}
