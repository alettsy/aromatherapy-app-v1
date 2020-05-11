import 'package:flutter/material.dart';
import 'NavDrawer.dart';
import '../models/OilObject.dart';
import '../models/ConditionObject.dart';
import '../utils/FileLoader.dart';
import '../wid/TabCard.dart';
import '../wid/OilInfoCard.dart';
import '../wid/FavouritesButton.dart';

class Oil extends StatelessWidget {
  final OilObject oil;
  Oil({this.oil});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
            title: Text(oil.name)
        ),
        body: _Oil(oil: oil)
    );
  }
}

class _Oil extends StatefulWidget {
  final OilObject oil;
  _Oil({this.oil});

  @override
  __OilState createState() => __OilState();
}

class __OilState extends State<_Oil> {
  ScrollController _con = ScrollController();
  var links = List<ConditionObject>();

  void initState(){
    super.initState();
    _loadLinks();
  }

  void _loadLinks() async{
    final loaded = await FileLoader().searchUses(widget.oil.uses);

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
                    type: "oil",
                    value: widget.oil.name
                ),

                OilInfoCard(oil: widget.oil),

                //UseCard(uses: widget.oil.uses),
                //EmotionCard(emotions: widget.oil.emotions)

                TabCard(
                  uses: widget.oil.uses,
                  emotions: widget.oil.emotions,
                  others: widget.oil.otherUses,
                )
              ],
            )
        )
    );
  }
}
