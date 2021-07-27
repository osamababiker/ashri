import 'package:flutter/material.dart';
import 'package:ashri/models/Product.dart';
import 'package:ashri/views/details/details_screen.dart';
import 'package:ashri/constants.dart';
import 'package:ashri/controllers/authController.dart';
import 'package:ashri/controllers/productsController.dart';
import 'package:ashri/utils/.env.dart';
import 'package:ashri/utils/cart_db_helper.dart';
import 'package:ashri/views/signin/sign_in_screen.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';

import 'check_out_card.dart';


// ignore: must_be_immutable
class Body extends StatefulWidget {

  List cart;
  Body({required this.cart});

  @override
  _BodyState createState() => _BodyState();
}  

class _BodyState extends State<Body> {


  @override
  Widget build(BuildContext context) {

    var provider = context.watch<CartDatabaseHelper>();
    var authProvider = context.watch<Auth>();
    Size size = MediaQuery.of(context).size;

    if(widget.cart.length > 0)
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Column(
              children: List.generate(
                widget.cart.length, 
                (index) => Padding( 
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Product product = await fetchSingleProduct(productId: widget.cart[index].productId);
                          Navigator.pushNamed(
                            context, DetailsScreen.routeName,
                            arguments: product
                          );
                        },
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row( 
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: getScreenSize(context) * 8.8,
                                  child: AspectRatio(
                                    aspectRatio: 0.88,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: FadeInImage.assetNetwork(
                                          placeholder: "assets/images/spinner.gif", 
                                          image: "$uploadUri/products/${widget.cart[index].image}"
                                        )
                                      )
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan( 
                                        text: "${context.locale}" == 'ar' ?   widget.cart[index].name 
                                        :  widget.cart[index].nameEn,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontFamily: kFontFamily 
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: getScreenSize(context) * 1.0),
                                    Text.rich(
                                      TextSpan(
                                        text: " ${LocaleKeys.currency.tr()} ${widget.cart[index].sellingPrice}",
                                        style: TextStyle(color: kTextColor),
                                        children: [
                                          TextSpan( 
                                            text: " x${widget.cart[index].quantity}",
                                            style: TextStyle(color: kTextColor),
                                          )
                                        ]
                                      )
                                    ),
                                  ],
                                )
                              ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: getScreenSize(context) * 5.0,
                            height: getScreenSize(context) * 5.0,
                            child: GestureDetector(
                              onTap:  () async{
                                // check the product quantit
                                Product product = await fetchSingleProduct(productId: widget.cart[index].productId);
                                if(product.quantity < widget.cart[index].quantity + 1){
                                  print('product is out of stock');
                                } 
                                else {
                                  var map = new Map<String, dynamic>();
                                  map['productId']    = widget.cart[index].productId;
                                  map['name']         = widget.cart[index].name;
                                  map['nameEn']       = widget.cart[index].nameEn;
                                  map['price']        = widget.cart[index].price;
                                  map['sellingPrice'] = widget.cart[index].sellingPrice;
                                  map['image']        = widget.cart[index].image;
                                  map['rating']       = widget.cart[index].rating;
                                  map['quantity']     = widget.cart[index].quantity + 1;
                                  var db = new CartDatabaseHelper(); 
                                  await db.updateQuantity( 
                                    cartData: map, itemId: widget.cart[index].id
                                  );
                                }  
                              },
                              child: Container(
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white
                                ),
                                child: Icon(Icons.add),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                            child: Text(
                              widget.cart[index].quantity.toString().padLeft(2, "0"),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          SizedBox(
                            width: getScreenSize(context) * 5.0,
                            height: getScreenSize(context) * 5.0,
                            child: GestureDetector(
                              onTap:  () async{
                                int quantity;
                                if(widget.cart[index].quantity == 1){
                                  quantity = 1;
                                } else quantity = widget.cart[index].quantity - 1;
                                var map = new Map<String, dynamic>();
                                map['productId']    = widget.cart[index].productId;
                                map['name']         = widget.cart[index].name;
                                map['nameEn']         = widget.cart[index].nameEn;
                                map['price']        = widget.cart[index].price;
                                map['sellingPrice'] = widget.cart[index].sellingPrice;
                                map['image']        = widget.cart[index].image;
                                map['rating']       = widget.cart[index].rating;
                                map['quantity']     = quantity;
                                var db = new CartDatabaseHelper(); 
                                await db.updateQuantity(
                                  cartData: map, itemId: widget.cart[index].id
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white
                                ),
                                child: Icon(Icons.remove),
                              ),
                            ),
                          ),
                        ],
                      ), 
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async{
                                if(authProvider.authenticated){
                                  var user = authProvider.user;
                                  Map data = { 
                                    'productId': widget.cart[index].productId,
                                    'userId': user.id,
                                  };
                                  if(await addToFavorites(data: data)){
                                    Fluttertoast.showToast(
                                      msg: "${LocaleKeys.add_to_favorite_toast.tr()}",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: kPrimaryColor,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                    );
                                  }                    
                                }else {
                                  Navigator.pushNamed(context, SignInScreen.routeName); 
                                }
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: getScreenSize(context) * 2.0,
                                    height: getScreenSize(context) * 2.0,
                                    child: SvgPicture.asset("assets/icons/Heart_Icon.svg")
                                  ),
                                  SizedBox(width: getScreenSize(context) * 0.5),
                                  Text(
                                    "${LocaleKeys.cart_screen_addToFavoriteBtn.tr()}",
                                    style: TextStyle(
                                      color: kTextColor.withOpacity(0.7),
                                      fontSize: 12
                                    )
                                  )
                                ]
                              ),
                            ),
                            GestureDetector(
                              onTap: () async{ 
                                await provider.deleteItem(widget.cart[index].id);
                                setState(() {
                                  widget.cart.removeAt(index);
                                });
                                Fluttertoast.showToast(
                                  msg: "${LocaleKeys.delete_from_cart_toast.tr()}",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: kPrimaryColor,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                                );
                              }, 
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: getScreenSize(context) * 2.0,
                                    height: getScreenSize(context) * 2.0,
                                    child: SvgPicture.asset("assets/icons/Trash.svg", color: kTextColor)
                                  ),
                                  SizedBox(width: getScreenSize(context) * 0.5),
                                  Text(
                                    "${LocaleKeys.cart_screen_deleteBtn.tr()}",
                                    style: TextStyle(
                                      color: kTextColor.withOpacity(0.7),
                                      fontSize: 12
                                    )
                                  )
                                ]
                              ),
                            ),
                          ]
                        ),
                      ),
                      Divider(color: kTextColor.withOpacity(0.6))
                    ],
                  ) 
                ),
              )
            ),
            FutureBuilder(
              future: context.watch<CartDatabaseHelper>().getCartTotal(), 
              builder: (context, snapshot) { 
                if(snapshot.hasData){
                  return CheckOutCard(cartTotal: double.parse("${snapshot.data!}"));
                }
                return Center(child: CircularProgressIndicator());
              }
            )
          ],
        )
      ),
    );
    else return Center(
      child: Text(
        "${LocaleKeys.no_item_in_cart_error.tr()}",
        style: TextStyle(
          fontSize: 14,
          color: kTextColor
        )
      )
    );
  }
}

