import 'package:flutter/material.dart';
import '../models/EmotionObject.dart';
import '../utils/FileLoader.dart';
import '../pages/Emotion.dart';

class EmotionCard extends StatefulWidget {
  final List<dynamic> emotions;

  EmotionCard({this.emotions});

  @override
  _EmotionCardState createState() => _EmotionCardState();
}

class _EmotionCardState extends State<EmotionCard> {
  var emotions = List<EmotionObject>();

  void initState(){
    super.initState();
    _loadFile();
  }

  void _loadFile() async{
    final loaded = await FileLoader().searchEmotions(widget.emotions);

    setState(() {
      emotions = loaded;
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
              Text(
                  "Emotions",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  )
              ),

              for(EmotionObject emotion in emotions) ListTile(
                title: Text(emotion.name),
                trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.withOpacity(0.5)
                ),

                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Emotion(emotion: emotion)
                  ));
                },
              )
            ],
          ),
        )
    );
  }
}
