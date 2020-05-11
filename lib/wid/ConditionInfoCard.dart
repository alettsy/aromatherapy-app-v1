import 'package:flutter/material.dart';
import '../models/ConditionObject.dart';

class ConditionInfoCard extends StatelessWidget {
  final ConditionObject use;
  ConditionInfoCard({this.use});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  use.name,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  )
                ),
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Carrier",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  )
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  use.carrier,
                  style: TextStyle(
                    fontSize: 14
                  )
                ),
              ],
            ),

            SizedBox(height: 7),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    "Application",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    )
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    use.application,
                    style: TextStyle(
                        fontSize: 14
                    )
                ),
              ],
            ),

            SizedBox(height: 7),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    "Other Methods",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    )
                ),
              ],
            ),

            for(String other in use.otherMethods) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  other,
                  style: TextStyle(
                    fontSize: 14
                  )
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
