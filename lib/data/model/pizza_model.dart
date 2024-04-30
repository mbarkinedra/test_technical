import 'package:hive/hive.dart';

part 'pizza_model.g.dart';

@HiveType(typeId: 5)
class Pizza {
  @HiveField(0)
  int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String img;

  Pizza({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.img,
  });

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: json['id'],
      name: json['name'],
      price:  json['price'],
      description: json['description'],
      img: json['img'],
    );
  }
}
