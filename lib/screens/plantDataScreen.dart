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
import 'package:roslinki_politechnika/screens/informationScreen.dart';
import 'package:roslinki_politechnika/screens/statisticScreen.dart';
import 'package:transparent_image/transparent_image.dart';

class PlantDataScreen extends StatefulWidget {
  static const String routeName = '/plantDataScreen';
  final String plantId;
  final bool isUserPlant;
  PlantDataScreen({
    @required this.isUserPlant,
    @required this.plantId,
  });

  @override
  _PlantDataScreenState createState() => _PlantDataScreenState();
}

class _PlantDataScreenState extends State<PlantDataScreen> {
  void providerInit(BuildContext context) {
    Provider.of<PotDecorationProvider>(context, listen: false).providerSetup(
      Provider.of<PlantsManagement>(context, listen: false)
          .userPlants
          .firstWhere((element) => element.id == widget.plantId)
          .currentFertility,
      Provider.of<PlantsManagement>(context, listen: false)
          .userPlants
          .firstWhere((element) => element.id == widget.plantId)
          .currentHydrophility,
    );
  }

  @override
  void initState() {
    if (widget.isUserPlant) providerInit(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double swiatloText;
    double waterTank;
    double tempText;
    if (widget.isUserPlant) {
      swiatloText = Provider.of<PlantsManagement>(context, listen: false)
          .userPlants
          .firstWhere((element) => element.id == widget.plantId)
          .currentPhotophility;
      waterTank = Provider.of<PlantsManagement>(context, listen: false)
          .userPlants
          .firstWhere((element) => element.id == widget.plantId)
          .waterTank;
      tempText = Provider.of<PlantsManagement>(context, listen: false)
          .userPlants
          .firstWhere((element) => element.id == widget.plantId)
          .currentTemperature;
    }

    String shortName = shortNameGetter(
        Provider.of<PlantsManagement>(context, listen: false)
            .plants
            .firstWhere((element) => element.id == widget.plantId)
            .name);
    double fertilizerValue =
        Provider.of<PotDecorationProvider>(context, listen: false)
            .shouldPaintFertilizer;
    double humidityValue =
        Provider.of<PotDecorationProvider>(context, listen: false)
            .shouldPaintHumidity;
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
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
                    topLeft: widget.isUserPlant
                        ? Radius.circular(0)
                        : Radius.circular(70.h),
                    //? added image in this region topLeft: Radius.circular(70.h),
                  ),
                ),
                child: widget.isUserPlant == true
                    ? Column(
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
                                          color: Color.fromRGBO(
                                              220, 220, 220, 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.h),
                                        ),
                                      ),
                                      FractionallySizedBox(
                                        heightFactor:
                                            0.4, //TODO make it gether the information about water left in tank
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius:
                                                BorderRadius.circular(10.h),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              _textSchemePercent(waterTank, true),
                              _textSchemePercent(swiatloText, true),
                              _textSchemePercent(tempText, false),
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _textSchemeLabels(
                                  ' Woda ', waterTank > 30 ? '✓' : null),
                              _textSchemeLabels(
                                'Światło',
                                Provider.of<PlantsManagement>(context,
                                                listen: false)
                                            .plants
                                            .firstWhere((element) =>
                                                element.id == widget.plantId)
                                            .photophilus >
                                        swiatloText
                                    ? '✓'
                                    : null,
                              ),
                              _textSchemeLabels(
                                'Temp.',
                                Provider.of<PlantsManagement>(context,
                                                listen: false)
                                            .plants
                                            .firstWhere((element) =>
                                                element.id == widget.plantId)
                                            .prefferedTemperatureLeft >=
                                        tempText
                                    ? Provider.of<PlantsManagement>(context,
                                                    listen: false)
                                                .plants
                                                .firstWhere((element) =>
                                                    element.id ==
                                                    widget.plantId)
                                                .prefferedTemperatureRight <=
                                            tempText
                                        ? '✓'
                                        : null
                                    : null,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      )
                    : Container(),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
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
                      StatisticScreen(
                        isUserPlant: widget.isUserPlant,
                        plantId: widget.plantId,
                      ),
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
                onTap: () {
                  Navigator.of(context).push(
                    createRoute(
                      InformationScreen(
                        plantId: widget.plantId,
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: 20.h,
              top: 50.h,
              child: goBackArrow(context),
            ),
            !widget.isUserPlant
                ? Positioned(
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
                  )
                : Container(),
            widget.isUserPlant
                ? Positioned(
                    top: widget.isUserPlant ? 110.h : 170.h,
                    left: widget.isUserPlant ? -160.h : 0,
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
                  )
                : _showPlantPhoto(context, widget.plantId),
            widget.isUserPlant
                ? Positioned(
                    top: 140.h,
                    right: 20.h,
                    child: Container(
                      padding: EdgeInsets.all(10.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(15.h),
                      ),
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
                          _potData('Wilgotność', context, humidityValue,
                              widget.plantId),
                          _potData('Nawóz', context, fertilizerValue,
                              widget.plantId),
                        ],
                      ),
                    ),
                  )
                : Positioned(
                    top: 80.h,
                    // left: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      shortName,
                      style: TextStyle(
                          fontSize: shortName.length > 8 ? 30.h : 50.h,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

Widget _potData(
    String dataName, BuildContext context, double values, String plantId) {
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
                  '${values.toDouble().toStringAsFixed(0)}',
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
          choosenData: dataName,
          plantId: plantId,
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
          '${value.toInt()}',
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

Widget _showPlantPhoto(BuildContext context, String plantId) {
  return Positioned(
    top: 170.h,
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
              image: Provider.of<PlantsManagement>(context, listen: false)
                  .plants
                  .firstWhere((element) => element.id == plantId)
                  .urlImage,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    ),
  );
}
