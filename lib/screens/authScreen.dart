import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/providers/authProvider.dart';

class CurvePainter extends CustomPainter {
  final bool isSignup;
  CurvePainter(this.isSignup);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color.fromRGBO(245, 247, 249, 1.0)
      ..style = PaintingStyle.fill; // Change this to fill

    var shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 40);

    if (isSignup == false) {
      var path = Path(); //! Shadow - up

      path.moveTo(0, size.height * 0.5);
      path.quadraticBezierTo(size.width * 0.65, size.height * 0.65,
          size.width * 1.05, size.height * 0.35);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);

      canvas.drawPath(path, shadowPaint);

      path = new Path(); //! Space - up

      path.moveTo(0, size.height * 0.45);
      path.quadraticBezierTo(
          size.width * 0.6, size.height * 0.6, size.width, size.height * 0.3);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);

      canvas.drawPath(path, paint);

      path = new Path(); //! Shadow - down

      path.moveTo(0, size.height * 0.85);
      path.quadraticBezierTo(size.width * 0.15, size.height * 0.55,
          size.width * 1.35, size.height * 0.5);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);

      canvas.drawPath(path, shadowPaint);

      path = new Path(); //! Space - down

      path.moveTo(0, size.height * 0.85);
      path.quadraticBezierTo(size.width * 0.15, size.height * 0.55,
          size.width * 1.35, size.height * 0.5);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);

      canvas.drawPath(path, paint);
    } else {
      //*Signup screen
      //! Shadow - up
      var path = Path();
      path.moveTo(0, size.height * 0.6);
      path.quadraticBezierTo(size.width * 0.75, size.height * 0.75,
          size.width * 1.15, size.height * 0.45);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);

      canvas.drawPath(path, shadowPaint);

      path = new Path(); //! Space - up

      path.moveTo(0, size.height * 0.50);
      path.quadraticBezierTo(
          size.width * 0.6, size.height * 0.65, size.width, size.height * 0.43);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);

      canvas.drawPath(path, paint);

      path = new Path(); //! Shadow - down

      path.moveTo(0, size.height * 0.95);
      path.quadraticBezierTo(size.width * 0.25, size.height * 0.65,
          size.width * 1.45, size.height * 0.6);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);

      canvas.drawPath(path, shadowPaint);

      path = new Path(); //! Space - down

      path.moveTo(0, size.height * 0.9);
      path.quadraticBezierTo(size.width * 0.15, size.height * 0.55,
          size.width * 1.35, size.height * 0.65);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class AuthScreen extends StatefulWidget {
  static const routeName = '/authScreen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSignup = false;
  bool _isLoading = false;

  bool _isErrorEmail = false;
  bool _isErrorPassword = false;
  bool _isErrorPasswordConf = false;

  String _emailState = '';
  String _passwordState = '';
  String _passwordConfState = '';

  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void toggleState() {
    setState(
      () {
        _isSignup = !_isSignup;
      },
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (!_isSignup) {
      // Log user in
    } else {
      Provider.of<Auth>(context, listen: false)
          .signup(_authData['email'], _authData['password']);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: height,
              width: width,
              color: Theme.of(context).accentColor,
              child: CustomPaint(
                painter: CurvePainter(_isSignup),
              ),
            ),
            Positioned(
              top: 60.h,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).accentColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 3.h,
                      blurRadius: 4.h,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                height: 80.h,
                width: 80.h,
                child: Icon(
                  MdiIcons.accountOutline,
                  color: Colors.white,
                  size: 40.h,
                ),
              ),
            ),
            Positioned(
              top: 180.h,
              child: Form(
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
                            color: Color.fromRGBO(245, 247, 249, 1.0),
                            lightSource: LightSource.topLeft,
                            intensity: 1,
                          ),
                          child: FormField<String>(
                            builder: (FormFieldState formFieldState) {
                              return TextField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: 'E-Mail',
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _emailState = value;
                                    formFieldState.didChange(value);
                                    _isErrorEmail = false;
                                  });
                                },
                              );
                            },
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty || !value.contains('@')) {
                                  setState(() {
                                    _isErrorEmail = true;
                                  });
                                  return 'Invalid email!';
                                }
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['email'] = value;
                            },
                          ),
                        ),
                      ),
                      _isErrorEmail
                          ? Text(
                              'Invalid email!',
                              style: TextStyle(
                                color: Theme.of(context).errorColor,
                                fontSize: 20.h,
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20.h),
                      Container(
                        width: 300.h,
                        height: 50.h,
                        child: Neumorphic(
                          style: NeumorphicStyle(
                            depth: -6,
                            shape: NeumorphicShape.concave,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(15)),
                            color: Color.fromRGBO(245, 247, 249, 1.0),
                            lightSource: LightSource.topLeft,
                            intensity: 1,
                          ),
                          child: FormField<String>(
                            builder: (FormFieldState formFieldState) {
                              return TextField(
                                controller: _passwordController,
                                obscureText: true,
                                textInputAction: _isSignup
                                    ? TextInputAction.next
                                    : TextInputAction.done,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _passwordState = value;
                                    formFieldState.didChange(value);
                                    _isErrorPassword = false;
                                  });
                                },
                              );
                            },
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty || value.length < 5) {
                                  setState(() {
                                    _isErrorPassword = true;
                                  });
                                  return 'Password is too short!';
                                }
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['password'] = value;
                            },
                          ),
                        ),
                      ),
                      _isErrorPassword
                          ? Text(
                              'Password is too short!',
                              style: TextStyle(
                                color: Theme.of(context).errorColor,
                                fontSize: 20.h,
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20.h),
                      _isSignup
                          ? Container(
                              width: 300.h,
                              height: 50.h,
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                  depth: -6,
                                  shape: NeumorphicShape.concave,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(15)),
                                  color: Color.fromRGBO(245, 247, 249, 1.0),
                                  lightSource: LightSource.topLeft,
                                  intensity: 1,
                                ),
                                child: FormField<String>(
                                  builder: (FormFieldState formFieldState) {
                                    return TextField(
                                      obscureText: true,
                                      enabled: _isSignup,
                                      textInputAction: TextInputAction.done,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: 'Confirm password',
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          _passwordConfState = value;
                                          formFieldState.didChange(value);
                                          _isErrorPasswordConf = false;
                                        });
                                      },
                                    );
                                  },
                                  validator: _isSignup
                                      ? (value) {
                                          if (value !=
                                                  _passwordController.text ||
                                              value.isEmpty) {
                                            setState(() {
                                              _isErrorPasswordConf = true;
                                            });
                                            return 'Passwords do not match!';
                                          }
                                          return null;
                                        }
                                      : null,
                                ),
                              ),
                            )
                          : Container(),
                      _isErrorPasswordConf
                          ? Text(
                              'Passwords do not match!',
                              style: TextStyle(
                                color: Theme.of(context).errorColor,
                                fontSize: 20.h,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10.h,
              child: Column(
                children: [
                  _isLoading
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
                              //shadowLightColor: Colors.black,
                              // border: NeumorphicBorder(
                              //   color: Colors.black87,
                              //   isEnabled: true,
                              //   width: 0.1,
                              // ),
                            ),
                            child: Center(
                              child: Text(
                                '${_isSignup ? 'Signup' : 'Login'}',
                                style: TextStyle(
                                    fontSize: 20.h,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            onPressed: _submit,
                          ),
                        ),
                  FlatButton(
                    onPressed: toggleState,
                    child: Text('${!_isSignup ? 'Signup' : 'Login'} instead!'),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
