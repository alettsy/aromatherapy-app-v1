import 'package:flutter/material.dart';
import '../models/ConditionObject.dart';
import '../utils/FileLoader.dart';
import '../pages/Condition.dart';

class UseCard extends StatefulWidget {
  final List<dynamic> uses;

  UseCard({this.uses});

  @override
  _UseCardState createState() => _UseCardState();
}

class _UseCardState extends State<UseCard> {
  var uses = List<ConditionObject>();

  void initState(){
    super.initState();
    _loadFile();
  }

  void _loadFile() async{
    final loaded = await FileLoader().searchUses(widget.uses);

    setState(() {
      uses = loaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Uses",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),

            for(ConditionObject use in uses) ListTile(
              title: Text(use.name),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.withOpacity(0.5)
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Condition(condition: use)
                ));
              },
            )
          ],
        )
      )
    );
  }
}
