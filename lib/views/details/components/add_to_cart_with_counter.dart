import 'package:flutter/material.dart';
import 'package:ashri/size_config.dart';
import 'package:ashri/models/Product.dart';
import 'package:ashri/utils/cart_db_helper.dart';
import 'package:ashri/views/components/default_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';

import '../../../constants.dart';

class AddToCartWithCounter extends StatefulWidget {
  final Product product;

  const AddToCartWithCounter({Key? key, required this.product}) : super(key: key);
  @override
  _AddToCartWithCounterState createState() => _AddToCartWithCounterState();
}

class _AddToCartWithCounterState extends State<AddToCartWithCounter> {
  int numOfItems = 1;
  String addToCartError = '';


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: getScreenSize(context) * 5.0,
                  height: getScreenSize(context) * 5.0,
                  child: GestureDetector(
                    onTap:  () {
                      setState(() {
                        if(widget.product.quantity > numOfItems){
                          numOfItems ++ ;
                        } else {
                          addToCartError = "${LocaleKeys.add_to_cart_quantity_error.tr()}";
                        }
                      });
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
                    numOfItems.toString().padLeft(2, "0"),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                SizedBox(
                  width: getScreenSize(context) * 5.0,
                  height: getScreenSize(context) * 5.0,
                  child: GestureDetector(
                    onTap:  () {
                      setState(() {
                        if(numOfItems != 1){
                          numOfItems -- ;
                        }
                        if(widget.product.quantity > numOfItems){
                          addToCartError = '';
                        } 
                      });
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
            SizedBox(height: kDefaultPadding  / 2),
            Padding(
              padding: const EdgeInsets.only(bottom: kDefaultPadding / 4),
              child: SizedBox(
                child: Text(
                  addToCartError,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14
                  )
                ),
              ),
            ),
            if(widget.product.isAvailable == 1)
              DefaultButton( 
                text: "${LocaleKeys.single_product_screen_addToCartBtn.tr()}", 
                press: () async{
                  var map = new Map<String, dynamic>();
                  map['productId']    = widget.product.id;
                  map['name']         = widget.product.name;
                  map['nameEn']       = widget.product.nameEn;
                  map['price']        = widget.product.price;
                  map['sellingPrice'] = widget.product.sellingPrice;
                  map['image']        = widget.product.images[0];
                  map['rating']       = widget.product.rating;
                  map['quantity']     = numOfItems;
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
                }
              ) 
              else 
              Container(
                width: double.infinity,
                height: getScreenSize(context) * 5.6,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Center(
                  child: Text(
                    "${LocaleKeys.product_not_available_error.tr()}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14
                    )
                  )
                )
            ),
            
          ],
        ),
      ),
    );
  } 

}

