import 'package:flutter/material.dart';
import 'NavDrawer.dart';
import '../utils/FileLoader.dart';
import '../models/ConditionObject.dart';
import 'Condition.dart';

class Conditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
            title: Text("Conditions")
        ),
        body: _Conditions()
    );
  }
}

class _Conditions extends StatefulWidget {
  @override
  __ConditionsState createState() => __ConditionsState();
}

class __ConditionsState extends State<_Conditions> {
  TextEditingController editingController = TextEditingController();
  var conditions = new List<ConditionObject>();
  var dupe = new List<ConditionObject>();

  void initState(){
    super.initState();

    _loadOils();
  }

  void _loadOils() async{
    final fileLoader = new FileLoader();
    List<ConditionObject> temp = await fileLoader.loadUses();

    dupe.addAll(temp);
    setState(() {
      conditions = temp;
    });
  }

  void filterSearchResults(String query){
    List<ConditionObject> dummy = new List<ConditionObject>();
    dummy.addAll(dupe);

    if (query.isNotEmpty){
      List<ConditionObject> dummyData = List<ConditionObject>();
      dummy.forEach((item){
        if (item.name.toLowerCase().contains(query.toLowerCase())){
          dummyData.add(item);
        }
      });

      setState(() {
        conditions = dummyData;
      });
      return;
    } else {
      setState(() {
        conditions = dupe;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              onChanged: (value){
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
              itemCount: conditions.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  title: Text(conditions[index].name),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Condition(condition: conditions[index])
                    ));
                  },
                );
              },
              separatorBuilder: (context, index){
                return Divider();
              },
            ),
          ),
        ],
      ),
    );
  }
}


