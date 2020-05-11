import 'package:flutter/material.dart';
import '../models/OilObject.dart';

class OilInfoCard extends StatelessWidget {
  final OilObject oil;

  OilInfoCard({this.oil});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/${oil.image}"),
                    backgroundColor: Colors.white,
                  ),
                )
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  )
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Text(
                    oil.description,
                    style: TextStyle(
                      fontSize: 14
                    )
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
