import 'package:flutter/material.dart';
import 'package:ashri/controllers/authController.dart';
import 'package:ashri/views/favourite/favourite_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ashri/views/cart/cart_screen.dart';
import 'package:ashri/utils/cart_db_helper.dart';
import 'package:ashri/views/home/home_screen.dart';
import 'package:ashri/views/profile/profile_screen.dart';
import 'package:ashri/views/signin/sign_in_screen.dart';
import '../../constants.dart';
import '../../enums.dart';
import '../../size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';


class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key, 
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    var provider = context.watch<Auth>();  
    var cartProvider = context.watch<CartDatabaseHelper>();

    return Container(
      width: size.width,
      height: getScreenSize(context) * 9.0,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(
          offset: Offset(0 , 2),
          color: Colors.black.withOpacity(0.5),
          blurRadius: 10
        )]
      ), 
      child: Row( 
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconWithBottomTitle(
            icon: "assets/icons/home-icon.svg",
            title: "${LocaleKeys.bottom_nav_home.tr()}",
            color: MenuState.home == selectedMenu ? kPrimaryColor : kTextColor,
            press: () {
              Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.routeName, (Route<dynamic> route) => false);
            },
          ),
          IconWithBottomTitle(
            icon: "assets/icons/Heart_Icon.svg",
            title: "${LocaleKeys.bottom_nav_favorite.tr()}",
            color: MenuState.favorite == selectedMenu ? kPrimaryColor : kTextColor,
            press: () {
              if(!provider.authenticated){
                Navigator.pushNamed(context, SignInScreen.routeName);
              } else
              Navigator.of(context).pushNamed(FavouriteScreen.routeName);
            },
          ),
          IconWithBottomTitle(
            icon: "assets/icons/user_.svg",
            title: "${LocaleKeys.bottom_nav_profile.tr()}",
            color: MenuState.profile == selectedMenu ? kPrimaryColor : kTextColor,
            press: () {
              if(!provider.authenticated){
                Navigator.pushNamed(context, SignInScreen.routeName); 
              }else 
              Navigator.of(context).pushNamed(ProfileScreen.routeName);
            },
          ),
          Stack(
            children: [
              IconWithBottomTitle(
                icon: "assets/icons/Cart_Icon.svg",
                title: "${LocaleKeys.bottom_nav_cart.tr()}",
                color: MenuState.cart == selectedMenu ? kPrimaryColor : kTextColor,
                press: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
              Container(
                child: FutureBuilder<int>(
                  future: cartProvider.getCount(),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return snapshot.data != 0 ? Positioned(
                        top: 5, 
                        right: 0,
                        child: Container(
                          width: getScreenSize(context) * 2.0,
                          height: getScreenSize(context) * 2.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            shape: BoxShape.circle
                          ),
                          child: Text(
                            "${snapshot.data}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ) : Text("");
                    }
                    return Text("");
                  }
                )
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class IconWithBottomTitle extends StatelessWidget {
  const IconWithBottomTitle({
    Key? key, 
    required this.icon, 
    required this.title, 
    required this.press, 
    required this.color,
  }) : super(key: key);

  final String icon , title;
  final VoidCallback press;
  final Color color;
  @override
  Widget build(BuildContext context) {
   
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Column(
          children: [
            SizedBox(
              width: getScreenSize(context) * 3.5,
              height: getScreenSize(context) * 3.5,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: SvgPicture.asset(icon, color: color),
              )
            ),
            SizedBox(height: getScreenSize(context) * 0.5),
            Text(
              title,
              style: TextStyle(
                color: kTextColor,
                fontSize: 10
              )
            )
          ]
        ),
      ),
    );
  }
}