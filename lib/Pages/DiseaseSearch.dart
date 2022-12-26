import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vetcription/Model/Disease.dart';

import '../DatabaseHelper/DataBaseHelper.dart';

class DiseaseSearch extends StatefulWidget {
  DiseaseSearch({Key key}) : super(key: key);

  @override
  State<DiseaseSearch> createState() => _DiseaseSearchState();
}

class _DiseaseSearchState extends State<DiseaseSearch> {
  DatabaseHelper databaseHelper=DatabaseHelper.instance;
  List<Disease> _diseaseList=[];

  TextEditingController _searchController=TextEditingController();

  @override
  void initState() {
    _getDisease();
  }
  Future<void> _getDisease() async {
    //toast("hello");
    _diseaseList.clear();
    await databaseHelper.getAll('disease_data').then((value) {
      value.forEach((element) {
        setState(() {
          // print(element);
          _diseaseList.add(Disease.fromJson(element));
        });
      });
    });


  }
  Future<void> filterSearchResults(String query) async {


    if(query.isNotEmpty) {
      var data=await databaseHelper.diseaseSearch(query);
      //toast(data.length.toString());
      setState(() {
        _diseaseList=data;
      });

    } else {
      _getDisease();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        title: Text("Disease"),
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
              //databaseHelper.
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
              itemCount: _diseaseList.length,
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
                                  "Name",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                width: 90,
                              ),
                              Container(
                                child: Text(":"),
                                width: 10,
                              ),
                              Container(
                                child: Expanded(child: Text(_diseaseList[index].name!=null?_diseaseList[index].name:'None')),
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
                                  "Description",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                width: 90,
                              ),
                              Container(
                                child: Text(":"),
                                width: 10,
                              ),
                              Container(
                                child: Expanded(child: Text(_diseaseList[index].desCripTion!=null?_diseaseList[index].desCripTion:'None')),
                              ),
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
