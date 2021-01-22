import 'dart:math';

import 'package:application/plant.dart';
import 'package:application/apikey.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';
class PlantsList{
  List<Plant> _plants = [];
  List<String> _users = [];
  List<Plant> get plants {
    return [..._plants]; //? creates copy of the list
  }
  List<String> get users{
    return [..._users];
  }
  PlantsList();
  Future <void> getPlants(String token) async{
    try {
      final response = await http.get(
          ApiKey.dataBaseUrl + "plants.json" +'?auth=$token')
          .timeout(Duration(seconds: 10));
      final decodedData = json.decode(response.body) as Map<String, dynamic>;
      if (decodedData == null) {
        print("Response body is null");
        throw NullThrownError;
      }
      final List<Plant> temporary = [];
      decodedData.forEach((plantId, plant) {
        temporary.add(
          Plant(
            ID: plantId,
            fertility: plant['fertility'],
            hydrophilus: plant['hydrophilus'],
            photophilus: plant['photophilus'],
            prefferedTemperatureRight: plant['prefferedTemperatureRight'],
            prefferedTemperatureLeft: plant['prefferedTemperatureLeft'],
            storagePlace: plant['storagePlace'],),
        );
      });
      _plants = temporary;
    } on TimeoutException catch (e){
      print('Timeout Error: $e');
      throw e;
    }
    on SocketException catch (e){
      print('Socket Error: $e');
      throw e;
    }
    on Error catch(e){
      print("General Error: $e");
      throw e;
    }
  }

  Future<void> getAllUsers(String token) async{
    try {
      final response = await http.get(
          ApiKey.dataBaseUrl + "users.json" +'?auth=$token')
          .timeout(Duration(seconds: 10));
      final decodedData = json.decode(response.body) as Map<String, dynamic>;
      if (decodedData == null) {
        print("Response body is null");
        throw NullThrownError;
      }
      final List<String> temporary = [];
      decodedData.forEach((userId, User) {
        temporary.add(userId);
      });
      _users = temporary;

    } on TimeoutException catch (e){
      print('Timeout Error: $e');
      throw e;
    }
    on SocketException catch (e){
      print('Socket Error: $e');
      throw e;
    }
    on Error catch(e){
      print("General Error: $e");
      throw e;
    }
  }

  Future <List<String>> getPlantID(String token,String userId) async{
    final List<String> temporary = [];
    try {
      final response = await http.get(
          ApiKey.dataBaseUrl + "users/" +userId + '/plants.json'+'?auth=$token')
          .timeout(Duration(seconds: 5));
      final decodedData = json.decode(response.body) as Map<String, dynamic>;
      if (decodedData == null) {
        return null;
      }
      else{
        decodedData.forEach((plantId, User) {
          temporary.add(plantId);
        });
      }
    } on TimeoutException catch (e){
      print('Timeout Error: $e');
      throw e;
    }
    on SocketException catch (e){
      print('Socket Error: $e');
      throw e;
    }
    on Error catch(e){
      print("General Error: $e");
      throw e;
    }
    return temporary;
  }


  Future <void> updateUserPlant(Plant user,String id,String token) async{
    String url = user.path;
    Map<String, String> headers = {"Content-type": "application/json"};
    try{
      final response = await http
          .put(
        url,
        headers: headers,
        body : json.encode(
          {
            'arrFertility' : encodeArray(user.arrFertility),
            'arrHydrophility' : encodeArray(user.arrHydrophility),
            'arrPhotophility' : encodeArray(user.arrPhotophility),
            'arrTemperature' : encodeArray(user.arrTemperature),
            'currentFertility' : user.currentFertility,
            'currentHydrophility' : user.currentHydro,
            'currentPhotophility' : user.currentPhoto,
            'currentTemperature' : user.currentTemperature,
            'id' : user.ID,
            'waterTank': user.waterTank
          },
        ),
      ).timeout(Duration(seconds: 10));
    } on TimeoutException catch(e){
      print("Timeout error: $e");
      throw e;
    } on SocketException catch(e){
      print("Socket error: $e");
      throw e;
    } on Error catch(e){
      print("General error: $e");
      throw e;
    }
  }

  String encodeArray(List<double> arr){
    var buffer = new StringBuffer();
    for(int i = 0; i < arr.length-1; i++){
      buffer.write(arr.elementAt(i).toString() + " ");
    }
    buffer.write(arr.last.toString());
    return buffer.toString();
  }

  List<double> decodeArray(String array) {
    List<String> listSplited = array.split(' ').toList();
    List<double> listParsed = [];
    listSplited.forEach((element) {
      listParsed.add(double.parse(element));
    });
    return listParsed;
  }



  void addElement(List<double> array,double value){
    array.add(value);
  }

  void deleteFirstElement(List<double>array){
    array.removeAt(0);
  }

  Future<List<Plant>> createUserPlant(String token,String userId) async{
    final List<Plant> temporary = [];
    try {

      final response = await http.get(
          ApiKey.dataBaseUrl + "users/" +userId + '/plants'+'.json?auth=$token')
          .timeout(Duration(seconds: 5));
      final decodedData = json.decode(response.body) as Map<String, dynamic>;
      if (decodedData == null) {
        print("Response body is null");
        return null;
      }
      else{
        decodedData.forEach((plantId, plant) {
          for(int i = 0; i < plants.length;i++){
            if(plants.elementAt(i).ID == plant['id'].toString()){
              temporary.add(
                Plant(
                  ID: plant['id'],
                  path: ApiKey.dataBaseUrl + "users/" +userId + '/plants/'+plantId.toString()+'.json?auth=$token',
                  currentFertility: plant['currentFertility'],
                  currentHydro: plant['currentHydrophility'],
                  currentPhoto: plant['currentPhotophility'],
                  currentTemperature : plant['currentTemperature'],
                  arrFertility: decodeArray(plant['arrFertility']),
                  arrHydrophility: decodeArray(plant['arrHydrophility']),
                  arrPhotophility: decodeArray(plant['arrPhotophility']),
                  arrTemperature : decodeArray(plant['arrTemperature']),
                  prefferedTemperatureLeft: plants.elementAt(i).prefferedTemperatureLeft,
                  prefferedTemperatureRight: plants.elementAt(i).prefferedTemperatureRight,
                  fertility: plants.elementAt(i).fertility,
                  photophilus:plants.elementAt(i).photophilus,
                  hydrophilus: plants.elementAt(i).hydrophilus,
                  storagePlace: plants.elementAt(i).storagePlace,
                  waterTank:  plant['waterTank'],
                ),
              );
              break;
            }
          }
        });

      }
    } on TimeoutException catch (e){
      print('Timeout Error: $e');
      throw e;
    }
    on SocketException catch (e){
      print('Socket Error: $e');
      throw e;
    }
    on Error catch(e){
      print("General Error: $e");
      throw e;
    }
    return temporary;
  }

}