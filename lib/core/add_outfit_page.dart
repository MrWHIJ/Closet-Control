import 'package:closet_control/core/add_item_to_outfit_page.dart';
import 'package:closet_control/core/edit_clothing_page.dart';
import 'package:closet_control/features/closet/clothes_model.dart';
import 'package:closet_control/features/closet/clothing_card.dart';
import 'package:closet_control/providers/clothes_provider.dart';
import 'package:closet_control/providers/outfit_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddOutfitPage extends StatefulWidget {
  const AddOutfitPage({super.key});

  @override
  State<AddOutfitPage> createState() => _AddOutfitPageState();
}

class _AddOutfitPageState extends State<AddOutfitPage> {
  late DateTime _selectedDate;
  var uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
  }

  @override
  Widget build(BuildContext context) {
    List<Clothing> newOutfit = context.watch<OutfitProvider>().newOutfit;
    List allClothes = context.watch<ClothesProvider>().allClothes;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Neues Outfit'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddItemToOutfitPage()));
            },
            heroTag: null,
            child: const Icon(
              Icons.add,
              size: 32,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          FloatingActionButton(
            onPressed: () async {
              await context.read<OutfitProvider>().addOutfitToAllOutfits(
                  id: uuid.v4(), clothes: newOutfit, dateTime: _selectedDate);
              // context.read<OutfitProvider>().clearNewOutfit();
              Navigator.pop(context);
            },
            heroTag: null,
            child: const Icon(
              Icons.check,
              size: 32,
            ),
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                      '${_selectedDate.year} - ${_selectedDate.month} - ${_selectedDate.day}'),
                  Text(_selectedDate.toString()),
                  ElevatedButton(
                      onPressed: () async {
                        final DateTime? dateTime = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime.utc(2000, 1, 1),
                            lastDate: DateTime.utc(3000, 1, 1));
                        if (dateTime != null) {
                          setState(() {
                            _selectedDate = dateTime;
                          });
                        }
                      },
                      child: const Text('Choose date'))
                ],
              ),
              Expanded(
                child: GridView.builder(
                  clipBehavior: Clip.none,
                  itemCount: newOutfit.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 5,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditClothingPage(
                                id: allClothes[index].id,
                                image: allClothes[index].image,
                                type: allClothes[index].type,
                                brand: allClothes[index].brand,
                                size: allClothes[index].size,
                                color: allClothes[index].color,
                                price: allClothes[index].price,
                                note: allClothes[index].note)));
                      },
                      onLongPress: () {
                        context
                            .read<OutfitProvider>()
                            .deleteItemFromOutfit(id: newOutfit[index].id);
                      },
                      child: ClothingCard(
                          id: newOutfit[index].id,
                          image: newOutfit[index].image,
                          type: newOutfit[index].type,
                          brand: newOutfit[index].brand,
                          size: newOutfit[index].size,
                          color: newOutfit[index].color,
                          price: newOutfit[index].price,
                          note: newOutfit[index].note),
                    );
                  },
                ),
              )
            ],
          )),
    ));
  }
}
