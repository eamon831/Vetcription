import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class NearByDoctor extends StatefulWidget {
  NearByDoctor({Key key}) : super(key: key);

  @override
  State<NearByDoctor> createState() => _NearByDoctorState();
}

class _NearByDoctorState extends State<NearByDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Doctos's"),
        bottomOpacity: 0.00,
        elevation: 0.00,
      ),
      body: ListView.separated(
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
    );
  }
}
