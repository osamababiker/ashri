import 'package:ashri/models/User.dart';
import 'package:ashri/views/components/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:ashri/controllers/authController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:ashri/views/components/custom_suffix_icon.dart';
import 'package:ashri/views/components/default_button.dart';
import 'package:ashri/views/components/form_error.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ashri/translations/local_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../constants.dart';
import '../../../enums.dart';
import '../../../size_config.dart'; 

class UserInfoForm extends StatefulWidget {
  static String routeName = "/editUserInfo";
  @override
  _UserInfoFormState createState() => _UserInfoFormState();
} 

class _UserInfoFormState extends State<UserInfoForm> {

  
  final _formKey = GlobalKey<FormState>();
  String _nameValue = "";
  String _addressValue = "";
  String _phoneValue = "";
  final List<String> errors = []; 
  bool isPressed = false;



  void addError({required String error}){
    if(!errors.contains(error)){
      setState(() {
        errors.add("$error");
      });
    }
  }

  void removeError({required String error}){
    if(errors.contains(error)){
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final User arguments = ModalRoute.of(context)!.settings.arguments as User;

    Size size = MediaQuery.of(context).size;
    

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Padding(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            child: SvgPicture.asset("assets/icons/arrow_right.svg", color: Colors.white)
          ),
          onPressed: () {Navigator.pop(context);},
        ),
        title: Text(
          "${LocaleKeys.edit_profile_screen_title.tr()}", 
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          )
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding),
          child: Container(
            width: size.width,
            height: getScreenSize(context) * 50.0,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Form(
              key: _formKey,
              child: Column( 
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  buildNameFormField(name: arguments.name),
                  SizedBox(height: 30),
                  buildPhoneFormField(phone: arguments.phone),
                  SizedBox(height: 30),
                  buildAddressFormField(address: arguments.address),
                  SizedBox(height: 30),
                  FormError(errors: errors),
                  SizedBox(height: 15),
                  !isPressed ? 
                  DefaultButton(
                    text: "${LocaleKeys.edit_profile_screen_editBtn.tr()}",
                    press: () async{
                      Map fields = {
                        'name': _nameValue,
                        'address': _addressValue,
                        'phone': _phoneValue,
                        'userId': arguments.id
                      };
                      if(_formKey.currentState!.validate()){
                        errors.clear();
                        setState(() {
                          isPressed = true;
                        }); 
                        var provider = Provider.of<Auth>(context, listen: false);
                        if(await provider.update(data: fields)){
                          Fluttertoast.showToast(
                            msg: "${LocaleKeys.edit_profile_screen_successHint.tr()}",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: kPrimaryColor,
                            textColor: Colors.white,
                            fontSize: 16.0
                          );
                          setState(() {
                            isPressed = false;
                          }); 
                          Navigator.pop(context);
                        }else {
                          addError(error: "${LocaleKeys.edit_profile_screen_errorHint.tr()}");
                          setState(() {
                            isPressed = false;
                          });
                        }
                      }
                    }
                  )
                  :
                  Center(child: CircularProgressIndicator())
                ]
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile)
    );
  }


  TextFormField buildNameFormField({required String name}) {
    if(_nameValue == ""){
      setState(() {
        _nameValue = name;
      });
    }
    return TextFormField(
      keyboardType: TextInputType.name,
      initialValue: name,
      onChanged: (value){
        if(value.isNotEmpty){
          setState(() {
            _nameValue = value;
          });
          removeError(error: kNamelNullError);
        }
      },
      validator: (value){
        if(value!.isEmpty){
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${LocaleKeys.sign_up_screen_name_lable.tr()}",
        hintText: "${LocaleKeys.sign_up_screen_name_hint.tr()}",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg",),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildAddressFormField({required String address}) {
    if(_addressValue == ""){
      setState(() {
        _addressValue = address;
      });
    }
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      maxLines: 3,
      initialValue: address,
      onChanged: (value){
        if(value.isNotEmpty){
          removeError(error: kAddressNullError);
          setState(() {
            _addressValue = value;
          });
        }
        return null;
      },
      validator: (value){
        if(value!.isEmpty){
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${LocaleKeys.sign_up_screen_address_lable.tr()}",
        hintText: "${LocaleKeys.sign_up_screen_address_hint.tr()}",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Location_point.svg",),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(kDefaultPadding)
      ),
    );
  }

  TextFormField buildPhoneFormField({required String phone}) {
    if(_phoneValue == ""){
      setState(() {
        _phoneValue = phone;
      });
    }
    return TextFormField(
      keyboardType: TextInputType.phone,
      initialValue: phone,
      onChanged: (value){
        if(value.isNotEmpty){
          removeError(error: kPhoneNumberNullError);
          setState(() {
            _phoneValue = value;
          });
        }
        return null;
      },
      validator: (value){
        if(value!.isEmpty){
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${LocaleKeys.sign_up_screen_phone_lable.tr()}",
        hintText: "${LocaleKeys.sign_up_screen_phone_hint.tr()}",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Phone.svg",),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
  
}




