import 'package:flutter/material.dart';
import 'NavDrawer.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
            title: Text("Information")
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                ImportantCard(),
                DisclaimerCard(),
                CarrierOilsCard()
              ],
            )
          )
        )
    );
  }
}

// ignore: must_be_immutable
class RowText extends StatelessWidget {
  final String text;
  String infoText;
  bool title = false;
  bool bold = false;
  bool info = false;

  RowText({this.text});
  RowText.isTitle({this.text, this.title=true});
  RowText.isBold({this.text, this.bold=true});
  RowText.isInfo({this.text, this.infoText, this.info=true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (title) Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
          )
        )
        else if (bold) Container(
          width: MediaQuery.of(context).size.width*0.9,
          child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              )
          ),
        )
        else if (info) Container(
            width: MediaQuery.of(context).size.width*0.9,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black
                ),
                children:[
                  TextSpan(text: text, style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: infoText)
                ]
              )
            )
          )
        else Container(
          width: MediaQuery.of(context).size.width*0.9,
          child: Text(
              text,
              style: TextStyle(
                  fontSize: 16,
              )
          ),
        )
      ],
    );
  }
}


class ImportantCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RowText.isTitle(text: "Safety"),
              RowText(text: "Other than where indicated, do not apply essential oils"
                    " undiluted to the skin, and keep them away from eyes and children."
                    " If you are pregnant, epileptic, or considering using oils on"
                    " young children seek professional advice first. Never take essential"
                    " oils internally unless under professional guidance."
              ),
              RowText.isBold(text: "For neat drops, apply twice only.")
            ],
          ),
        )
      );
  }
}

class DisclaimerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.orangeAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RowText.isTitle(text: "Disclaimer"),
              RowText(text: "This app is for educational purposes only as well as"
                  " to give you general information about essential oils and their uses."
              ),
            ],
          ),
        )
    );
  }
}

class CarrierOilsCard extends StatelessWidget {
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
              RowText.isTitle(text: "Carrier Oils"),
              RowText.isInfo(text: "Apricot Kernel Oil: ", infoText: "Apricot encourages suppleness and elasticity"
                  " which makes it an ideal facial oil."),
              RowText.isInfo(text: "Avocado Oil: ", infoText: "A deep penetrating oil which is very good for dry"
                  "skin. Add 15% to a lighter carrier."),
              RowText.isInfo(text: "Grapeseed Oil: ", infoText: "This light and quickly absorbed carrier is good for"
                  "both body and facial massage."),
              RowText.isInfo(text: "Jojoba Oil: ", infoText: "One of the finest facial oils which moisturises and deep"
                  "cleanses blocked pores."),
              RowText.isInfo(text: "Lotion Base: ", infoText: "Available from good suppliers, a lotion is the ideal"
                  "carrier for skin related problems."),
              RowText.isInfo(text: "Sweet Almond Oil: ", infoText: "An excellent, all round body and facial oil which"
                  "is both protective and nourishing."),
              RowText.isInfo(text: "Wheatgerm Oil: ", infoText: "A rich nourishing oil which is excellent for mature"
                  "skin. Add 15% to a lighter carrier.")
            ],
          ),
        )
    );
  }
}
