import 'package:flutter/material.dart';
import 'NavDrawer.dart';
import '../models/OilObject.dart';
import '../utils/FileLoader.dart';
import 'Oil.dart';


class FaveOils extends StatefulWidget {
  @override
  _FaveOilsState createState() => _FaveOilsState();
}

class _FaveOilsState extends State<FaveOils> {
  TextEditingController editingController = TextEditingController();
  List<OilObject> oils = new List<OilObject>();
  var dupe = new List<OilObject>();

  @override
  void initState() {
    super.initState();

    _loadFaves();
  }


  void _loadFaves() async {
    final data = await FileLoader().loadFaveOils();
    final oilObjects = await FileLoader().searchOils(data);

    dupe.addAll(oilObjects);
    setState(() {
      oils = oilObjects;
    });
  }

  void filterSearchResults(String query) {
    List<OilObject> dummy = new List<OilObject>();
    dummy.addAll(dupe);

    if (query.isNotEmpty) {
      List<OilObject> dummyData = List<OilObject>();
      dummy.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase()) || item.binomial.toLowerCase().contains(query.toLowerCase())) {
          dummyData.add(item);
        }
      });

      setState(() {
        oils.clear();
        oils.addAll(dummyData);
      });
      return;
    } else {
      setState(() {
        oils.clear();
        oils.addAll(dupe);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Favourite Oils")
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
                  itemCount: oils.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            "assets/images/${oils[index].image}"),
                        backgroundColor: Colors.white,
                      ),
                      title: Text(oils[index].name),
                      subtitle: Text(oils[index].binomial),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Oil(
                              oil: oils[index]
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
