import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.h),
          topRight: Radius.circular(20.h),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(30.0.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0.h),
                  child: Image.asset(
                    'assets/images/plant.png',
                    height: 50.h,
                    width: 50.h,
                  ),
                ),
                Divider(
                  endIndent: 20.h,
                  indent: 20.h,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 20.h,
            child: Text(
              'App version 0.1.0',
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 20.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
