import 'dart:io';

import 'package:flutter/material.dart';
import 'NavDrawer.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'Emotion.dart';

import '../utils/FileLoader.dart';
import '../models/EmotionObject.dart';
import 'NavDrawer.dart';

class Emotions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
            title: Text("Emotions")
        ),
        body: _Emotions()
    );
  }
}

class _Emotions extends StatefulWidget {
  @override
  __EmotionsState createState() => __EmotionsState();
}

class __EmotionsState extends State<_Emotions> {
  TextEditingController editingController = TextEditingController();
  List<EmotionObject> emotions = new List<EmotionObject>();
  var dupe = new List<EmotionObject>();

  void initState(){
    super.initState();

    _loadFile();
  }

  void _loadFile() async{
    final fileLoader = new FileLoader();
    final temp = await fileLoader.loadEmotions();

    dupe.addAll(temp);
    setState(() {
      emotions = temp;
    });
  }

  void filterSearchResults(String query){
    List<EmotionObject> dummy = new List<EmotionObject>();
    dummy.addAll(dupe);

    if (query.isNotEmpty){
      List<EmotionObject> dummyData = List<EmotionObject>();
      dummy.forEach((item){
        if (item.name.toLowerCase().contains(query.toLowerCase())){
          dummyData.add(item);
        }
      });

      setState(() {
        emotions = dummyData;
      });
      return;
    } else {
      setState(() {
        emotions = dupe;
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
                  itemCount: emotions.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return ListTile(
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      title: Text(emotions[index].name),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Emotion(emotion: emotions[index])
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

