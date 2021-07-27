import 'package:flutter/material.dart';
import 'package:ashri/translations/local_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';


const kPrimaryColor = Color(0xFF9b63f8);
const kPrimaryLightColor = Color(0xFF809ffc);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)], 
);
const kSecondaryColor = Color(0xFFf07da8);
const kTextColor = Color(0xFF757575);
const kFontFamily = "Tajawal";

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);


const kDefaultPadding = 20.0; 


// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
String kEmailNullError = "${LocaleKeys.validation_email_null_error.tr()}";
String kInvalidEmailError = "${LocaleKeys.validation_email_invalid_error.tr()}";
String kPassNullError = "${LocaleKeys.validation_password_null_error.tr()}";
String kShortPassError = "${LocaleKeys.validation_password_short_error.tr()}";
String kMatchPassError = "${LocaleKeys.validation_password_match_error.tr()}";
String kNamelNullError = "${LocaleKeys.validation_name_null_error.tr()}";
String kPhoneNumberNullError = "${LocaleKeys.validation_phone_null_error.tr()}";
String kAddressNullError = "${LocaleKeys.validation_address_null_error.tr()}";
 

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(
    vertical: 15
  ),
  enabledBorder: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  border: outlineInputBorder()
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kTextColor)
  );
}





