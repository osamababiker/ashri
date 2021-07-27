import 'package:flutter/material.dart';
import 'constants.dart';


ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: kFontFamily, 
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ); 
}
 
InputDecorationTheme inputDecorationTheme() {

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: kTextColor.withOpacity(0.2)),
        gapPadding: 10
      );

    return InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 42),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,  
      border: outlineInputBorder
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor,fontFamily: kFontFamily),
    bodyText2: TextStyle(color: kTextColor,fontFamily: kFontFamily),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme( 
    color: kPrimaryColor,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(
      color: Colors.black
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Color(0xFF8B8B8B),
        fontSize: 18,
        fontFamily: kFontFamily
      ),
    )
  );
}