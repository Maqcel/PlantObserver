import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/models/goBackArrow.dart';
import 'package:roslinki_politechnika/providers/plantProvider.dart';
import 'package:roslinki_politechnika/providers/plantsListProvider.dart';

class InformationScreen extends StatelessWidget {
  static const String routeName = '/informationScreen';
  final String plantId;
  const InformationScreen({
    Key key,
    @required this.plantId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Plant> plants =
        Provider.of<PlantsManagement>(context, listen: false).plants;
    String desc =
        plants.firstWhere((element) => element.id == plantId).description;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).accentColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 20.h,
              top: 50.h,
              child: goBackArrow(context),
            ),
            Positioned(
              top: 100.h,
              child: Text(
                'Informacje',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 220.h,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 400.h,
                padding: EdgeInsets.all(10.h),
                decoration:
                    BoxDecoration(color: Color.fromRGBO(108, 206, 149, 1.0)),
                child: SingleChildScrollView(
                  child: Text(
                    desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.h,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Column(
                children: [
                  Container(
                    height: 90.h,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.h),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.wb_sunny_outlined,
                          color: Colors.white,
                          size: 40.h,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${plants.firstWhere((element) => element.id == plantId).photophilus}%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.h,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Światłolubność',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.h,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 90.h,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.h),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.grass_outlined,
                          color: Colors.white,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${plants.firstWhere((element) => element.id == plantId).fertility}%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.h,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Jakość gleby',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.h,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    height: 90.h,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.h),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.opacity_rounded,
                          color: Colors.white,
                          size: 40.h,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${plants.firstWhere((element) => element.id == plantId).hydrophilus}%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.h,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Wodolubność',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.h,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 90.h,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.h),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.thermostat_outlined,
                          color: Colors.white,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${plants.firstWhere((element) => element.id == plantId).prefferedTemperatureLeft}° - ${plants.firstWhere((element) => element.id == plantId).prefferedTemperatureRight}°',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.h,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Temperatura',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.h,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
