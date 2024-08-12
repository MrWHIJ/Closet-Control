import 'package:closet_control/features/calendar/outfit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutfitCard extends StatelessWidget {
  final Outfit outfit;

  const OutfitCard({super.key, required this.outfit});

  @override
  Widget build(BuildContext context) {
    int clothesCount = outfit.clothes.length;

    return Container(
      height: 150.h,
      width: 400.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 3.sp)]),
      child: Padding(
        padding: EdgeInsets.fromLTRB(6.w, 6.h, 6.w, 6.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: clothesCount,
                    itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6.sp),
                              topRight: Radius.circular(6.sp)),
                          child: Image.file(
                            outfit.clothes[index].image,
                            height: 100.h,
                            width: 140.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          width: 5.w,
                        ))),
            const Text(
              'Outfitname',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(clothesCount.toString() + 'Teile')
          ],
        ),
      ),
    );
  }
}
