import 'package:flutter/material.dart';
import 'package:ashri/controllers/offersController.dart';
import 'products_list.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';
import '../../../constants.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: fetchAllOffers(),
      builder: (context, snapshot){
        if(snapshot.hasData){
            return snapshot.data!.length > 0 ? 
              Container(
                child: ProductsList(offers: snapshot.data!)
              ): Center(
                child: Text(
                  "${LocaleKeys.no_data_error.tr()}",
                  style: TextStyle(
                    fontSize: 14,
                    color: kTextColor
                  ),
                ),
              );
        } else {
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
    );
  }
}