import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/animations/routeAnimation.dart';
import 'package:roslinki_politechnika/models/addPlantButton.dart';
import 'package:roslinki_politechnika/models/goBackArrow.dart';
import 'package:roslinki_politechnika/models/plantsListView.dart';
import 'package:roslinki_politechnika/models/potDecoration.dart';
import 'package:roslinki_politechnika/providers/plantsListProvider.dart';
import 'package:roslinki_politechnika/providers/potDecorationProvider.dart';
import 'package:roslinki_politechnika/screens/statisticScreen.dart';
import 'package:transparent_image/transparent_image.dart';

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
    String shortName = shortNameGetter(
        Provider.of<PlantsManagement>(context, listen: false)
            .plants
            .firstWhere((element) => element.id == widget.plantId)
            .name);
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
              //! data in this container should be gathered from sensor
              bottom: 0,
              child: Container(
                height: 300.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70.h),
                    //? added image in this region topLeft: Radius.circular(70.h),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50.h,
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
                                ),
                              ],
                            ),
                          ),
                        ),
                        _textSchemePercent(
                            10, true), //TODO change it later for value
                        _textSchemePercent(78, true),
                        _textSchemePercent(24, false),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _textSchemeLabels(' Woda ', null),
                        _textSchemeLabels('Światło', '✓'),
                        _textSchemeLabels('Temp.', '✓'),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                child: Container(
                  height: 90.h,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.h),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bar_chart_rounded,
                        color: Colors.white,
                      ),
                      Text(
                        'Statystyki',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.h,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    createRoute(
                      StatisticScreen(),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                child: Container(
                  height: 90.h,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: FractionallySizedBox(
                          heightFactor: 0.5,
                        ),
                      ),
                      Text(
                        'Informacje',
                        style: TextStyle(
                          fontSize: 20.h,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 3.h,
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(3.h),
                              topRight: Radius.circular(3.h),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {},
              ),
            ),
            Positioned(
              left: 20.h,
              top: 50.h,
              child: goBackArrow(
                  context,
                  Provider.of<PotDecorationProvider>(context, listen: false)
                      .dataUpdated),
            ),
            Positioned(
              right: 0.h,
              top: 40.h,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(107, 190, 118, 1.0),
                  ),
                  child: Center(
                    child: AddPlantButton(
                      pot: 40,
                      plus: 20,
                    ),
                  ),
                  width: 80.h,
                  height: 60.h,
                ),
              ),
            ),
            Positioned(
              top: 110.h,
              left: -160.h,
              child: ClipOval(
                child: Stack(
                  children: [
                    Container(
                      height: 450.h,
                      width: 420.h,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        strokeWidth: 3.h,
                      ),
                    ),
                    Container(
                      height: 450.h,
                      width: 420.h,
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: Provider.of<PlantsManagement>(context,
                                listen: false)
                            .plants
                            .firstWhere(
                                (element) => element.id == widget.plantId)
                            .urlImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 140.h,
              right: 20.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shortName,
                    style: TextStyle(
                        fontSize: shortName.length > 8 ? 30.h : 50.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  _potData('Wilgotność', context, humidityValue),
                  _potData('Nawóz', context, fertilizerValue),
                ],
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${values.toInt()}', //TODO change it later for value
                  style: TextStyle(
                      fontSize: 35.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 5.h,
                ),
                Text(
                  '%',
                  style: TextStyle(
                      fontSize: 30.h,
                      fontWeight: FontWeight.w100,
                      color: Colors.white),
                ),
              ],
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

Widget _textSchemePercent(double value, bool percent) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 25.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${value.toInt()}', //TODO change it later for value
          style: TextStyle(fontSize: 40.h, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 5.h,
        ),
        Text(
          percent ? '%' : '°C',
          style: TextStyle(fontSize: 30.h, fontWeight: FontWeight.w100),
        ),
      ],
    ),
  );
}

Widget _textSchemeLabels(String value, String label) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 25.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.normal),
        ),
        SizedBox(
          width: 5.h,
        ),
        Text(
          label != null ? '✓' : '',
          style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
