import 'package:ashri/views/components/custom_suffix_icon.dart';
import 'package:ashri/views/components/form_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ashri/controllers/authController.dart';
import 'package:ashri/views/components/default_button.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ashri/views/components/custom_bottom_nav_bar.dart';
import 'package:ashri/translations/local_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../constants.dart';
import '../../../enums.dart';
import '../../../size_config.dart';


class PasswordForm extends StatelessWidget {
  static String routeName = "/changePassword";
  @override
  Widget build(BuildContext context) {
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
          "${LocaleKeys.change_password_screen_title.tr()}", 
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          )
        ),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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

    Size size = MediaQuery.of(context).size;
    var provider = context.watch<Auth>(); 

    return SingleChildScrollView(
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
                buildPasswordFormField(),
                SizedBox(height: 30),
                buildPasswordConfirmFormField(),
                SizedBox(height: 15),
                FormError(errors: errors),
                SizedBox(height: 15),
                !isPressed ? 
                DefaultButton(
                  text: "${LocaleKeys.change_password_screen_title.tr()}",
                  press: () async{
                    Map fields = {
                      'password': _passwordController.text,
                      'userId': provider.user.id
                    };
                    if(_formKey.currentState!.validate()){
                      errors.clear();
                      setState(() {
                        isPressed = true;
                      }); 
                      var provider = Provider.of<Auth>(context, listen: false);
                      if(await provider.changePassword(data: fields)){
                        Fluttertoast.showToast(
                          msg: "${LocaleKeys.change_password_screen_successHint.tr()}",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: kPrimaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0
                        );
                        _passwordController.text = '';
                        _passwordConfirmationController.text = '';
                        setState(() {
                          isPressed = false;
                        }); 
                      }else {
                        addError(error: "${LocaleKeys.change_password_screen_errorHint.tr()}");
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
    );
  }


  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: _passwordController,
      onChanged: (value){
        if(value.isNotEmpty){
          removeError(error: kPassNullError);
        }else if(value.length >= 8){
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value){
        if(value!.isEmpty){
          addError(error: kPassNullError);
          return "";
        }else if(value.length < 8){
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${LocaleKeys.change_password_screen_passwordLable.tr()}",
        hintText: "${LocaleKeys.change_password_screen_passwordHint.tr()}",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg",),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPasswordConfirmFormField() {
    return TextFormField(
      obscureText: true,
      controller: _passwordConfirmationController,
      onChanged: (value){
        if(_passwordController.text == value){
          removeError(error: kMatchPassError);
        }
        return null;
      },
      validator: (value){
        if(value!.isEmpty){
          return "";
        }else if(_passwordController.text != value){
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${LocaleKeys.change_password_screen_confirmPasswordLable.tr()}",
        hintText: "${LocaleKeys.change_password_screen_confirmPasswordHint.tr()}",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg",),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
  
}