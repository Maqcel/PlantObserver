import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/providers/potDecorationProvider.dart';
import 'dart:math';

class PotDecoration extends StatefulWidget {
  final String choosenData;

  const PotDecoration(this.choosenData);

  @override
  _PotDecorationState createState() => _PotDecorationState();
}

class _PotDecorationState extends State<PotDecoration> {
  List<int> dots = [11, 10, 9, 8, 7, 8, 9, 8, 9, 8, 7, 6];

  @override
  Widget build(BuildContext context) {
    Provider.of<PotDecorationProvider>(context, listen: true).dataUpdated();
    int rows = dots.length;
    return Column(
      children: [
        for (int i = 0; i < rows; i++)
          _rowBuilder(context, i, dots, 3, widget.choosenData),
      ],
    );
  }
}

Widget _rowBuilder(BuildContext context, int rowIndex, List<int> dots,
    double size, String choosenData) {
  int rowLength = 21; //? needed for 2 columns effect
  return Row(
    children: [
      for (int i = 0; i < rowLength; i++)
        Padding(
          padding: EdgeInsets.only(bottom: size.h / 4, top: size.h / 4),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.h),
              color: _colorLogicChooser(
                  context, i, dots[rowIndex], choosenData), //WHITE
            ),
            width: size.h,
            height: size.h,
          ),
        )
    ],
  );
}

Color _colorLogicChooser(
    BuildContext context, int placeInRow, int dotsInRow, String choosenData) {
  PotDecorationProvider provider =
      Provider.of<PotDecorationProvider>(context, listen: true);
  double shouldRepaint = choosenData == 'Humidity'
      ? provider.shouldPaintHumidity
      : provider.shouldPaintFertilizer;
  int leftToBePainted = choosenData == 'Humidity'
      ? provider.leftEmptySpaceToPaintHumidity
      : provider.leftEmptySpaceToPaintFertilizer;
  if (placeInRow % 2 == 0) {
    if (dotsInRow % 2 == 1) {
      //? odd rows check
      int eachSide = dotsInRow ~/ 2;
      if (placeInRow < 10 - eachSide * 2 || placeInRow > 10 + eachSide * 2) {
        return Theme.of(context).accentColor;
      } else {
        if (Random().nextBool() && shouldRepaint > 0 ||
            shouldRepaint == leftToBePainted) {
          if (shouldRepaint == provider.shouldPaintHumidity) {
            provider.paintedHumidity();
            provider.leftToBePaintedHumidity();
          } else {
            provider.paintedFertilizer();
            provider.leftToBePaintedFertilizer();
          }
          return Colors.white;
        }
        if (shouldRepaint == provider.shouldPaintHumidity) {
          provider.leftToBePaintedHumidity();
        } else {
          provider.leftToBePaintedFertilizer();
        }
        return Color.fromRGBO(113, 206, 138, 1.0);
      }
    } else {
      return Theme.of(context).accentColor;
    }
  } else {
    if (dotsInRow % 2 == 1) {
      return Theme.of(context).accentColor;
    } else {
      //? even rows check
      int eachSide = dotsInRow ~/ 2;
      if (placeInRow <= 9 - eachSide * 2 || placeInRow >= 11 + eachSide * 2) {
        return Theme.of(context).accentColor;
      } else {
        if (Random().nextBool() && shouldRepaint > 0 ||
            shouldRepaint == leftToBePainted) {
          if (shouldRepaint == provider.shouldPaintHumidity) {
            provider.paintedHumidity();
            provider.leftToBePaintedHumidity();
          } else {
            provider.paintedFertilizer();
            provider.leftToBePaintedFertilizer();
          }
          return Colors.white;
        }
        if (shouldRepaint == provider.shouldPaintHumidity &&
            shouldRepaint != 0) {
          provider.leftToBePaintedHumidity();
        } else {
          provider.leftToBePaintedFertilizer();
        }
        return Color.fromRGBO(113, 206, 138, 1.0);
      }
    }
  }
}
