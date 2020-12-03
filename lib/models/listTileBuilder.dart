import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/providers/authProvider.dart';

class ListTileBuilder extends StatefulWidget {
  final double blurRadius;
  final String text;
  final Icon icon;
  final String routeName;

  ListTileBuilder({
    @required this.blurRadius,
    @required this.text,
    @required this.icon,
    @required this.routeName,
  });

  @override
  _ListTileBuilderState createState() => _ListTileBuilderState();
}

class _ListTileBuilderState extends State<ListTileBuilder> {
  Color stateColor = Color.fromRGBO(245, 247, 249, 1.0);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Container(
        decoration: BoxDecoration(
          color: stateColor,
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
              fontSize: widget.text.length >= 7 ? 24.h : 30.h,
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: widget.icon,
          onTap: () {
            setState(
              () {
                if (stateColor == Color.fromRGBO(245, 247, 249, 1.0)) {
                  stateColor = Theme.of(context).accentColor;
                } else {
                  stateColor = Color.fromRGBO(245, 247, 249, 1.0);
                }
                if (widget.routeName != null) {
                  if (widget.routeName != 'logout') {
                    Navigator.of(context).pushNamed(widget.routeName).then(
                          (value) => setState(
                            () {
                              if (stateColor ==
                                  Color.fromRGBO(245, 247, 249, 1.0)) {
                                stateColor = Theme.of(context).accentColor;
                              } else {
                                stateColor = Color.fromRGBO(245, 247, 249, 1.0);
                              }
                            },
                          ),
                        );
                  } else {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/');
                    Provider.of<Auth>(context, listen: false).logout();
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}
