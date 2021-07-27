
class Brands {
  final int id;
  final String name, nameEn, image;

  Brands({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.image,
  });


  factory Brands.fromJson(Map<String, dynamic> json) {
    return Brands(
      id: json['id'],
      name: json['name'],
      nameEn: json['name_en'],
      image: json["image"],
    );
  }
}
