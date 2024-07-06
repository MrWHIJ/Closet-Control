import 'dart:io';

class Clothing {
  String id;
  File image;
  String name;
  String brand;
  String size;
  String color;

  Clothing(
      {required this.id,
      required this.image,
      required this.name,
      required this.brand,
      required this.size,
      required this.color});
}
