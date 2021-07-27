import 'package:flutter/material.dart';
import 'package:ashri/utils/cart_db_helper.dart';
import 'package:provider/provider.dart';
import 'package:ashri/enums.dart';
import 'package:ashri/views/components/custom_bottom_nav_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/body.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';
import '../../constants.dart';



class CheckOutScreen extends StatelessWidget {
  static String routeName = "/checkout";
  @override
  Widget build(BuildContext context) {

    var provider = context.watch<CartDatabaseHelper>();  
    final double arguments = ModalRoute.of(context)!.settings.arguments as double;
    
    return FutureBuilder(
      future: provider.getItems(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot)  {
        if(snapshot.hasData){
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
              title: SafeArea(
                child: Padding( 
                  padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                  child: Text(
                    "${LocaleKeys.order_confirmation_screen_title.tr()}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                  ),
                ),
              ),
            ),
            body: Body(
              cart: snapshot.data!,
              cartTotal: arguments,
            ),
            bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.cart),
          );
        }
        return Center(child: CircularProgressIndicator());
      }
    );
  }
}