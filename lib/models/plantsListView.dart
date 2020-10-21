import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

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
        itemCount: Provider.of<PlantsManagement>(context, listen: true)
            .plants
            .length, //! change it later with items.lenght from firebase
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(right: 15.h),
            child: GestureDetector(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.h),
                child: Container(
                  color: Theme.of(context).accentColor,
                  height: 160.h,
                  width: 140.h,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 15.h,
                        bottom: 30.h,
                        width: 110.h,
                        child: Text(
                          shortNameGetter(Provider.of<PlantsManagement>(context,
                                  listen: false)
                              .plants[index]
                              .name),
                          style: TextStyle(
                              fontSize: 20.h,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Positioned(
                        left: 10.h,
                        top: 10.h,
                        child: Icon(
                          Icons.check_circle_rounded,
                          // Icons.report_problem_rounded,
                          //TODO after implementation of the algorithm make sure to make it respond for changes in plant needs
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        top: -20.h,
                        right: -50.h,
                        child: ClipOval(
                          child: Stack(
                            children: [
                              Container(
                                height: 150.h,
                                width: 150.h,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.black,
                                  strokeWidth: 3.h,
                                ),
                              ),
                              Container(
                                height: 150.h,
                                width: 150.h,
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: Provider.of<PlantsManagement>(context,
                                          listen: false)
                                      .plants[index]
                                      .urlImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15.h,
                        bottom: 10.h,
                        width: 110.h,
                        child: Text(
                          Provider.of<PlantsManagement>(context, listen: false)
                                  .plants[index]
                                  .storagePlace
                              ? 'Indoor'
                              : 'Outdoor',
                          style: TextStyle(
                              fontSize: 15.h,
                              color: Colors.white,
                              fontWeight: FontWeight.w100),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}

String shortNameGetter(String name) {
  if (name.length > 11)
    return name.substring(0, name.indexOf(" "));
  else
    return name;
}
