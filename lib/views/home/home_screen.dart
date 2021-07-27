import 'package:ashri/constants.dart';
import 'package:flutter/material.dart';
import 'package:ashri/enums.dart';
import 'package:provider/provider.dart';
import 'package:ashri/utils/dynamic_links.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ashri/controllers/authController.dart';
import 'components/body.dart';
import 'package:ashri/views/components/custom_bottom_nav_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  
  @override
  _HomeScreenState createState() => _HomeScreenState(); 
}

class _HomeScreenState extends State<HomeScreen> {

  final DynamicLinkService _dynamicLinkService = DynamicLinkService();
  
  final storage = new FlutterSecureStorage();

  
  @override 
  void initState() {
    super.initState();
    readToken();
    _dynamicLinkService.retrieveDynamicLink(context);
    //FirebaseMessaging.instance.getToken().then((value) => print(value));
    FirebaseMessaging.instance.subscribeToTopic('all');
  } 


  void readToken() async {
    try{
      String token = await storage.read(key: 'token') as String;
      var provider = Provider.of<Auth>(context, listen: false);
      provider.tryToken(token: token);
    } catch(ex) {
      print(ex);
    } 
  }
  

  @override
  Widget build(BuildContext context) {

    return WillPopScope( 
      onWillPop: () async {
        final value = await showDialog(
          context: context, 
          builder: (context) { 
          return Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 4),
            child: AlertDialog(
              content: Text("${LocaleKeys.home_screen_leave_app_alert.tr()}"),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text("${LocaleKeys.home_screen_leave_app_alert_no.tr()}"),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      TextButton(
                        child: Text("${LocaleKeys.home_screen_leave_app_alert_yes.tr()}"),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        );
        return value == true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text( 
            "${LocaleKeys.home_screen_title.tr()}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white70
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Body(),
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      ),
    );
  }
}

