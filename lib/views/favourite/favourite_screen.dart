import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ashri/controllers/authController.dart';
import 'package:ashri/controllers/productsController.dart';
import 'package:ashri/views/components/custom_bottom_nav_bar.dart';
import '../../constants.dart';
import '../../enums.dart';
import 'components/app_bar.dart';
import 'components/body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';



class FavouriteScreen extends StatelessWidget {
  static String routeName = '/favourite';
  @override
  Widget build(BuildContext context) {

    var provider = context.watch<Auth>(); 
    
    return Scaffold(
      appBar: buildAppBar(context),
      body: FutureBuilder<List>( 
      future: favoritesList(userId: provider.user.id), 
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Body(favorites: snapshot.data!);
        }
        else {
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
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favorite),
    );
  }

}