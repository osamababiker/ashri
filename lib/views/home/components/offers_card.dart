import 'package:flutter/material.dart';
import 'package:ashri/controllers/productsController.dart';
import 'package:ashri/models/Offer.dart';
import 'package:ashri/models/Product.dart';
import 'package:ashri/size_config.dart';
import 'package:ashri/controllers/offersController.dart';
import 'package:ashri/views/details/details_screen.dart';
import 'package:ashri/views/offers/offers_screen.dart';
import '../../../constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ashri/utils/.env.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';

class OffersCard extends StatelessWidget {
  const OffersCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Container(
              width: size.width,
              height: getScreenSize(context) * 15.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.jpg"),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(
                  offset: Offset(0 , 2),
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 2
                )]
              ),
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Container(
                          width: getScreenSize(context) * 20.0,
                          height: getScreenSize(context) * 5.0,
                          child: Text(
                            "${LocaleKeys.home_screen_offers_banner.tr()}",
                            style: TextStyle(
                              fontSize: getScreenSize(context) * 1.8,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: kFontFamily
                            )
                          ),
                        ),
                        SizedBox(height: getScreenSize(context) * 1.5),
                        Container(
                          height: getScreenSize(context) * 4.0,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, OffersScreen.routeName);
                            },
                            child: Text(
                              "${LocaleKeys.home_screen_offers_banner_btn.tr()}",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white
                              )
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: getScreenSize(context) * 10.0,
                      height: getScreenSize(context) * 10.0,
                      child: SvgPicture.asset("assets/icons/discount.svg"),
                    )
                  ]
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            child: FutureBuilder<List>(
              future: fetchOffers(),
              builder: (context, snapshot){
                if(snapshot.hasData){ 
                  if(snapshot.data!.length != 0) 
                    return SizedBox(
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,  
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( 
                          crossAxisCount: 2, 
                          mainAxisSpacing: 0, 
                          crossAxisSpacing: kDefaultPadding / 2,
                          childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height)
                        ),
                        itemCount: snapshot.data!.length, 
                        itemBuilder: (context, index) {
                          return OfferCard(
                            offer: snapshot.data![index],
                          );
                        } 
                      ),
                    );
                  else return Text("");
                } else return Center(child: CircularProgressIndicator());
              }
            ),
          ),
        ],
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  const OfferCard({
    Key? key, 
    required this.offer,
  }) : super(key: key);

  final Offer offer;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<Product>(
      future: fetchSingleProduct(productId: offer.productId),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: size.width * 0.4,
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.jpg"),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(
                  offset: Offset(0 , 2),
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 2
                )]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: getScreenSize(context) * 7.0,
                    height: getScreenSize(context) * 6.0,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: FadeInImage.assetNetwork(
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/images/spinner.gif",
                          );
                        },
                        placeholder: "assets/images/spinner.gif", 
                        image: "$uploadUri/products/${snapshot.data!.images[0]}"
                      )
                    ) ,
                  ),
                  SizedBox(height: kDefaultPadding / 4),
                  Text(
                    "${context.locale}" == 'ar' ?  snapshot.data!.name : snapshot.data!.nameEn,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "${LocaleKeys.home_screen_offers_discountLabel.tr()}", 
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "${offer.offer}%",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Container(
                    width: getScreenSize(context) * 10.0,
                    height: getScreenSize(context) * 5.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [BoxShadow(
                        offset: Offset(0 , 2),
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 2
                      )]
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context, DetailsScreen.routeName,
                          arguments: snapshot.data
                        );
                      }, 
                      child: Text(
                        "${LocaleKeys.home_screen_offers_discountActionBtn.tr()}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12
                        ),
                      )
                    ),
                  ),
                ]
              ),
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

