import 'package:flutter/material.dart';

class UserPlant {
  final String id;
  final double currentFertility;
  final double currentHydrophility;
  final double currentPhotophility;
  final double currentTemperature;
  final List<double> arrFertility;
  final List<double> arrHydrophility;
  final List<double> arrPhotophility;
  final List<double> arrTemperature;
  final double waterTank;

  UserPlant({
    @required this.currentFertility,
    @required this.currentHydrophility,
    @required this.currentPhotophility,
    @required this.currentTemperature,
    @required this.arrFertility,
    @required this.arrHydrophility,
    @required this.arrPhotophility,
    @required this.arrTemperature,
    @required this.waterTank,
    @required this.id,
  });
}
