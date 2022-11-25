import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vetcription/Utils/Colors.dart';

import 'Pages/AppSplashScreen.dart';
import 'Utils/Colors.dart';




void main() {
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.offset
    ..maskType = EasyLoadingMaskType.black;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     setStatusBarColor(Colors.blue);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vetcription',
      builder: EasyLoading.init(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.blue),
        primaryColor: t1_colorPrimary,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppSplashScreen(),
    );
  }
}






