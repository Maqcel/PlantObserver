import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roslinki_politechnika/screens/managePlantScreen.dart';

class AddPlantButton extends StatefulWidget {
  final double pot;
  final double plus;

  const AddPlantButton({
    Key key,
    @required this.pot,
    @required this.plus,
  }) : super(key: key);
  @override
  _AddPlantButtonState createState() => _AddPlantButtonState();
}

class _AddPlantButtonState extends State<AddPlantButton> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pushNamed(ManagePlantScreen.routeName);
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ImageIcon(
            AssetImage('assets/images/pot.png'),
            size: (widget.pot).h,
          ),
          Container(
            height: widget.pot - 0.2 * widget.pot,
            width: widget.pot - 0.2 * widget.pot,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Icon(
                      Icons.add_rounded,
                      size: (widget.plus).h,
                      color: widget.pot < 100
                          ? Theme.of(context).accentColor
                          : Colors.white,
                    ),
                    Icon(
                      Icons.add_circle_rounded,
                      size: (widget.plus).h,
                      color: widget.pot > 100
                          ? Theme.of(context).accentColor
                          : Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
