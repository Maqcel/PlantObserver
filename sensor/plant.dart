
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class Plant{
  String ID,path;
  bool storagePlace;
  double hydrophilus;
  double photophilus;
  double fertility,waterTank;
  double prefferedTemperatureLeft;
  double prefferedTemperatureRight;
  double currentFertility,currentTemperature,currentPhoto,currentHydro;
  List<double> arrFertility,arrHydrophility;
  List<double> arrPhotophility,arrTemperature;

  void setInfo(String description,String name) {
    this.ID = ID;
  }
  void setHydrophilus(double Hydrophilus) {
    this.currentHydro = Hydrophilus;
  }
  void setPhotophilus(double Photophilus) {
    this.currentPhoto = Photophilus;
  }
  void setFertility(double Fertility) {
    this.currentFertility = Fertility;
  }
  void setTemperature(double Temperature) {
    this.currentTemperature = Temperature;
  }

  Plant({
    @required this.ID,@required this.path,
    @required this.storagePlace,
    @required this.hydrophilus,
    @required this.photophilus,
    @required this.fertility,
    @required this.prefferedTemperatureLeft,
    @required this.prefferedTemperatureRight,
    @required this.currentFertility,
    @required this.currentTemperature,
    @required this.currentPhoto,
    @required this.currentHydro,
    @required this.arrHydrophility,
    @required this.arrFertility,
    @required this.arrPhotophility,
    @required this.arrTemperature,
    @required this.waterTank}){
  }
}