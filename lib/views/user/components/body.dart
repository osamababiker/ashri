import 'package:flutter/material.dart';
import 'package:ashri/controllers/authController.dart';
import 'package:provider/provider.dart';
import 'user_info_card.dart';
import 'top_header.dart';
import 'section_divider.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var provider = context.watch<Auth>(); 
    
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          TopHeader(user: provider.user),
          SectionDivider(),
          UserInfoCard(user: provider.user), 
        ],
      ),
    );
  }
}

