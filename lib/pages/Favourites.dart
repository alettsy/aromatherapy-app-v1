import 'package:flutter/material.dart';
import 'NavDrawer.dart';
import '../utils/FileLoader.dart';
import 'FaveOils.dart';
import 'FaveUses.dart';
import '../models/OilObject.dart';
import 'FaveEmotions.dart';
import 'FaveOtherUses.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Favourites")
      ),
      body: ListView(
          children: <Widget>[
            Divider(),

            ListTile(
              title: Text("Oils"),
              leading: Icon(Icons.invert_colors),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.withOpacity(0.5)
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => FaveOils()
                ));
              }
            ),

            Divider(),

            ListTile(
              title: Text("Conditions"),
              leading: Icon(Icons.pan_tool),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.withOpacity(0.5)
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => FaveUses()
                ));
              }
            ),

            Divider(),

            ListTile(
                title: Text("Emotions"),
                leading: Icon(Icons.tag_faces),
                trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.withOpacity(0.5)
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => FaveEmotions()
                  ));
                }
            ),

            Divider(),

            ListTile(
                title: Text("Other Uses"),
                leading: Icon(Icons.thumb_up),
                trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.withOpacity(0.5)
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => FaveOtherUses()
                  ));
                }
            ),
          ],
        ),
    );
  }
}
