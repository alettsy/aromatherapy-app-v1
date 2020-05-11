import 'package:flutter/material.dart';
import '../models/EmotionObject.dart';
import '../utils/FileLoader.dart';
import '../pages/Emotion.dart';
import 'NavDrawer.dart';

class FaveEmotions extends StatefulWidget {
  @override
  _FaveUsesState createState() => _FaveUsesState();
}

class _FaveUsesState extends State<FaveEmotions> {
  TextEditingController editingController = TextEditingController();
  List<EmotionObject> emotions = new List<EmotionObject>();
  var dupe = new List<EmotionObject>();

  @override
  void initState() {
    super.initState();

    _loadFaves();
  }


  void _loadFaves() async {
    final data = await FileLoader().loadFaveEmotions();
    final useObjects = await FileLoader().searchEmotions(data);

    dupe.addAll(useObjects);
    setState(() {
      emotions = useObjects;
    });
  }

  void filterSearchResults(String query) {
    List<EmotionObject> dummy = new List<EmotionObject>();
    dummy.addAll(dupe);

    if (query.isNotEmpty) {
      List<EmotionObject> dummyData = List<EmotionObject>();
      dummy.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyData.add(item);
        }
      });

      setState(() {
        emotions.clear();
        emotions.addAll(dummyData);
      });
      return;
    } else {
      setState(() {
        emotions.clear();
        emotions.addAll(dupe);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Favourite Emotions")
      ),
      body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: ListView.separated(
                  itemCount: emotions.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      title: Text(emotions[index].name),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Emotion(
                              emotion: emotions[index]
                            )
                        ));
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}
