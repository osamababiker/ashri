
class Category {
  final int id;
  final String parentId;
  final String name , nameEn ,  image;

  Category({
    required this.id, 
    required this.name,
    required this.nameEn,
    required this.image,
    required this.parentId 
  });


  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      parentId: json["parentId"].toString(),
      name: json["name"],
      nameEn: json["name_en"],
      image: json["image"],
    );
  }
}
