import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customChart(
    BuildContext context, String label, List<double> dataToShow, bool isTemp) {
  List<FlSpot> spots;
  if (dataToShow != null) {
    spots = dataToShow.asMap().entries.map(
      (e) {
        return FlSpot(e.key.toDouble(), e.value);
      },
    ).toList();
  }
  String prefix = isTemp ? '°C' : '%';
  return Padding(
    padding: EdgeInsets.all(10.h),
    child: Container(
      width: 0.8 * MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.h), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
            child: Container(
              child: Text(
                //*LABEL HERE
                label,
                style: TextStyle(
                  fontSize: 30.h,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
            width: 0.8 * MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  width: 0.75 * MediaQuery.of(context).size.width,
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      minY: isTemp ? -20 : 0,
                      maxX: 24,
                      maxY: isTemp ? 50 : 100,
                      gridData: FlGridData(
                        show: true,
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          spots: spots,
                        ),
                      ],
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 25.h,
                          getTitles: (value) {
                            switch (value.toInt()) {
                              case 0:
                                return '00:00';
                              case 6:
                                return '06:00';
                              case 12:
                                return '12:00';
                              case 18:
                                return '18:00';
                              case 24:
                                return '24:00';
                            }
                            return '';
                          },
                        ),
                        leftTitles: SideTitles(
                            showTitles: true,
                            getTitles: (value) {
                              switch (value.toInt()) {
                                case -20:
                                  return '-20$prefix';
                                case -10:
                                  return '-10$prefix';
                                case 0:
                                  return '0$prefix';
                                case 10:
                                  return '10$prefix';
                                case 20:
                                  return '20$prefix';
                                case 30:
                                  return '30$prefix';
                                case 40:
                                  return '40$prefix';
                                case 50:
                                  return '50$prefix';
                                case 60:
                                  return '60$prefix';
                                case 70:
                                  return '70$prefix';
                                case 80:
                                  return '80$prefix';
                                case 90:
                                  return '90$prefix';
                                case 100:
                                  return '100$prefix';
                              }
                              return '';
                            },
                            reservedSize: 45.h),
                      ),
                    ),
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
