import 'package:flutter/material.dart';
import '../../../constants.dart';
import './item_card.dart';


class ProductsList extends StatelessWidget {

  const ProductsList({Key? key, required this.offers}) : super(key: key);
  final List offers;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding , vertical: kDefaultPadding / 2),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( 
            crossAxisCount: 2,
            mainAxisSpacing: kDefaultPadding,
            crossAxisSpacing: kDefaultPadding,
            childAspectRatio: 0.75,
          ),
          itemCount: offers.length,
          itemBuilder: (context , index) => ItemCard(
            offer: offers[index],
          )
        ) 
      )
    );
  }
}

