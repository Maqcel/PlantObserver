import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:roslinki_politechnika/models/apiKey.dart';

import 'plantProvider.dart';

class PlantsManagement with ChangeNotifier {
  final String token;
  List<Plant> _plants;

  List<Plant> _userPlants;

  PlantsManagement(this.token, this._plants);

  List<Plant> get plants {
    return [..._plants]; //? creates copy of the list
  }

  List<Plant> get userPlants {
    return [..._userPlants]; //? creates copy of the list
  }

  Future<void> getPlants(String userId) async {
    try {
      final response = await http
          .get(ApiKey.dataBaseUrl + 'plants.json' + '?auth=$token')
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

      final responseUserPlants = await http
          .get(
              ApiKey.dataBaseUrl + 'users/$userId/plants.json' + '?auth=$token')
          .timeout(Duration(seconds: 5));

      final decodedDataUser =
          json.decode(response.body) as Map<String, dynamic>;
      if (decodedDataUser == null) {
        print('Response body is null');
        throw NullThrownError;
      }
      final List<Plant> temporaryUser = [];

      decodedDataUser.forEach((plantId, plant) {});
      _userPlants = temporaryUser;
      //print(responseUserPlants.body);
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
