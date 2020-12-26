import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/providers/authProvider.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profileScreen';
  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  @override
  void initState() {
    isLoading = true;
    Provider.of<Auth>(context, listen: false).gatherPersonal().then(
      (value) {
        setState(
          () {
            isLoading = false;
          },
        );
      },
    ).catchError(
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
                  Navigator.of(context)
                      .pushReplacementNamed(ProfileScreen.routeName);
                },
                child: Text('Try again!'),
              ),
            ],
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Auth provider = Provider.of<Auth>(context, listen: true);

    return new Scaffold(
      body: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ClipPath(
            child: Container(color: Theme.of(context).accentColor),
            clipper: getClipper(),
          ),
          isLoading
              ? CircularProgressIndicator()
              : Positioned(
                  top: MediaQuery.of(context).size.height / 5,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 150.0.h,
                        height: 150.0.h,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://assets.vogue.com/photos/5c8ff6c0ac563c2de0043d1d/3:4/w_1950,h_2600,c_limit/00-promo-image-boys-with-plants-book.jpg'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(
                            Radius.circular(75.0.h),
                          ),
                          boxShadow: [
                            BoxShadow(blurRadius: 7.0.h, color: Colors.black),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0.h),
                      Text(
                        '${provider.name} ${provider.surname}', //user
                        style: TextStyle(
                            fontSize: 30.0.h,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                      SizedBox(height: 15.0.h),
                      Text(
                        '${provider.email}', //ewentualnie do wypierdolenia
                        style: TextStyle(
                            fontSize: 17.0.h,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Montserrat'),
                      ),
                    ],
                  ),
                ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 10,
            child: Column(
              children: [
                button(context, 'Dodaj roślinę', false),
                button(context, 'Usuń roślinę', false),
                button(context, 'Statystyki', false),
                button(context, 'Usuń konto', true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

Widget button(BuildContext context, String text, bool delete) {
  return Column(
    children: [
      SizedBox(height: 20.0.h),
      Container(
        height: 52.0.h,
        width: 150.0.h,
        child: Material(
          borderRadius: BorderRadius.circular(20.0.h),
          shadowColor: delete ? Colors.red : Colors.greenAccent,
          color: delete ? Colors.red : Theme.of(context).accentColor,
          elevation: 7.0.h,
          child: GestureDetector(
            onTap: () {},
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 20.h),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
