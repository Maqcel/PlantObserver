import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTileBuilder extends StatefulWidget {
  final double blurRadius;
  final String text;
  final Icon icon;

  Color stateColor = Color.fromRGBO(245, 247, 249, 1.0);

  ListTileBuilder({this.blurRadius, this.text, this.icon});

  @override
  _ListTileBuilderState createState() => _ListTileBuilderState();
}

class _ListTileBuilderState extends State<ListTileBuilder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Container(
        decoration: BoxDecoration(
          color: widget.stateColor,
          borderRadius: BorderRadius.circular(20.h),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: widget.blurRadius,
              spreadRadius: widget.blurRadius,
              offset: Offset(-widget.blurRadius / 3, -widget.blurRadius / 3),
            ),
            BoxShadow(
              color: Color.fromRGBO(163, 177, 198, 1.0),
              blurRadius: widget.blurRadius,
              offset: Offset(widget.blurRadius / 3, widget.blurRadius / 3),
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            widget.text,
            style: TextStyle(
              fontSize: 30.h,
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: widget.icon,
          onTap: () {
            setState(() {
              if (widget.stateColor == Color.fromRGBO(245, 247, 249, 1.0)) {
                widget.stateColor = Theme.of(context).accentColor;
              } else {
                widget.stateColor = Color.fromRGBO(245, 247, 249, 1.0);
                //TODO set route push with .then to swap the color back to orgin
              }
            });
          },
        ),
      ),
    );
  }
}
