import 'package:application/plant.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

class ApiKey {
  static const String key = "INSERT";
  static const dataBaseUrl = "INSERT";
}

class Sensor {
  Position position;
  Plant plant;
  final double WinterTemp = 23.0;
  final double SummerTemp = 26.0;
  final double SummerPhoto = 70;
  Sensor({@required this.plant});

  void setPlant(Plant plant) {
    this.plant = plant;
  }

  Plant getPlant() {
    return plant;
  }

  Future<void> calculateTemperature() async {
    final now = DateTime.now();
    int hour = now.hour + 1;

    if (now.month > 9 || now.month < 4) {
      if (hour >= 17 && hour <= 20) {
        plant.currentTemperature += 2.0;
      } else {
        plant.currentTemperature = WinterTemp;
      }
    } else {
      if (hour >= 12 && hour <= 15) {
        plant.currentTemperature += 1.0;
      } else {
        plant.currentTemperature = SummerTemp;
      }
    }

    if (plant.currentTemperature > plant.prefferedTemperatureRight) {
      plant.currentHydro -= 1.0;
      plant.currentFertility -= 0.5;
    }

    plant.currentFertility =
        double.tryParse(plant.currentFertility.toStringAsPrecision(3));
    plant.currentTemperature =
        double.tryParse(plant.currentTemperature.toStringAsPrecision(3));
  }

  Future<void> calculateOutside() async {
    String key = '856822fd8e22db5e1ba48c0e7d69844a';
    WeatherFactory wf = WeatherFactory(key);
    Weather w = await wf.currentWeatherByLocation(51.8733, 19.4667);
    print(w.toString());
    plant.currentTemperature = w.temperature.celsius;
    if (plant.currentTemperature > plant.prefferedTemperatureRight) {
      plant.currentHydro -= 2.0;
      plant.currentFertility -= 1.0;
    }
    if (w.rainLastHour >= 7.5 && w.rainLastHour <= 10.0) {
      plant.currentHydro += 5.0;
      plant.currentFertility += 2.0;
      plant.waterTank += 5.0;
    } else if (w.rainLastHour > 3.5 && w.rainLastHour < 7.5) {
      plant.currentHydro += 3.0;
      plant.currentFertility += 1.5;
      plant.waterTank += 5.0;
    } else if (w.rainLastHour >= 2.5 && w.rainLastHour <= 3.5) {
      plant.currentHydro += 1.0;
      plant.currentFertility += 1.0;
      plant.waterTank += 2.0;
    } else {
      plant.currentHydro -= 0.5;
      plant.currentFertility += 0.5;
      plant.waterTank -= 5.0;
    }
    if (w.cloudiness < 5) {
      plant.currentPhoto += (0.9 - w.cloudiness / 10);
    } else {
      plant.currentPhoto -= (0.7 - w.cloudiness) / 10;
    }
    plant.currentFertility =
        double.tryParse(plant.currentFertility.toStringAsPrecision(3));
    plant.currentPhoto =
        double.tryParse(plant.currentPhoto.toStringAsPrecision(3));
    plant.currentHydro =
        double.tryParse(plant.currentHydro.toStringAsPrecision(3));
    plant.currentTemperature =
        double.tryParse(plant.currentTemperature.toStringAsPrecision(3));
  }

  double calculateWater() {
    var randNumber = new Random();
    if (plant.currentHydro < 30.0) {
      if (randNumber.nextInt(10) == 5) {
        plant.currentHydro += 50.0;
        if (plant.waterTank + 30.0 > 100.0)
          plant.waterTank = 100.0;
        else
          plant.waterTank += 30.0;
      }
    } else if (plant.currentHydro > 30.0 && plant.currentHydro <= 50.0) {
      if (randNumber.nextInt(10) == 5) {
        plant.currentHydro += 30.0;
        if (plant.waterTank + 20.0 > 100.0)
          plant.waterTank = 100.0;
        else
          plant.waterTank += 20.0;
      }
    }
    final now = DateTime.now();
    int hour = now.hour + 1; //nasza strefa czasowa;
    if (plant.storagePlace == false) {
      if (now.month > 9 || now.month < 4) {
        if (hour >= 14 && hour <= 16 && now.weekday == 3) {
          if (plant.hydrophilus >= 80.0) {
            plant.currentHydro -= 12.0;
          } else if (plant.hydrophilus >= 50.0 && plant.hydrophilus < 80.0) {
            plant.currentHydro -= 10.0;
          } else if (plant.hydrophilus >= 10.0 && plant.hydrophilus < 50.0) {
            plant.currentHydro -= 5.0;
          }
        } else {
          plant.currentHydro -= 5.0;
        }
      } else {
        if (hour >= 12 &&
            hour <= 16 &&
            (now.weekday == 1 || now.weekday == 5)) {
          if (plant.hydrophilus >= 80.0) {
            plant.currentHydro -= 12.0;
          } else if (plant.hydrophilus >= 50.0 && plant.hydrophilus < 80.0) {
            plant.currentHydro -= 10.0;
          } else if (plant.hydrophilus >= 10.0 && plant.hydrophilus < 50.0) {
            plant.currentHydro -= 5.0;
          }
        } else {
          plant.currentHydro -= 5.0;
        }
      }
      plant.currentFertility =
          double.tryParse(plant.currentFertility.toStringAsPrecision(3));
    }
    plant.waterTank -= 3.0;
    if (plant.currentHydro < 0.0) plant.currentHydro = 0.0;
    if (plant.currentHydro > 100.0) plant.currentHydro = 100.0;
    plant.waterTank = double.tryParse(plant.waterTank.toStringAsFixed(2));
    plant.currentHydro = double.tryParse(plant.currentHydro.toStringAsFixed(2));
  }

  double calculatePhoto() {
    final now = DateTime.now();
    int hour = now.hour + 1; //nasza strefa czasowa;
    if (plant.storagePlace == false) {
      //plant w domu
      if (now.month > 9 || now.month < 4) {
        //zima
        if (hour >= 9 &&
            hour <= 13 &&
            (now.weekday == 2 || now.weekday == 3 || now.weekday == 5)) {
          if (plant.photophilus >= 80.0) {
            plant.currentPhoto += 10.0;
            if (plant.currentPhoto >= 100.0) plant.currentPhoto = 100.0;
          } else if (plant.photophilus >= 50.0 && plant.photophilus < 80.0) {
            plant.currentPhoto += 5.0;
            if (plant.currentPhoto >= 100.0) plant.currentPhoto = 100.0;
          } else if (plant.photophilus >= 10.0 && plant.photophilus < 50.0) {
            plant.currentPhoto += 3.0;
            if (plant.currentPhoto > 100.0) plant.currentPhoto = 100.0;
          }
        } else {
          plant.currentPhoto -= 5.0;
        }
      } else {
        //lato
        if (hour >= 12 &&
            hour <= 17 &&
            (now.weekday != 3 && now.weekday != 1)) {
          if (plant.photophilus >= 80.0) {
            plant.currentPhoto += 15.0;
            if (plant.currentPhoto >= 100.0) plant.currentPhoto = 100.0;
          } else if (plant.photophilus >= 50.0 && plant.photophilus < 80.0) {
            plant.currentPhoto += 10.0;
            if (plant.currentPhoto >= 100.0) plant.currentPhoto = 100.0;
          } else if (plant.photophilus >= 10.0 && plant.photophilus < 50.0) {
            plant.currentHydro += 5.0;
            if (plant.currentPhoto >= 100.0) plant.currentPhoto = 100.0;
          }
        } else {
          plant.currentHydro = SummerPhoto - 5.0;
        }
      }
    }
    if (plant.currentPhoto < 0.0) plant.currentPhoto = 0.0;
    if (plant.currentPhoto > 100.0) plant.currentPhoto = 100.0;
    plant.currentPhoto =
        double.tryParse(plant.currentPhoto.toStringAsPrecision(3));
  }
}
