import 'package:ashri/models/Product.dart';

class Favorites {
  final int id , productId , userId; 
  final Product product;

  Favorites({
    required this.id, 
    required this.productId,
    required this.userId,
    required this.product 
  });


  factory Favorites.fromJson(Map<String, dynamic> json) {
    return Favorites(
      id: json['id'],
      userId: json["userId"],
      productId: json["productId"], 
      product: Product.fromJson(json["product"])
    );
  }
}
