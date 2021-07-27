import 'package:flutter/material.dart';
import 'package:ashri/views/home/home_screen.dart';
import 'package:ashri/controllers/productsController.dart';
import 'package:ashri/views/details/details_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ashri/translations/local_keys.g.dart';
import '../../../utils/.env.dart';
import '../../../constants.dart';
import '../../../size_config.dart';


class Body extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return SearchBar();
  }
}


class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String query = "";
  TextEditingController _queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                controller: _queryController, 
                autofocus: true,
                onSubmitted: (value) { 
                  setState(() {
                    query = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "${LocaleKeys.search_hint_text.tr()}",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        query = '';
                        _queryController.text = '';
                        Navigator.of(context)
                        .pushNamedAndRemoveUntil(HomeScreen.routeName, (Route<dynamic> route) => false);
                      });
                    },
                    child: Icon(Icons.cancel_outlined)
                  ), 
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10
                  )
                )
              ),
            ),
          ),
          Container(
            height: getScreenSize(context) * 40.0,
            child: FutureBuilder<List>( 
              future: searchProductsByName(endPoint: '/products/search', query: query),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return new Center(
                    child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding / 2),
                      child: new CircularProgressIndicator(),
                    ),
                  );
                } 
                else 
                if(snapshot.hasData){
                  if(snapshot.data!.length > 0)
                    return ListView.builder(
                      itemBuilder: (context , index) => GestureDetector(
                        onTap: () { 
                          Navigator.pushNamed(
                            context, DetailsScreen.routeName,
                            arguments: snapshot.data![index]  
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: getScreenSize(context) * 6.0,
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
                                          image: "$uploadUri/products/${snapshot.data![index].images[0]}"
                                        )
                                      )
                                    ),
                                    SizedBox(width: kDefaultPadding / 2),
                                    Text(
                                      "${context.locale}" == 'ar' ?  snapshot.data![index].name 
                                      : snapshot.data![index].nameEn,
                                      style: TextStyle(
                                        color: kTextColor,
                                        fontSize: 16
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemCount: snapshot.data!.length,
                    );
                    // if snapshot has value but is empty
                  else 
                  return Padding(
                    padding: const EdgeInsets.all(kDefaultPadding / 2),
                    child: Text(
                      "${LocaleKeys.no_data_error.tr()}",
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 14
                      )
                    ),
                  );
                } 
                // if snapshot dosnt have data
                else 
                if(snapshot.hasError){
                  Padding(
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
                  padding: const EdgeInsets.only(top: kDefaultPadding),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}

