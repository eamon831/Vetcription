import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SearchMedicine extends StatefulWidget {
  SearchMedicine({Key key}) : super(key: key);

  @override
  State<SearchMedicine> createState() => _SearchMedicineState();
}

class _SearchMedicineState extends State<SearchMedicine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(

          title: Text("Medicine's"),
          bottomOpacity: 0.00,
          elevation: 0.00,
         actions: [

           InkWell(
             onTap: (){
               toast("Search Will Be Implemented");
             },
             child: Icon(
               Icons.search,
               size: 30,
             ),
           ),
           Padding(padding: EdgeInsets.only(right: 5),
           )
         ],
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              decoration: BoxDecoration(
                color: Colors.amber[100]
              ),
              child: Column(
                children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     children: [
                       Container(
                         child: Text("Name "),
                       ),
                       SizedBox(
                         width: 32,

                       ),
                       Container(
                         child: Text(": Medicine Name "),
                       ),
                     ],
                   ),
                 ),
                  Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     children: [
                       Container(
                         child: Text("Group "),
                       ),
                       SizedBox(
                         width: 32,

                       ),
                       Container(
                         child: Text(": Medicine Group "),
                       ),
                     ],
                   ),
                 ),
                  Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     children: [
                       Container(
                         child: Text("Descriptin"),
                       ),
                       SizedBox(
                         width: 10,
                       ),
                       Container(
                         child: Text(": Medicine Description"),
                       ),
                     ],
                   ),
                 ),

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
