import 'dart:io';

import 'package:flutter/material.dart';

class Clothing {
  String id;
  File image;
  String type;
  String brand;
  String size;
  Color color;
  int price;
  String note;

  Clothing(
      {required this.id,
      required this.image,
      required this.type,
      required this.brand,
      required this.size,
      required this.color,
      required this.price,
      required this.note});
}
