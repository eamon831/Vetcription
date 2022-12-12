import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vetcription/Pages/DiseaseSearch.dart';
import 'package:vetcription/Pages/NearByDoctor.dart';
import 'package:vetcription/Pages/NearByPatient.dart';
import 'package:vetcription/Pages/SavedMedicine.dart';
import 'package:vetcription/Pages/SearchMedicine.dart';

import '../Model/UserModel.dart';

class Dashboard extends StatefulWidget {
  String userMode;
  UserModel userModel;

  Dashboard({Key key, this.userMode,this.userModel}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("DashBoard"),
              bottomOpacity: 0.00,
              elevation: 0.00,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchMedicine()));

                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 5,
                            // color: Colors.red,
                            decoration: BoxDecoration(
                                border: Border.all(width: 5),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blueGrey),

                            child: Column(
                              children: [
                                Icon(Icons.medical_services_rounded, size: 100),
                                Text(
                                  "Search Medicine",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DiseaseSearch()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 5,
                            // color: Colors.red,
                            decoration: BoxDecoration(
                                border: Border.all(width: 5),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blueGrey),

                            child: Column(
                              children: [
                                Icon(Icons.healing_outlined, size: 100),
                                Text(
                                  "Disease",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Visibility(
                        visible: widget.userMode=="User",
                        child: Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>NearByDoctor()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 5,
                              // color: Colors.red,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 5),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blueGrey),

                              child: Column(
                                children: [
                                  Icon(Icons.person, size: 100),
                                  Text(
                                    "Nearby Doctor's",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.userMode=="Doctor",
                        child: Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>NearByPatient(userModel: widget.userModel,)));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 5,
                              // color: Colors.red,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 5),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blueGrey),

                              child: Column(
                                children: [
                                  Icon(Icons.person, size: 100),
                                  Text(
                                    "Nearby Patient's",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SavedMedicine()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 5,
                            // color: Colors.red,
                            decoration: BoxDecoration(
                                border: Border.all(width: 5),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blueGrey),

                            child: Column(
                              children: [
                                Icon(Icons.access_time_filled, size: 100),
                                Text(
                                  "Saved Medicine",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Visibility(
                        visible: false,
                        child: Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>NearByDoctor(userModel: widget.userModel,)));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 5,
                              // color: Colors.red,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 5),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blueGrey),

                              child: Column(
                                children: [
                                  Icon(Icons.person, size: 100),
                                  Text(
                                    "Nearby Doctor's",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: true,
                        child: Expanded(
                          child: InkWell(
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 5,
                              // color: Colors.red,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 5),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blueGrey),

                              child: Column(
                                children: [
                                  Icon(Icons.person, size: 100),
                                  Text(
                                    "Log Out",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                        width: 10,
                      ),
                    ],
                  ),
                ),

              ],
            ),
          );
  }
}
