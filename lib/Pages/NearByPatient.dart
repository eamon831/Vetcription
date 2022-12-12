import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:vetcription/Model/UserModel.dart';

import 'MyMap.dart';

class NearByPatient extends StatefulWidget {
  UserModel userModel;
   NearByPatient({Key key,this.userModel}) : super(key: key);

  @override
  State<NearByPatient> createState() => _NearByPatientState();
}

class _NearByPatientState extends State<NearByPatient> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData> _locationSubscription;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Patient's"),
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
              FirebaseFirestore.instance.collection('Patient').snapshots(),
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
                            Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      MyMap(snapshot.data.docs[index].id)));
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
      await FirebaseFirestore.instance.collection('Doctors').doc(FirebaseAuth.instance.currentUser.uid).set({
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
      await FirebaseFirestore.instance.collection('Patient').doc(FirebaseAuth.instance.currentUser.uid).set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': 'john'
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
