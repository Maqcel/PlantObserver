import 'package:flutter/material.dart';
import 'package:roslinki_politechnika/models/customAppBar.dart';
import 'package:roslinki_politechnika/models/customDrawer.dart';

class TryAutoLogin extends StatefulWidget {
  @override
  _TryAutoLoginState createState() => _TryAutoLoginState();
}

class _TryAutoLoginState extends State<TryAutoLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: CustomDrawer(),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
