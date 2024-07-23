import 'dart:io';

import 'package:closet_control/features/closet/clothes_model.dart';
import 'package:flutter/material.dart';

class ClothesProvider extends ChangeNotifier {
  List<Clothing> allClothes = [];

  void addClothing(
      {required String id,
      required File image,
      required String type,
      required String brand,
      required String size,
      required Color color,
      required int price,
      required String note}) async {
    allClothes.add(Clothing(
        id: id,
        image: image,
        type: type,
        brand: brand,
        size: size,
        color: color,
        price: price,
        note: note));
    notifyListeners();
  }

  void editClothing(
      {required String id,
      required File image,
      required String type,
      required String brand,
      required String size,
      required Color color,
      required int price,
      required String note}) async {
    allClothes[allClothes.indexWhere((item) => item.id == id)] = Clothing(
        id: id,
        image: image,
        type: type,
        brand: brand,
        size: size,
        color: color,
        price: price,
        note: note);
    notifyListeners();
  }

  void deleteClothing({required String id}) async {
    allClothes.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}
