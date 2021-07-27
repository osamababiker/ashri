import 'dart:convert';

class Order {
  final int id  , discount , userId , status; 
  final List cart;

  Order({
    required this.id, 
    required this.discount,
    required this.userId,
    required this.cart,
    required this.status,
  });


  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      status: json["status"],
      userId: json["userId"],
      cart: jsonDecode(json["cart"]), 
      discount: json["discount"],
    );
  }
}
