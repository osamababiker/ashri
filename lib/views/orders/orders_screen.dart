import 'package:flutter/material.dart';
import 'package:ashri/controllers/authController.dart';
import 'package:ashri/controllers/ordersController.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ashri/views/components/custom_bottom_nav_bar.dart';
import 'components/body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';
import '../../enums.dart';
import '../../constants.dart';



class OrdersScreen extends StatelessWidget {
  static String routeName = "/orders";
  @override
  Widget build(BuildContext context) {

    var provider = context.watch<Auth>();

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
          "${LocaleKeys.orders_screen_title.tr()}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          ),
        ),
      ),
      body: FutureBuilder<List>(
        future: fetchOrders(userId: provider.user.id),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Body(orders: snapshot.data!);
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
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.orders),
    );
  }
}