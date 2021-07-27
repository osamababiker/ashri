import 'package:ashri/views/filterByBrands/filter_by_brand_screen.dart';
import 'package:flutter/material.dart';
import 'package:ashri/controllers/brandsController.dart';
import 'brand_card.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';

import '../../../constants.dart';
import '../../../size_config.dart';


class ShopByBrandArea extends StatelessWidget {
  const ShopByBrandArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: getScreenSize(context) * 12.0,
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: FutureBuilder<List>( 
          future: fetchBrands(), 
          builder: (context, snapshot) {
            if(snapshot.hasData){ 
              return Column( 
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        snapshot.data!.length, 
                        (index) => BrandCard(
                          brand: snapshot.data![index],
                          press: (){
                            Navigator.pushNamed(context, 
                              FilterByBrandScreen.routeName,
                              arguments: snapshot.data![index]
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
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
        )
      ),
    );
  }
}

