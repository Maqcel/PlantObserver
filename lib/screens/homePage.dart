import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/models/addPlantButton.dart';
import 'package:roslinki_politechnika/models/customAppBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roslinki_politechnika/models/customDrawer.dart';
import 'package:roslinki_politechnika/models/plantsListView.dart';
import 'package:roslinki_politechnika/providers/authProvider.dart';
import 'package:roslinki_politechnika/providers/plantsListProvider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    Provider.of<PlantsManagement>(context, listen: false)
        .getPlants(Provider.of<Auth>(context, listen: false).userId)
        .then(
      (value) {
        setState(
          () {
            _isLoading = false;
          },
        );
      },
    ).catchError(
      (onError) {
        return showDialog<Null>(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text(
              'An error occurred!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35.h),
            ),
            content: Text(
              'Something went wrong, most likely no internet connection',
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
                child: Text('Try again!'),
              ),
            ],
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(),
      drawer: CustomDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Text(
                          'Moje rośliny',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 45.h,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Consumer<PlantsManagement>(
                        builder: (_, __, ___) => PlantListTile(
                          mode: 'User',
                        ),
                      ), //TODO make sure its ok
                      SizedBox(
                        height: 40.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Baza roślin',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 45.h,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            IconButton(
                              icon: ImageIcon(
                                AssetImage('assets/images/filters.png'),
                                size: 50.h,
                              ),
                              color: Colors.black,
                              onPressed: () {}, //TODO add some filter logic
                            ),
                          ],
                        ),
                      ),
                      PlantListTile(
                        mode: 'All',
                      ), //TODO make sure its ok
                      SizedBox(
                        height: 35.h,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 35.h,
                  left: 20.h,
                  child: Transform.rotate(
                    angle: 180 * pi / 180,
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ),
                Positioned(
                  bottom: 18.h,
                  left: 70.h,
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    width: 180.h,
                    child: Text(
                      'Dostosuj nawodnienie roślin', //TODO this should change to 'Nie trzeba podejmować akcji' if all plants has water and fertilizer
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.h,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Positioned(
                  right: 20.h,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Center(
                      child: AddPlantButton(
                        plus: 10,
                        pot: 20,
                      ),
                    ),
                    width: 60.h,
                    height: (78.91).h,
                  ),
                ),
              ],
            ),
    );
  }
}
