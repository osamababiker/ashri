import 'package:flutter/material.dart';
import 'package:ashri/enums.dart';
import 'package:ashri/views/components/custom_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:ashri/utils/cart_db_helper.dart';
import 'components/app_bar.dart';
import 'components/body.dart';



class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {

    var provider = context.watch<CartDatabaseHelper>(); 

    return FutureBuilder(
      future: provider.getItems(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot)  {
        if(snapshot.hasData){
          return Scaffold(
            appBar: buildAppBar(context),
            body: Body(cart: snapshot.data!), 
            bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.cart),
          ); 
        }
        return Center(child: CircularProgressIndicator());
      }
    );
  }
}


