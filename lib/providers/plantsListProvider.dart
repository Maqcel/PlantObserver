import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:roslinki_politechnika/models/apiKey.dart';

import 'plantProvider.dart';

class PlantsManagement with ChangeNotifier {
  List<Plant> _plants = [];

  List<Plant> get plants {
    return [..._plants]; //? creates copy of the list
  }

  Future<void> getPlants() async {
    try {
      final response = await http
          .get(ApiKey.dataBaseUrl + 'plants.json')
          .timeout(Duration(seconds: 5));
      final decodedData = json.decode(response.body) as Map<String, dynamic>;
      if (decodedData == null) {
        print('Response body is null');
        throw NullThrownError;
      }
      final List<Plant> temporary = [];

      decodedData.forEach((plantId, plant) {
        temporary.add(
          Plant(
            id: plantId,
            description: plant['descripion'],
            storagePlace: plant['storagePlace'],
            hydrophilus: plant['hydrophilus'],
            photophilus: plant['photophilus'],
            fertility: plant['fertility'],
            prefferedTemperatureLeft: plant['prefferedTemperatureLeft'],
            prefferedTemperatureRight: plant['prefferedTemperatureRight'],
            urlImage: plant['urlImage'],
            name: plant['name'],
          ),
        );
      });
      _plants = temporary;
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
