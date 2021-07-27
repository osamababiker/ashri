import 'package:ashri/models/Product.dart';

class Offer {
  final int id , productId;
  final String  offer;
  final Product product;

  Offer({
    required this.id, 
    required this.productId,
    required this.offer ,
    required this.product
  });


  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json["id"],
      offer: json["offer"],
      productId: json["productId"],
      product: Product.fromJson(json["product"])
    );
  }
}
