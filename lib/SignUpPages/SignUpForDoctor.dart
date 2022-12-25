import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vetcription/Pages/Dashboard.dart';

import '../Model/UserModel.dart';

class SignUpForDoctor extends StatefulWidget {
  const SignUpForDoctor({Key key}) : super(key: key);

  @override
  State<SignUpForDoctor> createState() => _SignUpForDoctorState();
}

class _SignUpForDoctorState extends State<SignUpForDoctor> {
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
        title: Text("Sign Up Doctor's"),
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
                  controller: _regiController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This Field Can't Be Empty";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "Registration Number",
                    hintText: "Enter Your Registration Number",
                    prefixIcon: Icon(Icons.app_registration),
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
                    if(value.length!=11){
                      return "Mobile Number Should Contain Exactly 11 Digit";
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
                    if (value.isEmptyOrNull) {
                      return "This Field Is Required";
                    }
                    final bool isValid = EmailValidator.validate(value);
                    if (isValid == false) {
                      return "Please Enter A Valid Email";
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
                  textInputAction: TextInputAction.next,
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
                  onPressed: () async {
                    if(_passWordController.text!=_confirmPassWordController.text){
                      toast("Password And Confirm Password Must Be Same");
                      return;
                    }
                    if(_formKey.currentState.validate()){

                      try {
                        UserModel user=UserModel();
                        user.email=_emailController.text.trim();
                        user.password=_passWordController.text.trim();
                        user.regiNumber=_regiController.text;
                        user.name=_nameController.text.trim();
                        user.phone=_mobileController.text.trim();
                        user.userType="Doctor";
                        // Create a reference to the cities collection
                        final users =await  FirebaseFirestore.instance.collection('userData').where("regi_number",isEqualTo: _regiController.text).get();

                        //final query = await users.where("regi_number", isEqualTo: _regiController.text);
                        print("${users.size} checking ${_regiController.text}");
                        if(users.size!=0){
                          toast("This Regi Number Already Exist");
                          return;
                        }


                        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text.trim(), password: _passWordController.text.trim()).then((value){
                          if(value.user.email==_emailController.text.trim()){
                            FirebaseFirestore.instance.collection('userData').doc(value.user.uid).set(user.toJson());
                            Navigator.pop(context);
                          }
                          else{
                            toast("User Already Exist");
                          }
                        });
                      } on Exception catch (e) {
                        toast(e.toString());
                        // TODO
                      }
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
