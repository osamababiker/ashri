import 'package:flutter/material.dart';
import 'package:ashri/views/filterBycategories/filter_by_category_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ashri/constants.dart';
import 'package:ashri/controllers/slidesController.dart';
import 'package:ashri/size_config.dart';
import 'package:ashri/utils/.env.dart';


class DiscountBanner extends StatefulWidget {
  @override
  _DiscountBannerState createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {

  int _current = 0;
  List slides = [];

  Future _getSlides () async {
    var list =  await fetchSlides();
    setState(() {
      slides = list;
    });
  }

  @override
  void initState() {
    super.initState();
    _getSlides();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: getScreenSize(context) * 30.0,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }
          ),
          items: slides.map((item) => Container(
            child: GestureDetector(
              onTap: () async{
                Navigator.pushNamed(context, 
                  FilterByCategoryScreen.routeName, 
                  arguments: item.category 
                ); 
              },
              child: Container( 
                width: getScreenSize(context) * size.width,
                child: FadeInImage.assetNetwork(
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/spinner.gif",
                    );
                  },
                  placeholder: "assets/images/spinner.gif", 
                  image: "$uploadUri/slides/${item.image}",  
                  fit: BoxFit.cover,
                  height: getScreenSize(context) * 30.0,
                )
              ),
            ),
          )).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: slides.map((url) {
            int index = slides.indexOf(url);
            return Container(
              width: getScreenSize(context) * 1.5,
              height: getScreenSize(context) * 0.5,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: _current == index
                  ? kPrimaryColor
                  : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}



