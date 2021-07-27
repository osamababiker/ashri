import 'dart:convert';
 
class Product {
  final int id , categoryId;
  final String name , nameEn , description , descriptionEn ;
  final List images ;
  final double rating, price , sellingPrice;
  final int isAvailable , quantity;
 
  Product({
    required this.id,
    required this.categoryId,
    required this.images,
    required this.rating,
    required this.isAvailable,
    required this.name,
    required this.nameEn,
    required this.price,
    required this.sellingPrice,
    required this.description,
    required this.descriptionEn,
    required this.quantity,
  });



  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id:             json["id"],
      categoryId:     json["categoryId"],
      name:           json["name"],
      nameEn:         json["name_en"],
      price:          json["price"] == null ? 0.0 : json["price"].toDouble(),
      sellingPrice:   json["sellingPrice"].toDouble(),
      description:    json["description"], 
      descriptionEn:  json["description_en"], 
      rating:         json['rating'].toDouble(),
      images:         jsonDecode(json['images']),
      isAvailable:    json['isAvailable'],
      quantity:    json['quantity'],
    );
  } 


}



