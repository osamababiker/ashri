import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ashri/controllers/authController.dart';
import 'package:ashri/controllers/productsController.dart';
import 'package:ashri/models/Product.dart';
import 'package:ashri/views/components/title_with_more_btn.dart';
import 'package:ashri/views/products/products_screen.dart';
import 'package:ashri/views/signin/sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:ashri/views/details/details_screen.dart';
import 'package:ashri/utils/.env.dart';
import '../../../size_config.dart';
import '../../../constants.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';

class ProductsCard extends StatelessWidget {
  const ProductsCard({
    Key? key,
    required this.sectionId,
    required this.sectionTitle
  }) : super(key: key);

  final int sectionId;
  final String sectionTitle; 
  

  @override
  Widget build(BuildContext context) {
    
    var provider = context.watch<Auth>();
 
    return FutureBuilder<List>( 
      future: fetchProducts(endPoint: '/products/sections/$sectionId'),  
      builder: (context, snapshot) {  
        if(snapshot.hasData){
          return Column(
            children: [
              TitleWithMoreBtn(
                title: sectionTitle, 
                press: () {
                  Navigator.pushNamed(context, 
                    ProductsScreen.routeName, 
                    arguments: sectionId 
                  ); 
                }, 
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row( 
                  children: List.generate(
                    snapshot.data!.length, 
                    (index) => ProductCard(
                      product: snapshot.data![index],
                      provider: provider,
                      press: (){
                        Navigator.pushNamed(
                          context, DetailsScreen.routeName,
                          arguments: snapshot.data![index]  
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
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

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key, 
    required this.product, 
    required this.press, 
    required this.provider, 
  }) : super(key: key);

  final Product product;
  final VoidCallback press;
  final provider;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;
  @override

  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: widget.press,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Stack(
          children: [ 
            Container(
              width: size.width * 0.4,
              height: getScreenSize(context) * 30.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: kTextColor.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width,
                      height: getScreenSize(context) * 12.0,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: FadeInImage.assetNetwork(
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/spinner.gif",
                            );
                          },
                          placeholder: "assets/images/spinner.gif", 
                          image: "$uploadUri/products/${widget.product.images[0]}"
                        )
                      )
                    ),
                    SizedBox(height: getScreenSize(context) * 2.0),
                    Container(
                      width: size.width,
                      height: getScreenSize(context) * 5.0,
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${context.locale}" == 'ar' ?  widget.product.name : widget.product.nameEn,
                              style: TextStyle(
                                color: kTextColor,
                                fontFamily: kFontFamily
                              )
                            )
                          ]
                        )
                      )
                    ),
                    SizedBox(height: getScreenSize(context) * 2.0),
                    SizedBox(
                      child: Text(
                        "${widget.product.sellingPrice} ${LocaleKeys.currency.tr()}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ),
                    widget.product.price != 0.0 ?
                    Stack(
                      children: [
                        Container(
                          child: Text(
                            "${widget.product.price} ${LocaleKeys.currency.tr()}",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 6,
                          child: Container(
                            width: 60,
                            height: 1.5,
                            color: kTextColor,
                          ),
                        )
                      ],
                    ) : Text(""),
                  ]
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () async{
                  if(widget.provider.authenticated){
                    var user = widget.provider.user;
                    Map data = { 
                      'productId': widget.product.id,
                      'userId': user.id,
                    };
                    if(await addToFavorites(data: data)){
                      setState(() {
                        isFavorite = true;
                      });
                    }                    
                  }else {
                    Navigator.pushNamed(context, SignInScreen.routeName); 
                  }
                },
                child: Container(
                  width: getScreenSize(context) * 3.0,
                  height: getScreenSize(context) * 3.0, 
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: isFavorite  
                      ? SvgPicture.asset("assets/icons/Heart_Icon_2.svg", color: Colors.red)
                      : SvgPicture.asset("assets/icons/Heart_Icon.svg")
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
