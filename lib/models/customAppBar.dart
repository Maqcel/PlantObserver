import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    shadowColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    title: Image.asset(
      'assets/images/plant.png',
      height: 40.h,
    ),
  );
}
