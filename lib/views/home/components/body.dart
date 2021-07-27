import 'package:ashri/constants.dart';
import 'package:flutter/material.dart';
import 'search_bar.dart';
import 'products_card.dart';
import 'discount_banner.dart';
import 'categories_cards.dart';
import 'offers_card.dart';
import 'shop_by_brand_area.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column( 
        children: [
          SearchBar(),
          DiscountBanner(), 
          CategoriesCard(),
          ProductsCard(
            sectionTitle: "${LocaleKeys.home_screen_women_section.tr()}",
            sectionId: 1
          ),
          OffersCard(),  
          ProductsCard(
            sectionTitle: "${LocaleKeys.home_screen_men_section.tr()}",
            sectionId: 2
          ), 
          ProductsCard(
            sectionTitle: "${LocaleKeys.home_screen_kids_section.tr()}",
            sectionId: 3
          ),
          ProductsCard(
            sectionTitle: "${LocaleKeys.home_screen_menAndWomen_section.tr()}",
            sectionId: 4
          ),
          SizedBox(height: kDefaultPadding),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Container(
              width: size.width,
              child: Text(
                "${LocaleKeys.home_screen_brands_section.tr()}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )
              ),
            ),
          ),
          ShopByBrandArea()
        ],
      ),
    );
  }
}

