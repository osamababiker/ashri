import 'package:ashri/models/Brands.dart';
import 'package:flutter/material.dart';
import 'package:ashri/controllers/brandsController.dart';
import 'package:ashri/controllers/categoriesController.dart';
import 'package:ashri/controllers/productsController.dart';
import 'package:ashri/views/details/details_screen.dart';
import 'filter_by_price_dialoge.dart';
import 'item_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';

import '../../../constants.dart';
import '../../../size_config.dart';


class ProductsList extends StatefulWidget {
  const ProductsList({
    Key? key, 
    required this.products,
    required this.brand
  }) : super(key: key);

  final List products; 
  final Brands brand;

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {

  List products = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    products = widget.products;
  }
  

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: kDefaultPadding / 2),
          Container(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${LocaleKeys.shop_by_brand_screen_browsByBrandTitle.tr()}",
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
                SizedBox(height: 15),
                SingleChildScrollView( 
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: getScreenSize(context) * 4.0,
                        height: getScreenSize(context) * 4.0,
                        child: GestureDetector(
                          onTap: () async {
                            List filtredProducts = [];
                            await showDialog(
                              context: context, 
                              builder: (BuildContext context){
                                return SortByPriceDialogBox();
                              }
                            ).then((action) async{
                              if(action == 'DESC'){
                                setState(() => isLoading = true); 
                                Map data = {
                                  'brandId': widget.brand.id,
                                  'order': 'DESC'
                                };
                                filtredProducts = await filterProducts(
                                  endPoint: "/products/filter",
                                  data: data
                                );
                                setState(() {    
                                  products = filtredProducts;  
                                  isLoading = false;
                                }); 
                              } else if(action == 'ASC'){
                                setState(() => isLoading = true); 
                                Map data = {
                                  'brandId': widget.brand.id,
                                  'order': 'ASC'
                                };
                                filtredProducts = await filterProducts(
                                  endPoint: "/products/filter",
                                  data: data
                                );
                                setState(() {    
                                  products = filtredProducts;  
                                  isLoading = false;
                                });
                              }
                            });
                          },
                          child: Icon(Icons.filter_list)
                        ),
                      ), 
                      SizedBox(width: 5),
                      FutureBuilder<List>( 
                        future: fetchBrands(), 
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            return Row(
                              children: [
                                ...List.generate(snapshot.data!.length, (index) => GestureDetector(
                                  onTap: () async{
                                    Map data = {
                                      'brandId': snapshot.data![index].id
                                    };
                                    setState(() {
                                      isLoading = true;
                                    });
                                    List filtredProducts = await filterProducts(
                                      endPoint: "/products/filter",
                                      data: data
                                    ); 
                                    setState(() {    
                                      products = filtredProducts;  
                                      isLoading = false;   
                                    }); 
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(kDefaultPadding / 4),
                                    child: Container(
                                      height: getScreenSize(context) * 4.0,
                                      padding: EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: kPrimaryLightColor,
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Text(
                                        "${context.locale}" == 'ar' ?  snapshot.data![index].name 
                                        : snapshot.data![index].nameEn,
                                        style: TextStyle(
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                  ),
                                )
                              ],
                            );
                          }else {
                            if(snapshot.hasError){
                              return Padding(
                                padding: const EdgeInsets.all(kDefaultPadding / 2),
                                child: Center(
                                  child: Text(
                                    "${LocaleKeys.no_data_error.tr()}",
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${LocaleKeys.shop_by_brand_screen_browsByCategoryTitle.tr()}",
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
                SizedBox(height: 15),
                SingleChildScrollView( 
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: getScreenSize(context) * 4.0,
                        height: getScreenSize(context) * 4.0,
                        child: GestureDetector(
                          onTap: () async {
                            List filtredProducts = [];
                            await showDialog(
                              context: context, 
                              builder: (BuildContext context){
                                return SortByPriceDialogBox();
                              }
                            ).then((action) async{
                              if(action == 'DESC'){
                                setState(() => isLoading = true); 
                                Map data = {
                                  'brandId': widget.brand.id,
                                  'order': 'DESC'
                                };
                                filtredProducts = await filterProducts(
                                  endPoint: "/products/filter",
                                  data: data
                                );
                                setState(() {    
                                  products = filtredProducts;  
                                  isLoading = false;
                                }); 
                              } else if(action == 'ASC'){
                                setState(() => isLoading = true); 
                                Map data = {
                                  'brandId': widget.brand.id,
                                  'order': 'ASC'
                                };
                                filtredProducts = await filterProducts(
                                  endPoint: "/products/filter",
                                  data: data
                                );
                                setState(() {    
                                  products = filtredProducts;  
                                  isLoading = false;
                                }); 
                              }
                            }); 
                          },
                          child: Icon(Icons.filter_list)
                        ),
                      ),
                      SizedBox(width: 5),
                      FutureBuilder<List>( 
                        future: fetchCategories(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            return Row(
                              children: [
                                ...List.generate(snapshot.data!.length, (index) => GestureDetector(
                                  onTap: () async{
                                    Map data = {
                                      'categoryId': snapshot.data![index].id
                                    };
                                    setState(() {
                                      isLoading = true;
                                    });
                                    List filtredProducts = await filterProducts(
                                      endPoint: "/products/filter",
                                      data: data
                                    ); 
                                    setState(() {    
                                      products = filtredProducts;  
                                      isLoading = false;   
                                    }); 
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(kDefaultPadding / 4),
                                    child: Container(
                                      height: getScreenSize(context) * 4.0,
                                      padding: EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: kPrimaryLightColor,
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Text( 
                                        "${context.locale}" == 'ar' ?  snapshot.data![index].name 
                                        : snapshot.data![index].nameEn,
                                        style: TextStyle(
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                )
                              ],
    
                            );
                          }else {
                            if(snapshot.hasError){
                              return Padding(
                                padding: const EdgeInsets.all(kDefaultPadding / 2),
                                child: Center(
                                  child: Text(
                                    "${LocaleKeys.no_data_error.tr()}",
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          !isLoading ? 
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding , vertical: kDefaultPadding / 2),
              child: products.length != 0 ? 
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true, 
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( 
                  mainAxisSpacing: kDefaultPadding,
                  crossAxisSpacing: kDefaultPadding,
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height)
                ),
                itemCount: products.length,
                itemBuilder: (context , index) => ItemCard(
                  product: products[index],
                  press: () => Navigator.pushNamed(
                    context, DetailsScreen.routeName,
                    arguments: products[index]
                  ), 
                )
              ) : 
              Center(
                child: Text(
                  "${LocaleKeys.no_data_error.tr()}",
                  style: TextStyle(
                    fontSize: 16
                  ),
                )
              )
            )
          ) : 
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding, horizontal: kDefaultPadding / 2),
            child: Center(child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }
}

