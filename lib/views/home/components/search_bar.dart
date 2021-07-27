import 'package:flutter/material.dart';
import 'package:ashri/views/search/search_screen.dart';
import 'package:ashri/size_config.dart';
import '../../../constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';


class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: Container(
        width: size.width,
        height: getScreenSize(context) * 4.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          onTap: () {
             Navigator.pushNamed(context, SearchScreen.routeName);
          },
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: "${LocaleKeys.search_hint_text.tr()}",
            suffixIcon: Icon(Icons.search), 
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10
            )
          )
        ),
      ),
    );
  }
}



