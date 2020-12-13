import 'package:flutter/material.dart';

class Plant {
  final String id;
  final String description;
  final bool storagePlace; //* true outside / false indoors
  final double hydrophilus;
  final double photophilus;
  final double fertility;
  final double prefferedTemperatureLeft;
  final double prefferedTemperatureRight;
  final String urlImage;
  final String name;

  Plant({
    @required this.id,
    @required this.description,
    @required this.storagePlace,
    @required this.hydrophilus,
    @required this.photophilus,
    @required this.fertility,
    @required this.prefferedTemperatureLeft,
    @required this.prefferedTemperatureRight,
    @required this.urlImage,
    @required this.name,
  });
}
