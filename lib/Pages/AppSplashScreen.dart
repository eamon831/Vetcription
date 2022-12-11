import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vetcription/Model/UserModel.dart';
import 'package:vetcription/Pages/Login.dart';
import 'package:vetcription/Session/SessionManager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    //_getIsLogin();
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
          context,
          MaterialPageRoute(
              builder: (context) => Dashboard(
                    userMode: "Doctor",
                  )));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return Center(
                child: CircularProgressIndicator()); // 👈 user is loading
          }
          if (snapshot.hasData) {
            final user = snapshot.data;
            final uid = user.uid; // 👈 get the UID
            if (user != null) {
              print(user);
            
              CollectionReference users =
                  FirebaseFirestore.instance.collection('userData');
            
              return FutureBuilder<DocumentSnapshot>(
                future: users.doc(uid).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {

                    return Text("Something went wrong");
                  }
            
                  if (snapshot.hasData && !snapshot.data.exists) {
                    return Text("Document does not exist");
                  }
            
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data.data() as Map<String, dynamic>;
                    UserModel user=UserModel.fromJson(data);
                    print(user.toJson().toString());
                    return Dashboard(userMode: user.userType);
                  }
            
                  return Text("loading");
                },
              );
            } else {
              return Text("user is not logged in");
            }
          }else{
            return Login();
          }
        },
/*
      body: StreamBuilder<User>(

        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot) {
          if(snapshot.hasData){
           final temp=FirebaseFirestore.instance.collection('userData').doc(snapshot.data.uid);
           print(temp.toString()+" tessst");
           print(temp.firestore.toString());
          return Dashboard(userMode: "Doctor");
            */
/*Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Dashboard(userMode: "Doctor",)));*/ /*

          }else{
            return Login();

            */
/*Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Login()));*/ /*

          }
        },
        */
/*child: Container(
          alignment: Alignment.center,
          child: Image.asset('assets/images/splash.png'),
        ),*/ /*

      ),
*/
      ),
    );
  }
}
