import 'package:flutter/material.dart';
import '../models/OtherUsesObject.dart';
import 'NavDrawer.dart';
import '../wid/FavouritesButton.dart';
import '../wid/OilCard.dart';

class Other extends StatelessWidget {
  final OtherUsesObject other;
  Other({this.other});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text(other.name)
      ),
      body: _Other(other: other)
    );
  }
}

class _Other extends StatefulWidget {
  final OtherUsesObject other;
  _Other({this.other});

  @override
  __OtherState createState() => __OtherState();
}

class __OtherState extends State<_Other> {
  Widget infoCard(){
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    widget.other.name,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    )
                )
              ],
            )
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            FavouriteButton(type: "other", value: widget.other.name),

            infoCard(),

            OilCard(oils: widget.other.oils)
          ],
        )
      )
    );
  }
}


