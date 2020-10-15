import 'dart:math';

import 'package:flutter/material.dart';
import 'package:roslinki_politechnika/models/customAppBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roslinki_politechnika/models/customDrawer.dart';
import 'package:roslinki_politechnika/models/plantsListView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(),
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Text(
                    'My plants',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45.h,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                plantListView(),
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Explore',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 45.h,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      IconButton(
                        icon: ImageIcon(
                          AssetImage('assets/images/filters.png'),
                          size: 50.h,
                        ),
                        color: Colors.black,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                plantListView(),
                SizedBox(
                  height: 35.h,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 35.h,
            left: 20.h,
            child: Transform.rotate(
              angle: 180 * pi / 180,
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          Positioned(
            bottom: 18.h,
            left: 70.h,
            child: Container(
              alignment: Alignment.bottomLeft,
              width: 160.h,
              child: Text(
                'Adjust the watering of plants',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.h,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Positioned(
            right: 20.h,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/nut.png',
                  color: Colors.white,
                  width: 30.h,
                ),
              ),
              width: 60.h,
              height: (78.91).h,
            ),
          ),
        ],
      ),
    );
  }
}
