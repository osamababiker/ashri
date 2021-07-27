import 'package:ashri/controllers/productsController.dart';
import 'package:ashri/views/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:ashri/models/Product.dart';


class DynamicLinkService {

  Future<Uri> createDynamicLink({required int productId}) async {
    try{
      final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://ashri.page.link',
        link: Uri.parse('https://ashrisd.com/home?id=$productId'),
        androidParameters: AndroidParameters(
          packageName: 'com.example.ashri',
          minimumVersion: 0,
        ),
        iosParameters: IosParameters(
          bundleId: 'your_ios_bundle_identifier',
          minimumVersion: '0',
          appStoreId: '1498909115',
        ),
        socialMetaTagParameters:  SocialMetaTagParameters(
          title: 'اشري',
          description: 'اطلبي الان كل ما تحتاجين من ادوات ومستحضرات تجميل وعناية ',
        ),
      );      
      final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
      final Uri shortUrl = shortDynamicLink.shortUrl; 
      return shortUrl;
    } catch(ex){
      print(ex);
      throw Exception(ex);
    }
  }
  

  Future<void> retrieveDynamicLink(BuildContext context) async {
    try{
      final PendingDynamicLinkData data = (await FirebaseDynamicLinks.instance.getInitialLink())!;
      Uri deepLink = data.link;

      if (deepLink != null) {
        if (deepLink.queryParameters.containsKey('id')) {
          String productId = deepLink.queryParameters['id']!;  
          Product product;
          product = await fetchSingleProduct(productId: int.parse(productId));
          Navigator.pushNamed(
            context, DetailsScreen.routeName,
            arguments: product
          );
        }
      }

      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData? dynamicLink) async {
        final Uri? deepLink = dynamicLink?.link;
        Navigator.pushNamed(context, deepLink!.path);
      }, onError: (OnLinkErrorException e) async {
        print('onLinkError');
        print(e.message);
      });
    } catch(ex){
      print(ex);
    }
  }
}