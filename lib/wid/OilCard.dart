import 'package:flutter/material.dart';
import '../models/OilObject.dart';
import '../utils/FileLoader.dart';
import '../pages/Oil.dart';

class OilCard extends StatefulWidget {
  final List<dynamic> oils;
  OilCard({this.oils});

  @override
  _OilCardState createState() => _OilCardState();
}

class _OilCardState extends State<OilCard> {
  var oils = List<OilObject>();

  void initState(){
    super.initState();
    _loadFile();
  }

  void _loadFile() async{
    final loaded = await FileLoader().searchOils(widget.oils);

    setState(() {
      oils = loaded;
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
              "Oils",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              )
            ),

            for(OilObject oil in oils) ListTile(
              title: Text(oil.name),
              subtitle: Text(oil.binomial),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.withOpacity(0.5)
              ),
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/images/${oil.image}"),
                backgroundColor: Colors.white,
              ),

              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Oil(oil: oil)
                ));
              },
            )
          ],
        ),
      )
    );
  }
}
