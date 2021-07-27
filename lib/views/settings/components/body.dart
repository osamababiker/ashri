import 'package:flutter/material.dart';
import 'package:ashri/constants.dart';
import 'package:ashri/controllers/settingsController.dart';
import 'package:ashri/models/Setting.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    return FutureBuilder<Setting>(
      future: fetchSetting(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${LocaleKeys.app_name.tr()} ${LocaleKeys.settings_screen_versionHint.tr()} ${snapshot.data!.appVersion}",
                          style: TextStyle(
                            fontSize: 16
                          )
                        ),
                        SizedBox(height: 15),
                        Text.rich(
                          TextSpan(
                            text: " ${LocaleKeys.settings_screen_emailHint.tr()} \n \n",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: "${snapshot.data!.email}" ,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                )
                              )
                            ]
                          )
                        ),
                        Divider(),
                        SizedBox(height: kDefaultPadding),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${context.locale}" == 'ar' ?
                              "تغيير كلمة المرور الى :"
                              : 
                              "change langauage to : "
                            ),
                            SizedBox(height: kDefaultPadding / 4),
                            Container(
                              child: ElevatedButton(
                                onPressed: () async {
                                  if("${context.locale}" == 'ar'){
                                    await context.setLocale(Locale('en'));
                                  } else {
                                    await context.setLocale(Locale('ar'));
                                  }
                                }, 
                                child: Text(
                                  "${context.locale}" == 'en' ?
                                  "arabic" 
                                  : 
                                  "الانجليزية",
                                  style: TextStyle(
                                    fontSize: 14
                                  ),
                                )
                              ),
                            ),
                          ],
                        ),
                      ]
                    ),
                  ),
                )
              ],
            ),
          );
        }else {
          if(snapshot.hasError){
            return Padding(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: Center(
                child: Text(
                  "${LocaleKeys.no_internet_meg1.tr()}, ${LocaleKeys.no_internet_meg2.tr()}",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 12
                  )
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            child: Center(child: CircularProgressIndicator())
          );
        }
      }
    );
  }
}