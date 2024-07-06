import 'dart:io';

import 'package:closet_control/features/closet/clothes_model.dart';
import 'package:flutter/material.dart';

class ClothesProvider extends ChangeNotifier {
  List<Clothing> allClothes = [];

  void addClothing(
      {required String id,
      required File image,
      required String name,
      required String brand,
      required String size,
      required String color}) async {
    allClothes.add(Clothing(
        id: id,
        image: image,
        name: name,
        brand: brand,
        size: size,
        color: color));
    notifyListeners();
  }
}
