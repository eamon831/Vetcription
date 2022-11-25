import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NearByPatient extends StatefulWidget {
  const NearByPatient({Key key}) : super(key: key);

  @override
  State<NearByPatient> createState() => _NearByPatientState();
}

class _NearByPatientState extends State<NearByPatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Patient's"),
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
                      child: Image.asset('assets/images/profile_img.jpg',fit: BoxFit.fill),

                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        Text("Name       :"),
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
