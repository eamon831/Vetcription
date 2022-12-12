import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

import '../Model/UserModel.dart';

class NearByDoctor extends StatefulWidget {
  UserModel userModel;
  NearByDoctor({Key key,this.userModel}) : super(key: key);

  @override
  State<NearByDoctor> createState() => _NearByDoctorState();
}

class _NearByDoctorState extends State<NearByDoctor> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData> _locationSubscription;
  @override
  void initState() {
    // TODO: implement initState
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Doctos's"),
        bottomOpacity: 0.00,
        elevation: 0.00,
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    _getLocation();
                  },
                  child: Text('add my location')),
              TextButton(
                  onPressed: () {
                    _listenLocation();
                  },
                  child: Text('enable live location')),
              TextButton(
                  onPressed: () {
                    _stopListening();
                  },
                  child: Text('stop live location')),
            ],
          ),
          Expanded(
              child: StreamBuilder(
                stream:
                FirebaseFirestore.instance.collection('Doctors').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title:
                          Text(snapshot.data.docs[index]['name'].toString()),
                          subtitle: Row(
                            children: [
                              Text(snapshot.data.docs[index]['latitude']
                                  .toString()),
                              SizedBox(
                                width: 20,
                              ),
                              Text(snapshot.data.docs[index]['longitude']
                                  .toString()),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.directions),
                            onPressed: () {
                              /*Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      MyMap(snapshot.data.docs[index].id)));*/
                            },
                          ),
                        );
                      });
                },
              ),),

/*
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 100,
                              width: 100,
                              child: Image.asset('assets/images/doctor_img.jpg',fit: BoxFit.fill),

                          ),
                           SizedBox(
                             width: 5,
                           ),
                          Column(
                            children: [
                              Text("Name       :"),
                              Text("Role          :"),
                              Text("Address   :"),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: 100),
          ),
*/
        ],
      ),
    );
  }

  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection('Patient').doc(FirebaseAuth.instance.currentUser.uid).set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'name': widget.userModel.name,
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection('Patient').doc('user1').set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': widget.userModel.name,
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
