import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget plantListView() {
  return Container(
    height: 180.h,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          width: (160.0).h,
          color: Colors.red,
        ),
        Container(
          width: (160.0).h,
          color: Colors.blue,
        ),
        Container(
          width: (160.0).h,
          color: Colors.green,
        ),
        Container(
          width: (160.0).h,
          color: Colors.yellow,
        ),
        Container(
          width: (160.0).h,
          color: Colors.orange,
        ),
      ],
    ),
  );
}
