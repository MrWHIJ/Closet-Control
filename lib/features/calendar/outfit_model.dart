import 'package:closet_control/features/closet/clothes_model.dart';

class Outfit {
  String id;
  List<Clothing> clothes;
  DateTime dateTime;

  Outfit({required this.id, required this.clothes, required this.dateTime});
}
