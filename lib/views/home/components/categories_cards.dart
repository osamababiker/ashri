import 'package:flutter/material.dart';
import 'package:ashri/views/filterByCategories/filter_by_category_screen.dart';
import 'package:ashri/controllers/categoriesController.dart';
import 'package:ashri/models/Category.dart';
import 'package:ashri/utils/.env.dart';
import '../../../size_config.dart';
import '../../../constants.dart';
import 'package:easy_localization/easy_localization.dart';


class CategoriesCard extends StatelessWidget {
  const CategoriesCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FutureBuilder<List>(
        future: fetchCategories(),
        builder: (context, snapshot)  {
          if(snapshot.hasData){ 
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                snapshot.data!.length, 
                (index) => CategoryCard(
                  category: snapshot.data![index],
                  press: (){ 
                    Navigator.pushNamed(context, 
                      FilterByCategoryScreen.routeName,
                      arguments: snapshot.data![index]
                    );
                  },
                )
              )
            );
          }
          return Text("");
        }
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key, 
    required this.category, 
    required this.press,
  }) : super(key: key);

  final Category category;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Column(
          children: [
            Container(
              width: getScreenSize(context) * 5.0, 
              height: getScreenSize(context) * 5.0, 
              decoration: BoxDecoration(
                border: Border.all(color: kPrimaryColor),
                shape: BoxShape.circle
              ),
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding / 4),
                child: FadeInImage.assetNetwork(
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/spinner.gif",
                    );
                  },
                  placeholder: "assets/images/spinner.gif", 
                  image: "$uploadUri/categories/${category.image}"
                )
              )
            ),
            SizedBox(height: 3),
            Text(
              "${context.locale}" == 'ar' ?  category.name : category.nameEn,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),
            )
          ],
        ),
      ),
    );
  }
}
