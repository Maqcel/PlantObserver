import 'package:flutter/material.dart';
import 'package:roslinki_politechnika/providers/plantProvider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

class AddPlantItem extends StatelessWidget {
  final Plant plant;
  final bool mode;

  const AddPlantItem({
    Key key,
    @required this.plant,
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
        //!Provider
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
