

class User {
  int id;
  String name;
  String email;
  String phone;
  String address;
  String avatar; 
  int isVerify;
  List<dynamic> favorites;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.avatar,
    required this.favorites,
    required this.isVerify,
  });

  User.fromJson(Map<String, dynamic> json)
  :
    id = json['id'], 
    name = json['name'],
    email = json['email'],
    phone = json['phone'],
    avatar = json['avatar'],
    address = json['address'],
    favorites = json['favorites'],
    isVerify = json['isVerify'].toInt();
}
 

