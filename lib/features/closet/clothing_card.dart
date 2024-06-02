import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClothingCard extends StatelessWidget {
  const ClothingCard({super.key});

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
            // Container(
            //   height: 100.h,
            //   width: 200.w,
            //   decoration: BoxDecoration(
            //       color: Colors.black,
            //       borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(6.sp),
            //           topRight: Radius.circular(6.sp))),
            // ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.sp),
                  topRight: Radius.circular(6.sp)),
              child: Image.asset(
                height: 100.h,
                width: 200.w,
                'assets/clothes/tshirt.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const Text(
              'Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Marke'),
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
