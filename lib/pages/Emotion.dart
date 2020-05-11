import 'package:flutter/material.dart';
import '../pages/NavDrawer.dart';

import '../models/EmotionObject.dart';
import '../wid/FavouritesButton.dart';
import '../wid/EmotionInfoCard.dart';
import '../wid/OilCard.dart';

class Emotion extends StatelessWidget {
  final EmotionObject emotion;
  Emotion({this.emotion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
            title: Text(emotion.name)
        ),
        body: _Emotion(emotion: emotion)
    );
  }
}

class _Emotion extends StatefulWidget {
  final EmotionObject emotion;
  _Emotion({this.emotion});

  @override
  __EmotionState createState() => __EmotionState();
}

class __EmotionState extends State<_Emotion> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            child: Column(
              children: <Widget>[
                FavouriteButton(
                    type: "emotion",
                    value: widget.emotion.name
                ),

                EmotionInfoCard(emotion: widget.emotion),

                OilCard(oils: widget.emotion.oils)
              ],
            )
        )
    );
  }
}

