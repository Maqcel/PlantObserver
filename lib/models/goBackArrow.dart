import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/providers/potDecorationProvider.dart';

Widget goBackArrow(BuildContext context, double fertilizer, double humidity) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pop();
      Provider.of<PotDecorationProvider>(context, listen: false)
          .dataUpdated(fertilizer, humidity);
    },
    child: Container(
      height: 35.h,
      width: 100.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          Text(
            'Wróć',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.h,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
