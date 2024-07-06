import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClothingCard extends StatelessWidget {
  final File image;
  final String name;
  final String brand;
  final String size;
  final String color;

  const ClothingCard(
      {super.key,
      required this.image,
      required this.name,
      required this.brand,
      required this.size,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              name,
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
    );
  }
}
