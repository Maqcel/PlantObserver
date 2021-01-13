import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/models/managePlantItem.dart';
import 'package:roslinki_politechnika/models/customAppBar.dart';
import 'package:roslinki_politechnika/models/customDrawer.dart';
import 'package:roslinki_politechnika/providers/plantsListProvider.dart';

class ManagePlantScreen extends StatefulWidget {
  static const String routeName = '/managePlantScreen';
  final bool mode; //?true add false remove
  ManagePlantScreen({
    Key key,
    @required this.mode,
  }) : super(key: key);

  @override
  _ManagePlantScreenState createState() => _ManagePlantScreenState();
}

class _ManagePlantScreenState extends State<ManagePlantScreen> {
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
                  itemCount: widget.mode
                      ? Provider.of<PlantsManagement>(context, listen: false)
                          .plants
                          .length
                      : Provider.of<PlantsManagement>(context, listen: false)
                          .userPlants
                          .length,
                  itemBuilder: !widget.mode
                      ? (context, index) => ManagePlantItem(
                            databaseIndex: Provider.of<PlantsManagement>(
                                    context,
                                    listen: false)
                                .userPlants
                                .elementAt(index)
                                .databaseIndex,
                            mode: widget.mode,
                            plant: Provider.of<PlantsManagement>(context,
                                    listen: false)
                                .plants[index],
                          )
                      : (context, index) => ManagePlantItem(
                            databaseIndex: "Adding",
                            mode: widget.mode,
                            plant: Provider.of<PlantsManagement>(context,
                                    listen: false)
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
