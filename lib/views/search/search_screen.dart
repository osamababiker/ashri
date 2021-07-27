import 'package:flutter/material.dart';
import 'package:ashri/views/components/custom_bottom_nav_bar.dart';
import 'components/body.dart';
import '../../enums.dart';

class SearchScreen extends StatelessWidget {
  static String routeName = '/search';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Body()
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.search),
    );
  }
}