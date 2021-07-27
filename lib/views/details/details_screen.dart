import 'package:ashri/views/components/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:ashri/models/Product.dart';
import '../../constants.dart';
import '../../enums.dart';
import 'components/body.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';



class DetailsScreen extends StatelessWidget {
  static String routeName = '/details'; 
  @override
  Widget build(BuildContext context) {

    final Product arguments = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            child: SvgPicture.asset("assets/icons/arrow_right.svg", color: Colors.white)
          )
        ),
        title: Text(
          "${LocaleKeys.single_product_screen_title.tr()}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          )
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white
              ),
              child: Row(
                children: [
                  Text(
                    arguments.rating.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold,color: kTextColor)
                  ),
                  SizedBox(width: 5),
                  SvgPicture.asset("assets/icons/Star Icon.svg"),
                ]
              ),
            ),
          ),
        ],
      ), 
      body: Body(product: arguments), 
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.details),
    );
  }

  
}


