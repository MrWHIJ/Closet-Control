import 'dart:io';

import 'package:closet_control/core/edit_clothing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClothingCard extends StatelessWidget {
  final String id;
  final File image;
  final String type;
  final String brand;
  final String size;
  final Color color;
  final int price;
  final String note;

  const ClothingCard(
      {super.key,
      required this.id,
      required this.image,
      required this.type,
      required this.brand,
      required this.size,
      required this.color,
      required this.price,
      required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditClothingPage(
                id: id,
                image: image,
                type: type,
                brand: brand,
                size: size,
                color: color,
                price: price,
                note: note)));
      },
      child: Container(
        height: 120.h,
        width: 100.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.sp),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 3.sp)]),
        child: Padding(
          padding: EdgeInsets.fromLTRB(6.w, 6.h, 6.w, 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.sp),
                    topRight: Radius.circular(6.sp)),
                child: Image.file(
                  image,
                  height: 100.h,
                  width: 200.w,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                type,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(brand),
              Icon(
                Icons.schedule,
                size: 16.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
