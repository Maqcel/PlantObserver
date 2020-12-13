import 'package:flutter/material.dart';

class PotDecorationProvider extends ChangeNotifier {
  double shouldPaintHumidity;
  double shouldPaintFertilizer;

  int leftEmptySpaceToPaintHumidity = 100;
  int leftEmptySpaceToPaintFertilizer = 100;

  void providerSetup(double fertilizer, double humidity) {
    this.shouldPaintFertilizer = fertilizer;
    this.shouldPaintHumidity = humidity;
  }

  void paintedHumidity() {
    this.shouldPaintHumidity--;
  }

  void paintedFertilizer() {
    this.shouldPaintFertilizer--;
  }

  void leftToBePaintedHumidity() {
    this.leftEmptySpaceToPaintHumidity--;
  }

  void leftToBePaintedFertilizer() {
    this.leftEmptySpaceToPaintFertilizer--;
  }

  void dataUpdated(double fertilizer, double humidity) {
    this.shouldPaintFertilizer = fertilizer;
    this.shouldPaintHumidity = humidity;

    this.leftEmptySpaceToPaintFertilizer = 100;
    this.leftEmptySpaceToPaintHumidity = 100;
  }
}
