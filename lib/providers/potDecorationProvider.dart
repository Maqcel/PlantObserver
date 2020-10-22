import 'package:flutter/cupertino.dart';

class PotDecorationProvider extends ChangeNotifier {
  double shouldPaintHumidity =
      23; //TODO change it with Provider<PlantUser> value in the state that should be see used in _colorLogicChooser
  double shouldPaintFertilizer =
      99; //TODO change it with Provider<PlantUser> value in the state that should be see used in _colorLogicChooser

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
    this.shouldPaintHumidity = 23; //! change it also
    this.shouldPaintFertilizer = 99; //! change it also

    this.leftEmptySpaceToPaintFertilizer = 100;
    this.leftEmptySpaceToPaintHumidity = 100;
  }
}
