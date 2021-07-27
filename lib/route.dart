import 'package:ashri/views/filterByBrands/filter_by_brand_screen.dart';
import 'package:ashri/views/filterByCategories/filter_by_category_screen.dart';
import 'package:ashri/views/checkout/check_out_screen.dart';
import 'package:ashri/views/errors/no_internet.dart';
import 'package:ashri/views/orders/components/order_complete.dart';
import 'package:ashri/views/otp/otp_screen.dart';
import 'package:ashri/views/settings/policy_screen.dart';
import 'package:ashri/views/settings/settings_screen.dart';
import 'package:ashri/views/user/components/password_form.dart';
import 'package:ashri/views/user/components/user_info_form.dart';
import 'package:flutter/widgets.dart';
import 'package:ashri/views/cart/cart_screen.dart';
import 'package:ashri/views/details/details_screen.dart';
import 'package:ashri/views/favourite/favourite_screen.dart';
import 'package:ashri/views/home/home_screen.dart';
import 'package:ashri/views/products/products_screen.dart';
import 'package:ashri/views/profile/profile_screen.dart';
import 'package:ashri/views/signin/sign_in_screen.dart';
import 'package:ashri/views/signup/sign_up_screen.dart';
import 'package:ashri/views/user/user_details_screen.dart';
import 'package:ashri/views/search/search_screen.dart';
import 'package:ashri/views/orders/orders_screen.dart';
import 'package:ashri/views/offers/offers_screen.dart';
import 'package:ashri/views/splash/splash_screen.dart';


final Map<String , WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  UserDetailsScreen.routeName: (context) => UserDetailsScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  ProductsScreen.routeName: (context) => ProductsScreen(),
  FavouriteScreen.routeName: (context) => FavouriteScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  OrdersScreen.routeName: (context) => OrdersScreen(),
  OffersScreen.routeName: (context) => OffersScreen(),
  SplashScreen.routeName: (context) => SplashScreen(),
  SettingsScreen.routeName: (context) => SettingsScreen(),
  PolicyScreen.routeName: (context) => PolicyScreen(),
  CheckOutScreen.routeName: (context) => CheckOutScreen(),
  PasswordForm.routeName: (context) => PasswordForm(),
  OtpScreen.routeName: (context) => OtpScreen(),
  UserInfoForm.routeName: (context) => UserInfoForm(),
  OrderCompleteScreen.routeName: (context) => OrderCompleteScreen(),
  NoInternetScreen.routeName: (context) => NoInternetScreen(),
  FilterByCategoryScreen.routeName: (context) => FilterByCategoryScreen(),
  FilterByBrandScreen.routeName: (context) => FilterByBrandScreen()
};