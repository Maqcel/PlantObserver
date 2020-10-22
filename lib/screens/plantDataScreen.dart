import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/models/potDecoration.dart';
import 'package:roslinki_politechnika/providers/potDecorationProvider.dart';

class PlantDataScreen extends StatefulWidget {
  static const String routeName = '/plantDataScreen';

  PlantDataScreen({Key key}) : super(key: key);

  @override
  _PlantDataScreenState createState() => _PlantDataScreenState();
}

class _PlantDataScreenState extends State<PlantDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              left: 20.h,
              top: 50.h,
              child: GestureDetector(
                onTap: () {
                  //! Navigator.of(context).pop();
                },
                child: Container(
                  height: 35.h,
                  width: 100.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      Text(
                        'Go back',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.h,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0.h,
              top: 40.h,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(107, 190, 118, 1.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/nut.png',
                    color: Colors.white,
                    width: 30.h,
                  ),
                ),
                width: 80.h,
                height: 60.h,
              ),
            ),
            Positioned(
              top: 140.h,
              left: 40.h,
              child: PotDecoration(
                'Humidity',
              ),
            ),
            Positioned(
              top: 140.h,
              left: 200.h,
              child: PotDecoration(
                'Fertilizer',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
