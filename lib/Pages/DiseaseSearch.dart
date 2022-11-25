import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DiseaseSearch extends StatefulWidget {
  DiseaseSearch({Key key}) : super(key: key);

  @override
  State<DiseaseSearch> createState() => _DiseaseSearchState();
}

class _DiseaseSearchState extends State<DiseaseSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Disease's"),
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
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.amber[100]),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            child: Text("Disease Name "),
                          ),
                          SizedBox(
                            width: 32,
                          ),
                          Container(
                            child: Expanded(child: Text(": Disease Name ")),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            child: Text("Disease Descriptin"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Expanded(
                              child: Text(": Disease Description Will Be Here"),
                            ),
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
