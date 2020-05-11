import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../models/EmotionObject.dart';
import '../models/OilObject.dart';
import '../models/ConditionObject.dart';
import '../models/OtherUsesObject.dart';
import '../pages/About.dart';

class FileLoader{
  Future<bool> setupFolders(BuildContext context) async{
    try{
      final path = await getApplicationSupportDirectory();
      final File file = File("${path.path}/fave_oils.txt");
      String x = await file.readAsString();
      final File file2 = File("${path.path}/fave_uses.txt");
      String z = await file2.readAsString();
      final File file3 = File("${path.path}/fave_emotions.txt");
      String y = await file3.readAsString();
      final File file4 = File("${path.path}/fave_other_uses.txt");
      String w = await file4.readAsString();
      return true;
    } catch(e){
      final path = await getApplicationSupportDirectory();
      final File file = File("${path.path}/fave_oils.txt");
      file.writeAsString("");
      final File file2 = File("${path.path}/fave_uses.txt");
      file2.writeAsString("");
      final File file3 = File("${path.path}/fave_emotions.txt");
      file3.writeAsString("");
      final File file4 = File("${path.path}/fave_other_uses.txt");
      file4.writeAsString("");
      _startPopup(context);
      return false;
    }
  }

  void _startPopup(BuildContext context){
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
            title: Text("Important"),
            content: Text("Please visit the Information section to view all Safety"
                " and Disclaimer information before using this app!"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => About()
                  ));
                },
              )
            ],
          )
      );
    });
  }

  Future<Map<String, dynamic>> _loadFile(String filename) async{
    final file = await rootBundle.loadString(filename);
    final json = jsonDecode(file);
    return json;
  }

  Future<List<OilObject>> loadOils() async{
    Map<String, dynamic> json = await _loadFile("assets/res/oils.json");

    final loadedOils = new List<OilObject>();
    for(int i = 0; i < json["oils"].length; i++){
      final temp = new OilObject(
        name: json["oils"][i]["name"],
        binomial: json["oils"][i]["binomial"],
        image: json["oils"][i]["image"],
        description: json["oils"][i]["description"],
        uses: json["oils"][i]["uses"],
        emotions: json["oils"][i]["emotions"],
        otherUses: json["oils"][i]["other"]
      );

      loadedOils.add(temp);
    }

    return loadedOils;
  }

  Future<List<ConditionObject>> loadUses() async{
    Map<String, dynamic> json = await _loadFile("assets/res/uses.json");

    final loadedUses = new List<ConditionObject>();
    for(int i = 0; i < json["uses"].length; i++){
      final temp = new ConditionObject(
        name: json["uses"][i]["name"],
        description: json["uses"][i]["description"],
        carrier: json["uses"][i]["carrier"],
        application: json["uses"][i]["application"],
        otherMethods: json["uses"][i]["other_methods"],
        oils: json["uses"][i]["oils"]
      );

      loadedUses.add(temp);
    }

    return loadedUses;
  }

  Future<List<OtherUsesObject>> loadOtherUses() async{
    Map<String, dynamic> json = await _loadFile("assets/res/other_uses.json");

    final loaded = List<OtherUsesObject>();
    for(int i = 0; i < json["others"].length; i++){
      final temp = new OtherUsesObject(
        name: json["others"][i]["name"],
        oils: json["others"][i]["oils"]
      );
      loaded.add(temp);
    }

    return loaded;
  }

  Future<List<EmotionObject>> loadEmotions() async{
    Map<String, dynamic> json = await _loadFile("assets/res/emotions.json");

    final loadedUses = new List<EmotionObject>();
    for(int i = 0; i < json["emotions"].length; i++){
      final temp = new EmotionObject(
        name: json["emotions"][i]["name"],
        oils: json["emotions"][i]["oils"]
      );

      loadedUses.add(temp);
    }

    return loadedUses;
  }

  // TODO: can reduce these three down to one function
  Future<List<dynamic>> loadFaveEmotions() async{
    final path = await getApplicationSupportDirectory();
    final File file  = File("${path.path}/fave_emotions.txt");

    String temp = await file.readAsString();
    List<String> loadedFaves = temp.split(",");

    return loadedFaves;
  }

  Future<List<dynamic>> loadFaveOtherUses() async{
    final path = await getApplicationSupportDirectory();
    final File file  = File("${path.path}/fave_other_uses.txt");

    String temp = await file.readAsString();
    List<String> loadedFaves = temp.split(",");

    return loadedFaves;
  }

  Future<List<dynamic>> loadFaveOils() async{
    final path = await getApplicationSupportDirectory();
    final File file  = File("${path.path}/fave_oils.txt");

    String temp = await file.readAsString();
    List<String> loadedFaves = temp.split(",");

    return loadedFaves;
  }

  Future<List<dynamic>> loadFaveUses() async{
    final path = await getApplicationSupportDirectory();
    final File file  = File("${path.path}/fave_uses.txt");

    String temp = await file.readAsString();
    List<String> loadedFaves = temp.split(",");

    return loadedFaves;
  }


  Future<List<ConditionObject>> searchUses(List<dynamic> uses) async{
    Map<String, dynamic> json = await _loadFile("assets/res/uses.json");
    final objects = await loadUses();

    final loadedUses = new List<ConditionObject>();
    for(String s in uses){
      for(ConditionObject u in objects){
        if (u.name == s){
          loadedUses.add(u);
          continue;
        }
      }
    }

    return loadedUses;
  }

  Future<List<OilObject>> searchOils(List<dynamic> oils) async{
    Map<String, dynamic> json = await _loadFile("assets/res/uses.json");
    final objects = await loadOils();

    final loadedOils = new List<OilObject>();
    for(String s in oils){
      for(OilObject u in objects){
        if (u.name == s || u.binomial == s){
          loadedOils.add(u);
          continue;
        }
      }
    }

    return loadedOils;
  }

  Future<List<OtherUsesObject>> searchOtherUses(List<dynamic> others) async{
    Map<String, dynamic> json = await _loadFile("assets/res/other_uses.json");
    final objects = await loadOtherUses();

    final loadedOthers = new List<OtherUsesObject>();
    for(String s in others){
      for(OtherUsesObject u in objects){
        if (u.name == s){
          loadedOthers.add(u);
          continue;
        }
      }
    }

    return loadedOthers;
  }

  Future<List<EmotionObject>> searchEmotions(List<dynamic> emotions) async{
    Map<String, dynamic> json = await _loadFile("assets/res/emotions.json");
    final objects = await loadEmotions();

    final loadedEmotions = new List<EmotionObject>();
    for(String s in emotions){
      for(EmotionObject u in objects){
        if (u.name == s){
          loadedEmotions.add(u);
          continue;
        }
      }
    }

    return loadedEmotions;
  }
}