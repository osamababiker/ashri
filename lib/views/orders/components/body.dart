import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../utils/.env.dart';


// ignore: must_be_immutable
class Body extends StatefulWidget {

  List orders;
  Body({required this.orders});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    if(widget.orders.length != 0)
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: List.generate(
          widget.orders.length, 
          (index) => Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Container(
              width: size.width,
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${LocaleKeys.order_screen_orderStatus.tr()}",
                        style: TextStyle(
                          color: kTextColor.withOpacity(0.7),
                          fontSize: 14
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(kDefaultPadding / 4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: 
                          widget.orders[index].status == 1 ? Colors.amber 
                          : widget.orders[index].status == 2 ? Colors.amber 
                          : widget.orders[index].status == 3 ? Colors.green 
                          : widget.orders[index].status == 4 ? Colors.red 
                          : Colors.grey,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(
                          widget.orders[index].status == 1 ? "${LocaleKeys.orders_screen_Confirmed.tr()}"
                          : widget.orders[index].status == 2 ? "${LocaleKeys.orders_screen_inDelivery.tr()}"
                          : widget.orders[index].status == 3 ? "${LocaleKeys.orders_screen_delivered.tr()}" 
                          : widget.orders[index].status == 4 ? "${LocaleKeys.orders_screen_canceled.tr()}" 
                          : "${LocaleKeys.orders_screen_notConfirmed.tr()}",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Text(
                    " ${LocaleKeys.order_screen_products.tr()} : ", 
                    style: TextStyle(
                      color: kTextColor.withOpacity(0.7),
                      fontSize: 14
                    ),
                  ),
                  SizedBox(height: 15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(widget.orders[index].cart.length, (i) => Padding(
                        padding: const EdgeInsets.all(kDefaultPadding / 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.orders[index].cart[i]['name'],
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 14,
                                color: kTextColor
                              ),
                            ),
                            SizedBox(height: 5),
                            SizedBox(
                              width: getScreenSize(context) * 8.8,
                              child: AspectRatio(
                                aspectRatio: 0.88,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF5F6F9),
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
                                      image: "$uploadUri/products/${widget.orders[index].cart[i]['image']}"
                                    )
                                  ),
                                ),
                              ),
                            ), 
                          ],
                        ),
                      ))  
                    ),
                  ),
                  // Divider(),
                  // SizedBox(height: 10),
                  // GestureDetector(
                  //   onTap: () async{
                  //     await deleteOrders(orderId: widget.orders[index].id);
                  //     setState(() {
                  //       widget.orders.removeAt(index);
                  //     });
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         "حذف",
                  //         style: TextStyle(
                  //           color: kTextColor.withOpacity(0.5),
                  //           fontSize: 14
                  //         ),
                  //       ),
                  //       SizedBox(width: 5),
                  //       Container(
                  //         width: getScreenWidth(size.width, 25),
                  //         height: getScreenHeight(size.height, 25),
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10)
                  //         ),
                  //         child: SvgPicture.asset("assets/icons/Trash.svg",color: kTextColor)
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 15)
                ],
              ),
            ),
          ),
        ),
      )
    );
    else return Center(
      child: Text(
        "لا توجد طلبات لعرضها حاليا",
        style: TextStyle(
          fontSize: 16
        ),
      )
    );
  } 
}


