import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileWriter{
  Future<File> _setupFile(String type) async{
    final path = await getApplicationSupportDirectory();

    File file;

    if (type == "oil"){
      file = File("${path.path}/fave_oils.txt");
    } else if (type == "use"){
      file = File("${path.path}/fave_uses.txt");
    } else if (type == "other"){
      file = File("${path.path}/fave_other_uses.txt");
    } else{
      file = File("${path.path}/fave_emotions.txt");
    }

    return file;
  }

  void addFavourite(String type, String value) async{
    final File file = await _setupFile(type);
    String data = await file.readAsString();

    String result = data + value + ",";

    file.writeAsString(result);
  }

  void removeFavourite(String type, String value) async{
    final File file = await _setupFile(type);
    final data = await file.readAsString();

    String result = "";
    for(String s in data.split(",")){
      if (s != value){
        result += s + ",";
      }
    }

    file.writeAsString(result);
  }
}