import 'package:flutter/material.dart';
import '../models/EmotionObject.dart';

class EmotionInfoCard extends StatelessWidget {
  final EmotionObject emotion;

  EmotionInfoCard({this.emotion});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  emotion.name,
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
}
