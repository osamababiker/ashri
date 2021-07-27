
import 'package:ashri/models/Category.dart';

class Slides {
  final int id;
  final String image;
  final Category category;

  Slides({
    required this.id,
    required this.image,
    required this.category
  });


  factory Slides.fromJson(Map<String, dynamic> json) {
    return Slides(
      id: json['id'],
      image: json["image"],
      category: Category.fromJson(json["category"]),
    );
  }
}
