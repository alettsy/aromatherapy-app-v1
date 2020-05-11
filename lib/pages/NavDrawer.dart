import 'package:flutter/material.dart';

import 'EssentialOils.dart';
import 'Conditions.dart';
import 'Emotions.dart';
import 'Favourites.dart';
import 'About.dart';
import 'Others.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text(
                  "Essential Oils",
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/drawer-image.jpg"),
                  fit: BoxFit.cover,
                )
              ),
            ),

            ListTile(
              leading: Icon(Icons.invert_colors),
              title: Text("Essential Oils"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => EssentialOils()
                ));
              },
            ),

            ListTile(
              leading: Icon(Icons.pan_tool),
              title: Text("Conditions"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Conditions()
                ));
              },
            ),

            ListTile(
              leading: Icon(Icons.tag_faces),
              title: Text("Emotions"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Emotions()
                ));
              },
            ),

            ListTile(
              leading: Icon(Icons.thumb_up),
              title: Text("Other Uses"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Others()
                ));
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Favourites"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Favourites()
                ));
              },
            ),

            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text("Information"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => About()
                ));
              },
            ),
          ],
        )
    );
  }
}

