import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vetcription/Model/UserModel.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'MyMap.dart';
import 'package:url_launcher/url_launcher.dart';


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
  void initState() {
    _requestPermission();

    super.initState();
  }
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
/*
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
*/
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
                      return Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          color: Colors.amber[100],
                          child: ListTile(
                            title: Text(snapshot.data.docs[index]['name'].toString()),

                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                5.height,
                                Row(
                                  children: [
                                    Text("latitude "+snapshot.data.docs[index]['latitude']
                                        .toString()),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("longitude "+snapshot.data.docs[index]['longitude'].toString()),
                                  ],
                                ),
                                5.height,
                                Text("phone "+snapshot.data.docs[index]['phone'].toString()),

                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.directions),
                              onPressed: () async {
                                final loc.LocationData _locationResult = await location.getLocation();
                                launchMapsUrl(_locationResult.latitude, _locationResult.longitude, snapshot.data.docs[index]['latitude']
                                    .toString(), snapshot.data.docs[index]['longitude']
                                    .toString());
                              },
                            ),
                          ),
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
      await FirebaseFirestore.instance.collection('Doctors').doc(FirebaseAuth.instance.currentUser.uid).set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': widget.userModel.name,
        'phone':widget.userModel.phone,

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
      location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
      location.enableBackgroundMode(enable: true);
      _listenLocation();
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
  static void launchMapsUrl(
      sourceLatitude,
      sourceLongitude,
      destinationLatitude,
      destinationLongitude) async {
    String mapOptions = [
      'saddr=$sourceLatitude,$sourceLongitude',
      'daddr=$destinationLatitude,$destinationLongitude',
      'dir_action=navigate'
    ].join('&');

    final url = 'https://www.google.com/maps?$mapOptions';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }  }
}
