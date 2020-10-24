import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/models/plantsListView.dart';
import 'package:roslinki_politechnika/models/potDecoration.dart';
import 'package:roslinki_politechnika/providers/plantsListProvider.dart';
import 'package:roslinki_politechnika/providers/potDecorationProvider.dart';

class PlantDataScreen extends StatefulWidget {
  static const String routeName = '/plantDataScreen';
  final String plantId;

  PlantDataScreen(this.plantId);

  @override
  _PlantDataScreenState createState() => _PlantDataScreenState();
}

class _PlantDataScreenState extends State<PlantDataScreen> {
  @override
  Widget build(BuildContext context) {
    double fertilizerValue =
        Provider.of<PotDecorationProvider>(context, listen: true)
            .shouldPaintFertilizer;
    double humidityValue =
        Provider.of<PotDecorationProvider>(context, listen: true)
            .shouldPaintHumidity;
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              left: 20.h,
              top: 50.h,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Provider.of<PotDecorationProvider>(context, listen: false)
                      .dataUpdated();
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
                        'Go back',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.h,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0.h,
              top: 40.h,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(107, 190, 118, 1.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/nut.png',
                    color: Colors.white,
                    width: 30.h,
                  ),
                ),
                width: 80.h,
                height: 60.h,
              ),
            ),
            Positioned(
              top: 140.h,
              right: 20.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shortNameGetter(Provider.of<PlantsManagement>(context,
                            listen: false)
                        .plants
                        .firstWhere((element) => element.id == widget.plantId)
                        .name),
                    style: TextStyle(
                        fontSize: 50.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  _potData('Humidity', context, humidityValue),
                  _potData('Fertilizer', context, fertilizerValue),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 300.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70.h),
                    topLeft: Radius.circular(70.h),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: 10.h,
                        child: Transform.rotate(
                          angle: pi,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0.h,
                                  ),
                                  color: Color.fromRGBO(220, 220, 220, 1.0),
                                  borderRadius: BorderRadius.circular(10.h),
                                ),
                              ),
                              FractionallySizedBox(
                                heightFactor:
                                    0.4, //TODO make it gether the information about water left in tank
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(10.h),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _potData(String dataName, BuildContext context, double values) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 30.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$values%',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35.h,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              ' $dataName',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.h,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(
          width: 20.h,
        ),
        PotDecoration(
          dataName,
        ),
      ],
    ),
  );
}
