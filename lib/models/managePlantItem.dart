import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/animations/routeAnimation.dart';
import 'package:roslinki_politechnika/providers/authProvider.dart';
import 'package:roslinki_politechnika/providers/plantProvider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roslinki_politechnika/providers/plantsListProvider.dart';
import 'package:roslinki_politechnika/screens/managePlantScreen.dart';
import 'package:transparent_image/transparent_image.dart';

class ManagePlantItem extends StatelessWidget {
  final Plant plant;
  final bool mode;
  final String databaseIndex;

  const ManagePlantItem({
    Key key,
    @required this.plant,
    @required this.databaseIndex,
    @required this.mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String action = mode ? 'dodać' : 'usunąć';
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: mode ? Colors.green[400] : Colors.redAccent,
        child: Icon(
          mode ? Icons.add_rounded : Icons.delete_outline,
          color: Colors.white,
          size: 60,
        ),
        alignment: mode ? Alignment.centerLeft : Alignment.centerRight,
        padding:
            mode ? EdgeInsets.only(left: 50.h) : EdgeInsets.only(right: 50.h),
      ),
      direction:
          mode ? DismissDirection.startToEnd : DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Potwierdź'),
            content: Text('Czy chcesz $action roślinę ze swojego zbioru?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("Tak")),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("Nie")),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        if (mode) {
          Provider.of<PlantsManagement>(context, listen: false)
              .addPlantUser(
                  plant,
                  Provider.of<Auth>(context, listen: false).token,
                  Provider.of<Auth>(context, listen: false).userId)
              .catchError(
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
                        Navigator.of(context).pushReplacement(
                          createRoute(
                            (ManagePlantScreen(mode: true)),
                          ),
                        );
                      },
                      child: Text('Try again!'),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          Provider.of<PlantsManagement>(context, listen: false)
              .removePlantUser(
                  Provider.of<Auth>(context, listen: false).token,
                  Provider.of<Auth>(context, listen: false).userId,
                  databaseIndex)
              .catchError(
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
                        Navigator.of(context).pushReplacement(
                          createRoute(
                            (ManagePlantScreen(mode: false)),
                          ),
                        );
                      },
                      child: Text('Try again!'),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
      child: Card(
        color: Theme.of(context).accentColor,
        margin: EdgeInsets.symmetric(
          horizontal: 15.h,
          vertical: 5.h,
        ),
        child: ListTile(
          leading: ClipOval(
            child: Stack(
              children: [
                Container(
                  height: 70.h,
                  width: 70.h,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    strokeWidth: 3.h,
                  ),
                ),
                Container(
                  height: 70.h,
                  width: 70.h,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: plant.urlImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            plant.name,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 30.h,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
