import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vetcription/Pages/Login.dart';
import 'package:vetcription/Session/SessionManager.dart';

import 'Dashboard.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({Key key}) : super(key: key);

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {

  // SharedPreferences prefs;
  SessionManager prefs = SessionManager();
  bool isLogin = false;

  @override
  void initState() {
    _getIsLogin();
    super.initState();
  }

  _getIsLogin() async {
    isLogin = await prefs.getIsLogin();
    navigationPage();
  }

  void navigationPage() async {
    await Future.delayed(Duration(seconds: 1));
    if (!isLogin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard(userMode: "Doctor",)));
    }
  }

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        child: Image.asset('assets/images/splash.png'),
      ),
    );
  }
}
// TODO Implement this library.