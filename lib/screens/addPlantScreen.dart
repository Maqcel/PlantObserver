import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/models/addPlantItem.dart';
import 'package:roslinki_politechnika/models/customAppBar.dart';
import 'package:roslinki_politechnika/models/customDrawer.dart';
import 'package:roslinki_politechnika/providers/plantsListProvider.dart';

class AddPlantScreen extends StatefulWidget {
  static const String routeName = '/addPlantScreen';
  AddPlantScreen({Key key}) : super(key: key);

  @override
  _AddPlantScreenState createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount:
                      Provider.of<PlantsManagement>(context, listen: false)
                          .plants
                          .length,
                  itemBuilder: (context, index) => AddPlantItem(
                    mode: true,
                    plant: Provider.of<PlantsManagement>(context, listen: false)
                        .plants[index],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
