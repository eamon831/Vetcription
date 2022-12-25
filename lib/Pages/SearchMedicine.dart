import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vetcription/DatabaseHelper/DataBaseHelper.dart';

import '../Model/Medicine.dart';

class SearchMedicine extends StatefulWidget {
  SearchMedicine({Key key}) : super(key: key);

  @override
  State<SearchMedicine> createState() => _SearchMedicineState();
}

class _SearchMedicineState extends State<SearchMedicine> {
  DatabaseHelper databaseHelper=DatabaseHelper.instance;
  List<Medicine> _medicineList=[];

  TextEditingController _searchController=TextEditingController();

  @override
  void initState() {
    _getMedicines();
  }
  Future<void> _getMedicines() async {
    //toast("hello");
    _medicineList.clear();
    await databaseHelper.getAll('vet_data').then((value) {
        value.forEach((element) {
          setState(() {
           // print(element);
            _medicineList.add(Medicine.fromJson(element));
          });
        });
    });


  }
  Future<void> filterSearchResults(String query) async {

    if(query.isNotEmpty) {
      var data=await databaseHelper.medicineSearch(query);
      //toast(data.length.toString());
      setState(() {
        _medicineList=data;
      });

    } else {
      _getMedicines();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(

          title: Text("Medicine's"),
          bottomOpacity: 0.00,
          elevation: 0.00,
         actions: [

         /*  InkWell(
             onTap: (){
               toast("Search Will Be Implemented");
             },
             child: Icon(
               Icons.search,
               size: 30,
             ),
           ),
           Padding(padding: EdgeInsets.only(right: 5),
           )*/
         ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _searchController,
              onChanged: (value){
                filterSearchResults(value);
              },
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: _medicineList.length,
                  itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(

                    decoration: BoxDecoration(
                      color: Colors.amber[100],
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Trade Name",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                width: 90,
                              ),
                              Container(
                                child: Text(":"),
                                width: 10,
                              ),
                              Container(

                                child: Text(_medicineList[index].tradeName),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Composition",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                width: 90,
                              ),
                              Container(
                                child: Text(":"),
                                width: 10,
                              ),
                              Container(
                                child: Expanded(child: Text(_medicineList[index].composition!=null?_medicineList[index].composition:'None')),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Trade Dose",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                width: 90,
                              ),
                              Container(
                                child: Text(":"),
                                width: 10,
                              ),
                              Container(
                                child: Expanded(child: Text(_medicineList[index].tradeName!=null?_medicineList[index].tradeDose:'None')),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Company",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                width: 90,
                              ),
                              Container(
                                child: Text(":"),
                                width: 10,
                              ),
                              Container(
                                child: Expanded(child: Text(_medicineList[index].company!=null?_medicineList[index].company:'None')),
                              ),
                            ],
                          ),
                        ), Padding(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Generic Name",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                width: 90,
                              ),
                              Container(
                                child: Text(":"),
                                width: 10,
                              ),
                              Container(
                                child: Expanded(child: Text(_medicineList[index].genericName!=null?_medicineList[index].genericName:'None')),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Pack Size",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                width: 90,
                              ),
                              Container(
                                child: Text(":"),
                                width: 10,
                              ),
                              Container(
                                child: Expanded(child: Text(_medicineList[index].packSize!=null?_medicineList[index].packSize:'None')),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Comments",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                width: 90,
                              ),
                              Container(
                                child: Text(":"),
                                width: 10,
                              ),
                              Container(
                                child: Expanded(child: Text(_medicineList[index].comments!=null?_medicineList[index].comments:'None')),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Details",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                width: 90,
                              ),
                              Container(
                                child: Text(":"),
                                width: 10,
                              ),
                              Container(
                                child: Expanded(child: Text(_medicineList[index].details!=null?_medicineList[index].details:'None')),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                child: ElevatedButton.icon(onPressed: () async {
                                  databaseHelper.insert(_medicineList[index].toJson(), 'saved_data');
                                  toast("Medicine Saved");
                                }, icon: Icon(Icons.add), label: Text("Save")),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        )

                      ],
                    ),

                  ),
                );
              },

              ),
            ),
          ],
        ),
    );
  }


}
