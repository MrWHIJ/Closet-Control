import 'package:closet_control/features/closet/clothing_card.dart';
import 'package:closet_control/providers/clothes_provider.dart';
import 'package:closet_control/providers/outfit_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddItemToOutfitPage extends StatefulWidget {
  const AddItemToOutfitPage({super.key});

  @override
  State<AddItemToOutfitPage> createState() => _AddItemToOutfitPageState();
}

class _AddItemToOutfitPageState extends State<AddItemToOutfitPage> {
  @override
  Widget build(BuildContext context) {
    List allClothes = context.watch<ClothesProvider>().allClothes;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Kleidungsstück wählen'),
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GridView.builder(
                  clipBehavior: Clip.none,
                  itemCount: allClothes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 5,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  itemBuilder: (contex, index) {
                    return GestureDetector(
                      onTap: () {
                        context.read<OutfitProvider>().addItemToOutfit(
                            id: allClothes[index].id,
                            image: allClothes[index].image,
                            type: allClothes[index].type,
                            brand: allClothes[index].brand,
                            size: allClothes[index].size,
                            color: allClothes[index].color,
                            price: allClothes[index].price,
                            note: allClothes[index].note);
                        Navigator.pop(context);
                      },
                      child: ClothingCard(
                          id: allClothes[index].id,
                          image: allClothes[index].image,
                          type: allClothes[index].type,
                          brand: allClothes[index].brand,
                          size: allClothes[index].size,
                          color: allClothes[index].color,
                          price: allClothes[index].price,
                          note: allClothes[index].note),
                    );
                  },
                ),
              )
            ],
          )),
    ));
  }
}
