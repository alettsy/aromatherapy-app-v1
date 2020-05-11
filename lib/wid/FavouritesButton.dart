import 'package:flutter/material.dart';
import '../utils/FileLoader.dart';
import '../utils/FileWriter.dart';

class FavouriteButton extends StatefulWidget {
  final String value;
  final String type;

  FavouriteButton({this.type, this.value});

  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  bool _favourited = false;

  void initState(){
    super.initState();
    _loadFaves();
  }

  void _loadFaves() async{
    List<dynamic> loaded;

    switch(widget.type){
      case "use":
        loaded = await FileLoader().loadFaveUses();
        break;
      case "oil":
        loaded = await FileLoader().loadFaveOils();
        break;
      case "emotion":
        loaded = await FileLoader().loadFaveEmotions();
        break;
      case "other":
        loaded = await FileLoader().loadFaveOtherUses();
        break;
    }

    setState(() {
      _favourited = loaded.contains(widget.value);
    });
  }

  void _showToast(BuildContext context) {
    String content = (!_favourited) ? "Added to " : "Removed from ";
    content += "Favourites";

    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(content),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: 10),
        Text("Add to Favourites"),
        IconButton(
          icon: (_favourited) ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
          iconSize: 20,
          onPressed: () {
            if (_favourited){
              FileWriter().removeFavourite(widget.type, widget.value);
            } else {
              FileWriter().addFavourite(widget.type, widget.value);
            }

            _showToast(context);
            setState(() {
              _favourited = !_favourited;
            });
          },
        )
      ],
    );
  }
}
