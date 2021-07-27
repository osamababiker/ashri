 
class Cart {
  final String name , nameEn , image , rating, price , sellingPrice;
  final int id , productId , quantity;
 
  Cart({
    required this.id,
    required this.productId,
    required this.name, 
    required this.nameEn, 
    required this.image, 
    required this.price,
    required this.sellingPrice,
    required this.rating ,
    required this.quantity,
  });

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map["id"],
      productId: map["productId"],
      name: map["name"],
      nameEn: map["nameEn"],
      image: map["image"],
      price: map["price"],
      sellingPrice: map["sellingPrice"], 
      rating: map["rating"],
      quantity: map["quantity"]
    );
  } 


  Map<String, dynamic> toMap(){
      var map = new Map<String, dynamic>();
      map['id']           = id;
      map['productId']    = productId;
      map['name']         = name;
      map['nameEn']       = nameEn;
      map['price']        = price;
      map['image']        = image;
      map['rating']       = rating;
      map['sellingPrice'] = sellingPrice;
      map['quantity']     = quantity;
      return map;
  }
  
}
 