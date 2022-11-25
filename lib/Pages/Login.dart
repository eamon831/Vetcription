import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vetcription/Pages/Dashboard.dart';
import 'package:vetcription/SignUpPages/SignUpForDoctor.dart';
import 'package:vetcription/SignUpPages/SignUpForUser.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _numberController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log In"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              TextFormField(
                controller: _numberController,
                  decoration: InputDecoration(
                labelText: "Phone Number",
                hintText: "Enter your Phone Number",
                prefixIcon: Icon(Icons.phone),
                hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                labelStyle: TextStyle(fontSize: 13, color: Colors.redAccent),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              )),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _passwordController,
                  decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter your Password",
                prefixIcon: Icon(Icons.password_sharp),
                hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                labelStyle: TextStyle(fontSize: 13, color: Colors.redAccent),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              )),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if(_passwordController.text=="1"){
                    toast("Dcotor Mode");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(userMode: "Doctor",)));

                  }else{
                    toast("User Mode");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(userMode: "User",)));

                  }

                },
                child: Text("Login"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpForDoctor()));
                },
                child: Text("Sign Up Doctor's"),
              ),
              SizedBox(
                width: 50,
              ),ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SignUpForUser()));
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
    );
  }
}
