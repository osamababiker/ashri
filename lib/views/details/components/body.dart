import 'package:ashri/utils/dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:ashri/constants.dart';
import 'package:ashri/controllers/authController.dart';
import 'package:ashri/controllers/productsController.dart';
import 'package:ashri/views/signin/sign_in_screen.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';
import 'add_to_cart_with_counter.dart';
import 'product_images.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'package:ashri/models/Product.dart';
import 'similar_product_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';


class Body extends StatefulWidget {

  Body({
    Key? key, required this.product, 
  }) : super(key: key);

  final Product product;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  bool isFavorite = false;


  final DynamicLinkService _dynamicLinkService = DynamicLinkService();

  @override
  Widget build(BuildContext context) {

    var provider = context.watch<Auth>();
    
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              ProductImages(product: widget.product),
              Positioned(
                top: 80,
                left: 10,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async{
                        if(provider.authenticated){
                          var user = provider.user;
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
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle
                        ),
                        width: 25,
                        height: 25,
                        child: Padding(
                          padding: const EdgeInsets.all(kDefaultPadding / 4),
                          child: SvgPicture.asset(
                            !isFavorite ? 
                            "assets/icons/Heart_Icon.svg"
                            : "assets/icons/Heart_Icon_2.svg", 
                            color: isFavorite ? Colors.red : kTextColor
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: getScreenSize(context) * 0.5),
                    GestureDetector( 
                      onTap: () async{
                        Uri link = await _dynamicLinkService.createDynamicLink(productId: widget.product.id);
                        Share.share("$link");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle
                        ),
                        width: 25,
                        height: 25,
                        child: Padding(
                          padding: const EdgeInsets.all(kDefaultPadding / 4),
                          child: SvgPicture.asset("assets/icons/share.svg", color: kTextColor)
                        ),
                      ),
                    )
                  ]
                ),
              )
            ]
          ),
          TopRoundedContainer(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.product.sellingPrice} ${LocaleKeys.currency.tr()}",
                    style:  TextStyle(
                      fontSize: 16,
                      fontFamily: kFontFamily,
                      fontWeight: FontWeight.bold,
                      color: kTextColor
                    ),
                  ),
                  SizedBox(width: kDefaultPadding / 2),
                  widget.product.price != 0.0 ?
                  Stack(
                    children: [
                      Container(
                        child: Text(
                          "${widget.product.price} ${LocaleKeys.currency.tr()}",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 6,
                        child: Container(
                          width: 80,
                          height: 1.5,
                          color: kTextColor,
                        ),
                      )
                    ],
                  ):  Text(""),
                ] 
              ),
            ),
          ),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(product: widget.product),
                TopRoundedContainer(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(kDefaultPadding / 2),
                    child: Column(
                      children: [
                        TopRoundedContainer(
                          color: Color(0xFFF6F7F9),
                          child: AddToCartWithCounter(product: widget.product),
                        ),
                      ],
                    )
                  ),
                ),
                SizedBox(height: 30),
                TopRoundedContainer(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(kDefaultPadding / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${LocaleKeys.single_product_screen_similar_products.tr()}",
                          style: TextStyle(
                            fontSize: 16,
                            color: kTextColor
                          )
                        ),
                        SizedBox(height: 30),
                        FutureBuilder<List>(
                          future: fetchProducts(endPoint: '/products/categories/${widget.product.categoryId}'),
                          builder: (context, snapshot){
                            if(snapshot.hasData){
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    snapshot.data!.length, 
                                    (index) => SimilarProductCard(
                                      productId: widget.product.id,
                                      numOfProducts: snapshot.data!.length,
                                      product: snapshot.data![index]
                                    )
                                  )
                                ),
                              );
                            }else return Center(child: CircularProgressIndicator());
                          }
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}






