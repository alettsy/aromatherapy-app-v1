import 'package:flutter/material.dart';
import 'NavDrawer.dart';
import '../models/ConditionObject.dart';
import '../utils/FileLoader.dart';
import 'NavDrawer.dart';
import 'Condition.dart';

class FaveUses extends StatefulWidget {
  @override
  _FaveUsesState createState() => _FaveUsesState();
}

class _FaveUsesState extends State<FaveUses> {
  TextEditingController editingController = TextEditingController();
  List<ConditionObject> uses = new List<ConditionObject>();
  var dupe = new List<ConditionObject>();

  @override
  void initState() {
    super.initState();

    _loadFaves();
  }


  void _loadFaves() async {
    final data = await FileLoader().loadFaveUses();
    final useObjects = await FileLoader().searchUses(data);

    dupe.addAll(useObjects);
    setState(() {
      uses = useObjects;
    });
  }

  void filterSearchResults(String query) {
    List<ConditionObject> dummy = new List<ConditionObject>();
    dummy.addAll(dupe);

    if (query.isNotEmpty) {
      List<ConditionObject> dummyData = List<ConditionObject>();
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
        title: Text("Favourite Conditions")
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
                            builder: (context) => Condition(
                              condition: uses[index]
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
