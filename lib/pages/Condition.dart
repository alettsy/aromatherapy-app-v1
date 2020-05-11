import 'package:flutter/material.dart';
import 'NavDrawer.dart';
import '../models/OilObject.dart';
import '../models/ConditionObject.dart';
import '../utils/FileLoader.dart';
import '../wid/FavouritesButton.dart';
import '../wid/ConditionInfoCard.dart';
import '../wid/OilCard.dart';

class Condition extends StatelessWidget {
  final ConditionObject condition;
  Condition({this.condition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
            title: Text(condition.name)
        ),
        body: _Condition(condition: condition)
    );
  }
}

class _Condition extends StatefulWidget {
  final ConditionObject condition;
  _Condition({this.condition});

  @override
  __ConditionState createState() => __ConditionState();
}

class __ConditionState extends State<_Condition> {
  ScrollController _con = ScrollController();
  var links = List<OilObject>();

  void initState(){
    super.initState();
    _loadLinks();
  }

  void _loadLinks() async{
    final loaded = await FileLoader().searchOils(widget.condition.oils);

    setState(() {
      links = loaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                FavouriteButton(
                    type: "use",
                    value: widget.condition.name
                ),

                ConditionInfoCard(use: widget.condition),

                OilCard(oils: widget.condition.oils)
              ],
            )
        )
    );
  }
}
