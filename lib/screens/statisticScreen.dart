import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/models/customChart.dart';
import 'package:roslinki_politechnika/providers/plantsListProvider.dart';
import 'package:roslinki_politechnika/providers/userPlantProvider.dart';

class StatisticScreen extends StatelessWidget {
  static const String routeName = '/statisticScreen';
  final String plantId;
  final bool isUserPlant;
  const StatisticScreen(
      {Key key, @required this.plantId, @required this.isUserPlant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserPlant currentPlant;
    if (isUserPlant) {
      currentPlant = Provider.of<PlantsManagement>(context, listen: false)
          .userPlants
          .firstWhere((element) => element.id == plantId);
    }
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            Text(
              'Statystyki',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 60.h,
                  fontWeight: FontWeight.w600),
            ),
            isUserPlant
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: 669.h,
                    child: ListView(
                      children: [
                        customChart(
                          context,
                          "Stan nawozu",
                          currentPlant.arrFertility,
                          false,
                        ),
                        customChart(
                          context,
                          "Stan nawodnienia",
                          currentPlant.arrHydrophility,
                          false,
                        ),
                        customChart(
                          context,
                          "Stan naświetlenia",
                          currentPlant.arrPhotophility,
                          false,
                        ),
                        customChart(
                          context,
                          "Temperatura",
                          currentPlant.arrTemperature,
                          true,
                        ),
                      ],
                    ),
                  )
                : customChart(
                    context,
                    "Przykładowy wykres",
                    [
                      -15.0,
                      -10.0,
                      -8.4,
                      0.0,
                      4.0,
                      6.5,
                      9.0,
                      8.4,
                      12.0,
                      16.0,
                      14.0,
                      16.0,
                      17.0,
                      20.0,
                      22.0,
                      25.0,
                      23.0,
                      22.0,
                      26.0,
                      18.0,
                      17.0,
                      15.0,
                      10.0,
                      5.0,
                      0.0
                    ],
                    true,
                  ),
          ],
        ),
      ),
    );
  }
}
