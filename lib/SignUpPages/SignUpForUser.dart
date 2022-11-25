import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Pages/Dashboard.dart';

class SignUpForUser extends StatefulWidget {
  const SignUpForUser({Key key}) : super(key: key);

  @override
  State<SignUpForUser> createState() => _SignUpForUserState();
}

class _SignUpForUserState extends State<SignUpForUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _regiController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();
  TextEditingController _confirmPassWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up User's"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This Field Can't Be Empty";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,

                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "Enter your Name",
                    prefixIcon: Icon(Icons.person),
                    hintStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    labelStyle:
                    TextStyle(fontSize: 13, color: Colors.redAccent),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                TextFormField(
                  controller: _mobileController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This Field Can't Be Empty";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "Mobile Number",
                    hintText: "Enter Your Mobile Number",
                    prefixIcon: Icon(Icons.mobile_friendly),
                    hintStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    labelStyle:
                    TextStyle(fontSize: 13, color: Colors.redAccent),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This Field Can't Be Empty";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter Your Email Address",
                    prefixIcon: Icon(Icons.email_outlined),
                    hintStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    labelStyle:
                    TextStyle(fontSize: 13, color: Colors.redAccent),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passWordController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This Field Can't Be Empty";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter Your Password",
                    prefixIcon: Icon(Icons.password_rounded),
                    hintStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    labelStyle:
                    TextStyle(fontSize: 13, color: Colors.redAccent),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _confirmPassWordController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This Field Can't Be Empty";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    hintText: "Repeat Your Password",
                    prefixIcon: Icon(Icons.password_rounded),
                    hintStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    labelStyle:
                    TextStyle(fontSize: 13, color: Colors.redAccent),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(userMode: "User",)));

                    }
                  },
                  child: Text("Sign Up"),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
}
