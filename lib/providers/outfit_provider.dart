import 'dart:io';

import 'package:closet_control/features/calendar/outfit_model.dart';
import 'package:closet_control/features/closet/clothes_model.dart';
import 'package:flutter/material.dart';

class OutfitProvider extends ChangeNotifier {
  List<Clothing> newOutfit = [];
  List<Outfit> allOutfits = [];

  void addItemToOutfit(
      {required String id,
      required File image,
      required String type,
      required String brand,
      required String size,
      required Color color,
      required int price,
      required String note}) async {
    newOutfit.add(Clothing(
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

  Future<void> addOutfitToAllOutfits({
    required String id,
    required List<Clothing> clothes,
    required DateTime dateTime,
  }) async {
    allOutfits.add(Outfit(id: id, clothes: clothes, dateTime: dateTime));
    notifyListeners();
  }

  void deleteItemFromOutfit({required String id}) async {
    newOutfit.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearNewOutfit() async {
    newOutfit.clear();
  }
}
