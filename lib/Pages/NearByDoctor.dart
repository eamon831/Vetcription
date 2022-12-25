import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/UserModel.dart';
import 'MyMap.dart';

class NearByDoctor extends StatefulWidget {
  UserModel userModel;

  NearByDoctor({Key key, this.userModel}) : super(key: key);

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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Doctor's"),
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
                  FirebaseFirestore.instance.collection('Doctors').snapshots(),
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
            ),
          ),

        ],
      ),
    );
  }

  _getLocation() async {
    toast("ususu");

    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance
          .collection('Patient')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
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
