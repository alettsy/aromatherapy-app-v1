import 'package:Aromatherapy/models/OtherUsesObject.dart';
import 'package:flutter/material.dart';
import '../utils/FileLoader.dart';
import '../models/ConditionObject.dart';
import '../models/EmotionObject.dart';
import '../models/OtherUsesObject.dart';

import '../pages/Condition.dart';
import '../pages/Emotion.dart';
import '../pages/Other.dart';


class TabCard extends StatefulWidget {
  final List<dynamic> uses;
  final List<dynamic> emotions;
  final List<dynamic> others;

  TabCard({this.emotions, this.uses, this.others});

  @override
  _TabCardState createState() => _TabCardState();
}

class _TabCardState extends State<TabCard> with TickerProviderStateMixin {
  var uses = List<ConditionObject>();
  var emotions = List<EmotionObject>();
  var others = List<OtherUsesObject>();
  TabController _con;
  int currentHeight = 1;

  var _tabs = List<Tab>();
  int doneCount = 0;

  void initState(){
    super.initState();
    _loadStuff();
  }

  void _loadStuff() async{
    await _loadUses();
    await _loadEmotions();
    await _loadOtherUses();

    _changeController();
  }

  void _changeController(){
    _con = TabController(length: _tabs.length, vsync: this);
    _con.addListener(_tabChanged);

    if(_tabs.isNotEmpty){
      int temp = getCount(0);

      setState(() {
        currentHeight = temp * 56;
      });
    }
  }

  void _tabChanged(){
    int height = 0;

    if (_con.index == 0){
      height = getCount(0);
    } else if (_con.index == 1){
      height = getCount(1);
    } else {
      height = getCount(2);
    }
    height *= 56;

    setState(() {
      currentHeight = height;
    });
  }

  int getCount(int index){
    switch(_tabs[index].text){
      case "Conditions":
        return uses.length;
      case "Emotions":
        return emotions.length;
      default:
        return others.length;
    }
  }

  void _loadOtherUses() async{
    final loaded = await FileLoader().searchOtherUses(widget.others);

    setState(() {
      others = loaded;
      if (loaded.isNotEmpty) _tabs.add(Tab(text: "Other Uses"));
      _changeController();
    });

    doneCount++;
  }

  void _loadUses() async{
    final loaded = await FileLoader().searchUses(widget.uses);

    setState(() {
      uses = loaded;
      if (loaded.isNotEmpty) _tabs.add(Tab(text: "Conditions"));
      _changeController();
    });

    doneCount++;
  }

  void _loadEmotions() async{
    final loaded = await FileLoader().searchEmotions(widget.emotions);

    setState(() {
      emotions = loaded;
      if (loaded.isNotEmpty) _tabs.add(Tab(text: "Emotions"));
      _changeController();
    });

    doneCount++;
  }

  Widget getConditionsTab(){
    return Column(
      children: <Widget>[
        for(ConditionObject use in uses) ListTile(
          title: Text(use.name),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey.withOpacity(0.5),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => Condition(condition: use)
            ));
          },
        )
      ],
    );
  }

  Widget getEmotionsTab(){
    return Column(
      children: <Widget>[
        for(EmotionObject emotion in emotions) ListTile(
          title: Text(emotion.name),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey.withOpacity(0.5),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => Emotion(emotion: emotion)
            ));
          },
        )
      ],
    );
  }

  Widget getOtherUsesTab(){
    return Column(
      children: <Widget>[
        for(OtherUsesObject use in others) ListTile(
          title: Text(use.name),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey.withOpacity(0.5),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => Other(other: use)
            ));
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return (doneCount == 3) ? Card(
      child: Column(
        children: <Widget>[
          Container(
            child: TabBar(
              labelColor: Colors.black,
              controller: _con,
              tabs: _tabs
            )
          ),

          Container(
            height: currentHeight.toDouble(),
            child: TabBarView(
              controller: _con,
              children: [
                if(uses.isNotEmpty)getConditionsTab(),
                if(emotions.isNotEmpty)getEmotionsTab(),
                if(others.isNotEmpty)getOtherUsesTab()
              ]
            )
          )
        ],
      )
    ) : Card();
  }
}
