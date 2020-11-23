import 'dart:math';

import 'package:flutter/material.dart';

class PotDecorationProvider extends ChangeNotifier {
  double shouldPaintHumidity =
      75; //TODO change it with Provider<PlantUser> value in the state that should be see used in _colorLogicChooser
  double shouldPaintFertilizer =
      12; //TODO change it with Provider<PlantUser> value in the state that should be see used in _colorLogicChooser

  int leftEmptySpaceToPaintHumidity = 100;
  int leftEmptySpaceToPaintFertilizer = 100;

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

  void dataUpdated() {
    this.shouldPaintHumidity = 75;
    //! change it also
    this.shouldPaintFertilizer = 12;
    //! change it also

    this.leftEmptySpaceToPaintFertilizer = 100;
    this.leftEmptySpaceToPaintHumidity = 100;
  }
}
