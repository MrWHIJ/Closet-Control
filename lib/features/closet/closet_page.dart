import 'package:closet_control/features/closet/clothing_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClosetPage extends StatefulWidget {
  const ClosetPage({super.key});

  @override
  State<ClosetPage> createState() => _ClosetPageState();
}

class _ClosetPageState extends State<ClosetPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  clipBehavior: Clip.none,
                  itemCount: 8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 5,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  itemBuilder: (contex, index) {
                    return const ClothingCard();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
