import 'package:flutter/material.dart';
import 'package:ashri/utils/cart_db_helper.dart';
import 'package:provider/provider.dart';
import 'package:ashri/controllers/authController.dart';
import 'package:ashri/route.dart';
import 'package:ashri/theme.dart'; 
import 'package:ashri/views/home/home_screen.dart';
import 'package:ashri/views/splash/splash_screen.dart';
import 'package:ashri/controllers/settingsController.dart';
import 'package:ashri/views/errors/no_internet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ashri/translations/codegen_loader.g.dart';
import 'package:ashri/translations/local_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';  
 
// flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations"
// flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "local_keys.g.dart" -f keys
Future main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  await EasyLocalization.ensureInitialized();
  
  runApp(
    MultiProvider( 
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => CartDatabaseHelper()), 
      ],
      child: EasyLocalization(
        path: 'assets/translations',
        supportedLocales: [Locale('en'), Locale('ar')],
        fallbackLocale: Locale('ar'),
        assetLoader: CodegenLoader(),
        child: MyApp()
      ), 
    ),
  );
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) { 
    return FutureBuilder( 
      future: fetchSetting(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: "${LocaleKeys.app_name.tr()}", 
            theme: theme(), 
            home: SplashScreen()
          );
        }  
        if(snapshot.hasError){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale, 
            title: "${LocaleKeys.app_name.tr()}",
            theme: theme(),  
            routes: routes,
            home: NoInternetScreen(),  
          );
        }
        else{
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale, 
            title: "${LocaleKeys.app_name.tr()}",
            theme: theme(),  
            routes: routes,
            home: HomeScreen(),  
          );
        }
      },
    );
  }
}

