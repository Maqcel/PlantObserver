import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roslinki_politechnika/providers/authProvider.dart';
import 'package:roslinki_politechnika/screens/managePlantScreen.dart';
import 'package:roslinki_politechnika/screens/authScreen.dart';
import 'package:roslinki_politechnika/screens/profileScreen.dart';
import 'package:roslinki_politechnika/screens/tryAutoLoginLoading.dart';

import 'providers/plantsListProvider.dart';
import 'providers/potDecorationProvider.dart';
import 'screens/homePage.dart';
import 'screens/informationScreen.dart';
import 'screens/plantDataScreen.dart';
import 'screens/statisticScreen.dart';

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
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProxyProvider<Auth, PlantsManagement>(
          update: (context, auth, previousPlants) => PlantsManagement(
              auth.token,
              previousPlants == null ? [] : previousPlants.plants,
              previousPlants == null ? [] : previousPlants.userPlants),
          create: null,
        ),
        ChangeNotifierProvider(create: (context) => PotDecorationProvider()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
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
          home: auth.isAuth
              ? HomePage()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResult) =>
                      authResult.connectionState == ConnectionState.waiting
                          ? TryAutoLogin()
                          : AuthScreen(),
                ), //? HomePage(),
          routes: {
            HomePage.routeName: (context) => HomePage(),
            PlantDataScreen.routeName: (context) =>
                PlantDataScreen(isUserPlant: null, plantId: null),
            StatisticScreen.routeName: (context) =>
                StatisticScreen(isUserPlant: null, plantId: null),
            InformationScreen.routeName: (context) => InformationScreen(
                  plantId: null,
                ),
            AuthScreen.routeName: (context) => AuthScreen(),
            ManagePlantScreen.routeName: (context) =>
                ManagePlantScreen(mode: true),
            ProfileScreen.routeName: (context) => ProfileScreen(),
          },
        ),
      ),
    );
  }
}
