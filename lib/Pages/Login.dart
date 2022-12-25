import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vetcription/Pages/Dashboard.dart';
import 'package:vetcription/SignUpPages/SignUpForDoctor.dart';
import 'package:vetcription/SignUpPages/SignUpForUser.dart';
import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log In"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value.isEmptyOrNull) {
                        return "This Field Is Required";
                      }
                      final bool isValid = EmailValidator.validate(value);
                      if (isValid == false) {
                        return "Please Enter A Valid Email";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: "Email Address ",
                      hintText: "Enter your Email Address",
                      prefixIcon: Icon(Icons.email_outlined),
                      hintStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      labelStyle:
                          TextStyle(fontSize: 13, color: Colors.redAccent),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    )),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: _passwordController,
                    validator: (value){
                      if(value.isEmptyOrNull){
                        return "This Field Is Required";
                      }
                      if(value.length<6){
                        return "Password Should Be At Least 6 Character";
                      }
                      return null;

                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your Password",
                      prefixIcon: Icon(Icons.password_sharp),
                      hintStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      labelStyle:
                          TextStyle(fontSize: 13, color: Colors.redAccent),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    )),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _signIn();
                    }
                    /*
                    if(_passwordController.text=="1"){
                      toast("Dcotor Mode");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(userMode: "Doctor",)));

                    }else{
                      toast("User Mode");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(userMode: "User",)));

                    }*/
                  },
                  child: Text("Login"),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpForDoctor()));
                  },
                  child: Text("Sign Up Doctor's"),
                ),
                SizedBox(
                  width: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpForUser()));
                  },
                  child: Text("Sign Up For Pet Owner's"),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _signIn() async {
    /*showDialog(
      context:context,
      builder:(context)=>Center(child:CircularProgressIndicator()));*/

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on Exception catch (e) {
      // TODO
    }
    // navigatorKey.currentState.popUntil((route) => route.isCurrent);
  }
}
