import 'package:application/plant.dart';
import 'package:application/apikey.dart';
import 'package:application/PlantsList.dart';
import 'package:application/authProvider.dart';
import 'dart:io';

class Organizer {
  Auth authorization;
  PlantsList listOfPlants = new PlantsList();
  List<Plant> everyPlant;
  List<String> usersList, plantsID;
  Organizer() {
    authorization = new Auth();
  }

  Future<void> action() async {
    await authorization.signin(INSERT, INSERT);
    String token = authorization.token;
    await listOfPlants.getPlants(token);
    //while(true){
    await listOfPlants.getAllUsers(token);
    usersList = listOfPlants.users;
    while (true) {
      for (int i = 0; i < usersList.length; i++) {
        List<Plant> temp =
            await listOfPlants.createUserPlant(token, usersList.elementAt(i));
        if (temp != null) {
          for (int j = 0; j < temp.length; j++) {
            Sensor sensor = new Sensor();
            sensor.setPlant(temp.elementAt(j));
            if (sensor.getPlant().storagePlace == true) {
              await sensor.calculateOutside();
            } else {
              await sensor.calculateTemperature();
              sensor.calculatePhoto();
              sensor.calculateWater();
            }
            listOfPlants.addElement(sensor.getPlant().arrFertility,
                sensor.getPlant().currentFertility);
            listOfPlants.deleteFirstElement(sensor.getPlant().arrFertility);
            listOfPlants.addElement(sensor.getPlant().arrHydrophility,
                sensor.getPlant().currentHydro);
            listOfPlants.deleteFirstElement(sensor.getPlant().arrHydrophility);
            listOfPlants.addElement(sensor.getPlant().arrPhotophility,
                sensor.getPlant().currentPhoto);
            listOfPlants.deleteFirstElement(sensor.getPlant().arrPhotophility);
            listOfPlants.addElement(sensor.getPlant().arrTemperature,
                sensor.getPlant().currentTemperature);
            listOfPlants.deleteFirstElement(sensor.getPlant().arrTemperature);

            await listOfPlants.updateUserPlant(
                temp.elementAt(j), usersList.elementAt(i), token);
          }
        }
      }
      sleep(Duration(seconds: 30));
    }
    //}
  }
}
