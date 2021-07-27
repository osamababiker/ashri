import 'package:ashri/views/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ashri/controllers/productsController.dart';
import 'package:ashri/utils/cart_db_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../utils/.env.dart';



// ignore: must_be_immutable
class Body extends StatefulWidget {

  List favorites;
  Body({required this.favorites});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {

    if(widget.favorites.length != 0)
    return Padding( 
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: ListView.builder(
        itemCount: widget.favorites.length,
        itemBuilder: (context , index) => Padding(
          padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector( 
                      onTap: () {
                        Navigator.pushNamed(
                          context, DetailsScreen.routeName,
                          arguments: widget.favorites[index].product
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
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)
                                  ), 
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: FadeInImage.assetNetwork(
                                      imageErrorBuilder: (context, error, stackTrace) {
                                        return Image.asset(
                                          "assets/images/spinner.gif",
                                        );
                                      },
                                      placeholder: "assets/images/spinner.gif", 
                                      image: "$uploadUri/products/${widget.favorites[index].product.images[0]}"
                                    )
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: getScreenSize(context) * 1.5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text( 
                                  "${context.locale}" == 'ar' ?  widget.favorites[index].product.name 
                                  : widget.favorites[index].product.nameEn,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  )
                                ),
                                SizedBox(height: getScreenSize(context) * 1.0),
                                Text.rich(
                                  TextSpan(
                                    text: " ${widget.favorites[index].product.sellingPrice} ${LocaleKeys.currency.tr()}",
                                    style: TextStyle(
                                      color: kTextColor,
                                      fontSize: 14 
                                    ),
                                  )
                                ),
                                widget.favorites[index].product.price != 0.0 ?
                                Stack(
                                  children: [
                                    Container(
                                      child: Text(
                                        "${widget.favorites[index].product.price} ${LocaleKeys.currency.tr()}",
                                        style: TextStyle(
                                          fontSize: 14,
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
                                ): Text(""),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: ()  async{
                              var map = new Map<String, dynamic>();
                              map['productId']    = widget.favorites[index].product.id;
                              map['name']         = widget.favorites[index].product.name;
                              map['nameEn']       = widget.favorites[index].product.nameEn;
                              map['price']        = widget.favorites[index].product.price;
                              map['sellingPrice'] = widget.favorites[index].product.sellingPrice;
                              map['image']        = widget.favorites[index].product.images[0];
                              map['rating']       = widget.favorites[index].product.rating;
                              map['quantity']     = 1;
                              var db = new CartDatabaseHelper(); 
                              await db.addToCart(cartData: map);
                              Fluttertoast.showToast(
                                msg: "${LocaleKeys.add_to_cart_toast.tr()}",
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
                                Text(
                                  "${LocaleKeys.favorites_screen_addToCartBtn.tr()}",
                                  style: TextStyle(
                                    fontSize: 14
                                  ),
                                ),
                                SizedBox(width: 5),
                                SizedBox(
                                  width: getScreenSize(context) * 2.0,
                                  height: getScreenSize(context) * 2.0,
                                  child: SvgPicture.asset(
                                    "assets/icons/Cart_Icon.svg",
                                  ),
                                ),
                              ],
                            ),
                          ), 
                          GestureDetector(
                            onTap: () async{
                              await deleteFavorite(favoriteId: widget.favorites[index].id);
                              setState(() {
                                widget.favorites.removeAt(index);
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  "${LocaleKeys.favorites_screen_deleteBtn.tr()}",
                                  style: TextStyle(
                                    fontSize: 14
                                  ),
                                ),
                                SizedBox(width: 5),
                                SizedBox(
                                  width: getScreenSize(context) * 1.5,
                                  height: getScreenSize(context) * 1.5,
                                  child: SvgPicture.asset("assets/icons/Trash.svg", color: kTextColor),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Divider(color: kTextColor.withOpacity(0.4))
              ],
            ),
          ),
        )
      )
    );
    else return Center(
      child: Text(
        "${LocaleKeys.no_data_error.tr()}",
        style: TextStyle(
          fontSize: 16
        ),
      )
    );
  }
}

