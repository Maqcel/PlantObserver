import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:roslinki_politechnika/models/apiKey.dart';

class Plant with ChangeNotifier {
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

  Future<void> addPlant(Plant plant, String token) async {
    final String url = ApiKey.dataBaseUrl + "plants.json" + '?auth=$token';
    try {
      final response = await http
          .post(
            url,
            body: json.encode(
              {
                'description': plant.description,
                'storagePlace': plant.storagePlace,
                'hydrophilus': plant.hydrophilus,
                'photophilus': plant.photophilus,
                'fertility': plant.fertility,
                'prefferedTemperatureLeft': plant.prefferedTemperatureLeft,
                'prefferedTemperatureRight': plant.prefferedTemperatureRight,
                'name': plant.name,
                'urlImage': plant.urlImage,
              },
            ),
          )
          .timeout(Duration(seconds: 10));
      print(response.statusCode);
      notifyListeners();
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
      throw e;
    } on SocketException catch (e) {
      print('Socket Error: $e');
      throw e;
    } on Error catch (e) {
      print('General Error: $e');
      throw e;
    }
  }
}
