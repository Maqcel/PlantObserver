import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/providers/plantsListProvider.dart';

class PlantListTile extends StatefulWidget {
  PlantListTile({Key key}) : super(key: key);

  @override
  _PlantListTileState createState() => _PlantListTileState();
}

class _PlantListTileState extends State<PlantListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Provider.of<PlantsManagement>(context, listen: false)
            .plants
            .length, //! change it later with items.lenght from firebase
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              height: 160.h,
              width: (160.0).h,
              color: Theme.of(context).accentColor,
              child: Center(
                child: Text(
                  Provider.of<PlantsManagement>(context, listen: false)
                      .plants[index]
                      .name,
                  style: TextStyle(fontSize: 20.h),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}
