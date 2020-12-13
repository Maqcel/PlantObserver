import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:roslinki_politechnika/models/apiKey.dart';

import 'plantProvider.dart';
import 'userPlantProvider.dart';

class PlantsManagement with ChangeNotifier {
  final String token;
  List<Plant> _plants;

  List<UserPlant> _userPlants;

  PlantsManagement(this.token, this._plants, this._userPlants);

  List<Plant> get plants {
    return [..._plants]; //? creates copy of the list
  }

  List<UserPlant> get userPlants {
    return [..._userPlants]; //? creates copy of the list
  }

  List<double> decodeArray(String array) {
    List<String> listSplited = array.split(' ').toList();
    List<double> listParsed = [];
    listSplited.forEach((element) {
      listParsed.add(double.parse(element));
    });
    return listParsed;
  }

  Future<void> getPlants(String userId) async {
    try {
      final response = await http
          .get(ApiKey.dataBaseUrl + 'plants.json' + '?auth=$token')
          .timeout(Duration(seconds: 5));
      final decodedData = json.decode(response.body) as Map<String, dynamic>;
      if (decodedData == null) {
        print('Response body is null getPlants');
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
          json.decode(responseUserPlants.body) as Map<String, dynamic>;
      if (decodedDataUser == null) {
        print('Response body is null userPlants');
        final List<UserPlant> temporaryUser = [];
        _userPlants = temporaryUser;
        notifyListeners();
        return;
      }

      final List<UserPlant> temporaryUser = [];

      decodedDataUser.forEach((plantId, plant) {
        temporaryUser.add(
          UserPlant(
            currentFertility: plant['currentFertility'],
            currentHydrophility: plant['currentHydrophility'],
            currentPhotophility: plant['currentPhotophility'],
            currentTemperature: plant['currentTemperature'],
            id: plant['id'],
            arrFertility: decodeArray(plant['arrFertility']),
            arrHydrophility: decodeArray(plant['arrHydrophility']),
            arrPhotophility: decodeArray(plant['arrPhotophility']),
            arrTemperature: decodeArray(plant['arrTemperature']),
          ),
        );
      });
      _userPlants = temporaryUser;
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

  Future<void> addPlantUser(Plant plant, String token, String userId) async {
    final String url =
        ApiKey.dataBaseUrl + 'users/$userId/plants.json' + '?auth=$token';
    try {
      await http
          .post(
            url,
            body: json.encode(
              {
                'id': plant.id,
                'currentFertility': 90.0,
                'currentHydrophility': 30.0,
                'currentPhotophility': 40.0,
                'currentTemperature': 20.0,
                'arrFertility': '50.0 50.0 50.0 50.0 50.0 50.0',
                'arrHydrophility': '30.0 30.0 30.0 30.0 30.0 30.0',
                'arrPhotophility': '40.0 40.0 40.0 40.0 40.0 40.0',
                'arrTemperature': '20.0 20.0 20.0 20.0 20.0 20.0',
              },
            ),
          )
          .timeout(Duration(seconds: 10));
      _userPlants.add(
        new UserPlant(
          currentFertility: 90.0,
          currentHydrophility: 30.0,
          currentPhotophility: 40.0,
          currentTemperature: 20.0,
          id: plant.id,
          arrFertility: [50.0, 50.0, 50.0, 50.0, 50.0, 50.0],
          arrHydrophility: [30.0, 30.0, 30.0, 30.0, 30.0, 30.0],
          arrPhotophility: [40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
          arrTemperature: [20.0, 20.0, 20.0, 20.0, 20.0, 20.0],
        ),
      );
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
