import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/animations/routeAnimation.dart';
import 'package:roslinki_politechnika/providers/authProvider.dart';
import 'package:roslinki_politechnika/screens/managePlantScreen.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profileScreen';
  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  bool isFirst = true;
  bool _apiSave = false;

  bool _isErrorName = false;
  bool _isErrorSurname = false;

  String _nameState = '';
  String _surnameState = '';

  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _personalData = {
    'name': '',
    'surname': '',
  };

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _apiSave = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .updatePersonal(_personalData['name'], _personalData['surname']);
    } catch (error) {
      const String errorMessage =
          'Nie możemy zmienić Twoich danych. Spróbuj ponownie później.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _apiSave = false;
      isFirst = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('An Error Occured!'),
        content: Text(message),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    isLoading = true;
    Provider.of<Auth>(context, listen: false).gatherPersonal().then(
      (value) {
        setState(
          () {
            if (Provider.of<Auth>(context, listen: false).name != "empty" &&
                Provider.of<Auth>(context, listen: false).surname != "empty") {
              isFirst = false;
            }
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
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    Auth provider = Provider.of<Auth>(context, listen: true);

    return new Scaffold(
      backgroundColor: isFirst ? Theme.of(context).primaryColor : Colors.white,
      resizeToAvoidBottomInset: false,
      body: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          !isFirst
              ? ClipPath(
                  child: Container(color: Theme.of(context).accentColor),
                  clipper: getClipper(),
                )
              : Container(),
          isLoading
              ? Container()
              : isFirst
                  ? Positioned(
                      bottom: 20.h,
                      child: _apiSave
                          ? CircularProgressIndicator()
                          : Container(
                              width: 120.h,
                              height: 50.h,
                              child: NeumorphicButton(
                                style: NeumorphicStyle(
                                  depth: 20,
                                  shape: NeumorphicShape.convex,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(15)),
                                  color: Color.fromRGBO(245, 247, 249, 1.0),
                                  lightSource: LightSource.topLeft,
                                  surfaceIntensity: 0.4,
                                  intensity: 1,
                                ),
                                child: Center(
                                  child: Text(
                                    'Zapisz',
                                    style: TextStyle(
                                        fontSize: 20.h,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                onPressed: _submit,
                              ),
                            ),
                    )
                  : Container(),
          isLoading
              ? CircularProgressIndicator()
              : isFirst
                  ? Positioned(
                      top: height / 3,
                      child: Column(
                        children: [
                          Text(
                            "Podaj swoje dane!",
                            style: TextStyle(
                                fontSize: 30.h, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 50.h),
                          Form(
                            key: _formKey,
                            child: Container(
                              height: height - 100.h,
                              width: width,
                              child: Column(
                                children: [
                                  Container(
                                    width: 300.h,
                                    height: 50.h,
                                    child: Neumorphic(
                                      style: NeumorphicStyle(
                                        depth: -6,
                                        shape: NeumorphicShape.concave,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(15)),
                                        color:
                                            Color.fromRGBO(245, 247, 249, 1.0),
                                        lightSource: LightSource.topLeft,
                                        intensity: 1,
                                      ),
                                      child: FormField<String>(
                                        builder:
                                            (FormFieldState formFieldState) {
                                          return TextField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              hintText: 'Imie',
                                              border: InputBorder.none,
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                _nameState = value;
                                                formFieldState.didChange(value);
                                                _isErrorName = false;
                                              });
                                            },
                                          );
                                        },
                                        validator: (value) {
                                          if (value != null) {
                                            if (value.isEmpty ||
                                                value == null ||
                                                value.contains(
                                                    new RegExp(r'[0-9]'))) {
                                              setState(() {
                                                _isErrorName = true;
                                              });
                                              return 'Niepoprawne imie!';
                                            }
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _personalData['name'] = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  _isErrorName
                                      ? Text(
                                          'Niepoprawne imie!',
                                          style: TextStyle(
                                            color: Theme.of(context).errorColor,
                                            fontSize: 20.h,
                                          ),
                                        )
                                      : Container(),
                                  !_isErrorName
                                      ? SizedBox(height: 20.h)
                                      : Container(),
                                  Container(
                                    width: 300.h,
                                    height: 50.h,
                                    child: Neumorphic(
                                      style: NeumorphicStyle(
                                        depth: -6,
                                        shape: NeumorphicShape.concave,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(15)),
                                        color:
                                            Color.fromRGBO(245, 247, 249, 1.0),
                                        lightSource: LightSource.topLeft,
                                        intensity: 1,
                                      ),
                                      child: FormField<String>(
                                        builder:
                                            (FormFieldState formFieldState) {
                                          return TextField(
                                            textInputAction:
                                                TextInputAction.done,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              hintText: 'Nazwisko',
                                              border: InputBorder.none,
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                _surnameState = value;
                                                formFieldState.didChange(value);
                                                _isErrorSurname = false;
                                              });
                                            },
                                          );
                                        },
                                        validator: (value) {
                                          if (value != null) {
                                            if (value.isEmpty ||
                                                value == null ||
                                                value.contains(
                                                    new RegExp(r'[0-9]'))) {
                                              setState(() {
                                                _isErrorSurname = true;
                                              });
                                              return 'Nazwisko niepoprawne';
                                            }
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _personalData['surname'] = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  _isErrorSurname
                                      ? Text(
                                          'Nazwisko niepoprawne',
                                          style: TextStyle(
                                            color: Theme.of(context).errorColor,
                                            fontSize: 20.h,
                                          ),
                                        )
                                      : Container(),
                                  !_isErrorSurname
                                      ? SizedBox(height: 20.h)
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
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
                                BoxShadow(
                                    blurRadius: 7.0.h, color: Colors.black),
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
          isFirst
              ? Container()
              : Positioned(
                  bottom: MediaQuery.of(context).size.height / 10,
                  child: Column(
                    children: [
                      button(context, 'Dodaj roślinę', false,
                          ManagePlantScreen(mode: true)),
                      button(context, 'Usuń roślinę', false,
                          ManagePlantScreen(mode: false)),
                      button(context, 'Usuń konto', true, null),
                    ],
                  ),
                ),
          !isFirst
              ? Positioned(
                  top: 35.h,
                  right: 15.h,
                  child: IconButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 40.h,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        isFirst = true;
                      });
                    },
                  ),
                )
              : Container(),
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

Widget button(BuildContext context, String text, bool delete, Widget screen) {
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
            onTap: () {
              if (screen != null) {
                Navigator.of(context).pushReplacement(
                  createRoute(screen),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Potwierdź'),
                    content: Text('Czy chcesz usunąć konto?'),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Provider.of<Auth>(context, listen: false)
                                .deleteAccount();
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacementNamed('/');
                            Provider.of<Auth>(context, listen: false).logout();
                          },
                          child: Text("Tak")),
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Nie")),
                    ],
                  ),
                );
              }
            },
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
