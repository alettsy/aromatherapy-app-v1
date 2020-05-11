import 'dart:io';

import 'package:flutter/material.dart';
import 'NavDrawer.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'Emotion.dart';

import '../utils/FileLoader.dart';
import '../models/OtherUsesObject.dart';
import 'Other.dart';
import 'NavDrawer.dart';

class Others extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
            title: Text("Other Uses")
        ),
        body: _Others()
    );
  }
}

class _Others extends StatefulWidget {
  @override
  __OthersState createState() => __OthersState();
}

class __OthersState extends State<_Others> {
  TextEditingController editingController = TextEditingController();
  List<OtherUsesObject> others = new List<OtherUsesObject>();
  var dupe = new List<OtherUsesObject>();

  void initState(){
    super.initState();

    _loadFile();
  }

  void _loadFile() async{
    final fileLoader = new FileLoader();
    final temp = await fileLoader.loadOtherUses();

    dupe.addAll(temp);
    setState(() {
      others = temp;
    });
  }

  void filterSearchResults(String query){
    List<OtherUsesObject> dummy = new List<OtherUsesObject>();
    dummy.addAll(dupe);

    if (query.isNotEmpty){
      List<OtherUsesObject> dummyData = List<OtherUsesObject>();
      dummy.forEach((item){
        if (item.name.toLowerCase().contains(query.toLowerCase())){
          dummyData.add(item);
        }
      });

      setState(() {
        others = dummyData;
      });
      return;
    } else {
      setState(() {
        others = dupe;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                onChanged: (value){
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView.separated(
                itemCount: others.length,
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return ListTile(
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    title: Text(others[index].name),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Other(other: others[index])
                      ));
                    },
                  );
                },
                separatorBuilder: (context, index){
                  return Divider();
                },
              ),
            )
          ],
        )
    );
  }
}

