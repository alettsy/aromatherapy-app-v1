import 'package:Aromatherapy/pages/Other.dart';
import 'package:flutter/material.dart';
import 'NavDrawer.dart';
import '../models/OtherUsesObject.dart';
import '../utils/FileLoader.dart';
import 'NavDrawer.dart';
import 'Condition.dart';

class FaveOtherUses extends StatefulWidget {
  @override
  _FaveOtherUsesState createState() => _FaveOtherUsesState();
}

class _FaveOtherUsesState extends State<FaveOtherUses> {
  TextEditingController editingController = TextEditingController();
  List<OtherUsesObject> uses = new List<OtherUsesObject>();
  var dupe = new List<OtherUsesObject>();

  @override
  void initState() {
    super.initState();

    _loadFaves();
  }


  void _loadFaves() async {
    final data = await FileLoader().loadFaveOtherUses();
    final useObjects = await FileLoader().searchOtherUses(data);

    dupe.addAll(useObjects);
    setState(() {
      uses = useObjects;
    });
  }

  void filterSearchResults(String query) {
    List<OtherUsesObject> dummy = new List<OtherUsesObject>();
    dummy.addAll(dupe);

    if (query.isNotEmpty) {
      List<OtherUsesObject> dummyData = List<OtherUsesObject>();
      dummy.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyData.add(item);
        }
      });

      setState(() {
        uses.clear();
        uses.addAll(dummyData);
      });
      return;
    } else {
      setState(() {
        uses.clear();
        uses.addAll(dupe);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
          title: Text("Favourite Other Uses")
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
                itemCount: uses.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    title: Text(uses[index].name),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Other(other: uses[index])
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
