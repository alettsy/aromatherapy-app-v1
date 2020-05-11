import 'package:flutter/material.dart';
import 'NavDrawer.dart';
import '../utils/FileLoader.dart';
import '../models/OilObject.dart';
import 'Oil.dart';

import 'package:firebase_admob/firebase_admob.dart';

class EssentialOils extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
            title: Text("Essential Oils")
        ),
        body: _EssentialOils()
    );
  }
}

class _EssentialOils extends StatefulWidget {
  @override
  __EssentialOilsState createState() => __EssentialOilsState();
}

class __EssentialOilsState extends State<_EssentialOils> {
  TextEditingController editingController = TextEditingController();
  var oils = new List<OilObject>();
  var dupe = new List<OilObject>();
  BannerAd myBanner;

  void initState(){
    super.initState();

    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-7933413112966343~4164291620");
    myBanner = createBanner();
    myBanner..load()..show();

    FileLoader().setupFolders(context);
    _loadOils();
  }

  void dispose(){
    myBanner.dispose();
    super.dispose();
  }

  // AD STUFF
  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['aromatherapy', 'oils', 'essential oils', 'health'],
    nonPersonalizedAds: true,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  BannerAd createBanner(){
    return BannerAd(
      adUnitId: "ca-app-pub-7933413112966343/6215739895",
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
  }

  void _loadOils() async{
    final fileLoader = new FileLoader();
    List<OilObject> temp = await fileLoader.loadOils();

    dupe.addAll(temp);
    setState(() {
      oils = temp;
    });
  }

  void filterSearchResults(String query){
    List<OilObject> dummy = new List<OilObject>();
    dummy.addAll(dupe);

    if (query.isNotEmpty){
      List<OilObject> dummyData = List<OilObject>();
      dummy.forEach((item){
        if (item.name.toLowerCase().contains(query.toLowerCase()) || item.binomial.toLowerCase().contains(query.toLowerCase())){
          dummyData.add(item);
        }
      });

      setState(() {
        oils = dummyData;
      });
      return;
    } else {
      setState(() {
        oils = dupe;
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
              itemCount: oils.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/${oils[index].image}"),
                    backgroundColor: Colors.white,
                  ),
                  title: Text(oils[index].name),
                  subtitle: Text(oils[index].binomial),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Oil(oil: oils[index])
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


