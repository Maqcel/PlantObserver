import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/providers/potDecorationProvider.dart';

import 'providers/plantsListProvider.dart';
import 'screens/homePage.dart';
import 'screens/plantDataScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //! App was designed on the Redmi note 8 pro
  ScreenUtil.init(
    allowFontScaling: false,
    designSize: Size(392.7, 803.6),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlantsManagement()),
        ChangeNotifierProvider(create: (context) => PotDecorationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PlantObserver',
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Color.fromRGBO(48, 160, 95, 1.0),
          textTheme: TextTheme(
            bodyText2: TextStyle(
              fontSize: 65.h,
              color: Colors.black,
              fontFamily: 'RobotoCondensed',
            ),
            headline6: TextStyle(
              fontSize: 60.h,
              fontFamily: 'RobotoCondensed',
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: PlantDataScreen.routeName, //! speed up testing
        home: HomePage(),
        routes: {
          HomePage.routeName: (context) => HomePage(),
          PlantDataScreen.routeName: (context) => PlantDataScreen(),
        },
      ),
    );
  }
}
