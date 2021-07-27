import 'package:ashri/controllers/productsController.dart';
import 'package:ashri/models/Brands.dart';
import 'package:flutter/material.dart';
import 'package:ashri/enums.dart';
import 'package:ashri/views/components/custom_bottom_nav_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants.dart';
import 'components/products_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';


class FilterByBrandScreen extends StatelessWidget {
  static String routeName = "filter-by-brand";
  @override
  Widget build(BuildContext context) {
    final Brands brand = ModalRoute.of(context)!.settings.arguments as Brands; 
    Size size = MediaQuery.of(context).size;
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
          "${LocaleKeys.shop_by_brand_screen_title.tr()}",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white
          ),
        ),
      ),
      body: FutureBuilder<List>(
        future: fetchProducts(endPoint: '/products/brands/${brand.id}'),  
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Container(
              height: size.height,
              child: ProductsList(
                brand: brand,
                products: snapshot.data!
              ),
            );
          }else {
            if(snapshot.hasError){
              return Padding(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: Center(
                  child: Text(
                    "${LocaleKeys.no_internet_meg1.tr()}, ${LocaleKeys.no_internet_meg2.tr()}",
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 12
                    )
                  ),
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              child: Center(child: CircularProgressIndicator())
            );
          } 
        }
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.products),
    ); 
  }
}


