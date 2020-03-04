import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// Relevant pages.
import 'package:FARTS/vibrate.dart';

class Campaign extends StatefulWidget {
  @override
  _CampaignState createState() => _CampaignState();
}

class _CampaignState extends State<Campaign> {
  static DateFormat dateFormat = DateFormat("h:mm MM-dd-yy");
  String _now = dateFormat.format(DateTime.now());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body:StreamBuilder(
          key: Key('streamBuilderKey'),
          stream: Firestore.instance.collection("campaigns").snapshots(),
          builder: (context, snapshot) {
            // Shows a loading progress indicator while data is still being fetched.
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              //return UhOh(snapshot.error);
              // TODO actually throw an exception or log an error.
            }
            // CustomScrollview is the actual name of the gridview layout widget.
            return CustomScrollView(
              key: Key('CSV'),
              primary: false,
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.all(5),
                  // .extent just sets max cross axis size (horizontal) whereas .count would set a specific number
                  // of evenly spaced widgets per row.
                  sliver: SliverGrid.extent(
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    // This is the max number of pixels the widgets will expand horizontally. 
                    maxCrossAxisExtent: 1080,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 50.0),
                        //padding: EdgeInsets.all(5.0),
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image(image: AssetImage('assets/realoldpaper.jpg'),
                            fit: BoxFit.cover,
                            ),
                            Column(
                              children: <Widget>[
                                Text("Campaign", style: TextStyle(fontSize: 16.0, color: Colors.grey[900]),),
                                Container(
                                  padding: EdgeInsets.all(14.0),
                                  child: Text(snapshot.data.documents[0]['name'], style: TextStyle(fontSize: 26.0, color: Colors.black, fontStyle: FontStyle.italic))),
                                Text("Time/Date", style: TextStyle(fontSize: 16.0, color: Colors.grey[900])),
                                Container(
                                  padding: EdgeInsets.all(14.0),
                                  child: Text(_now.toString(), style: TextStyle(fontSize: 26.0, color: Colors.black, fontStyle: FontStyle.italic),)),
                                Text("Session Number", style: TextStyle(fontSize: 16.0, color: Colors.grey[900])),
                                Container(
                                  padding: EdgeInsets.all(14.0),
                                  child: Text("1", style: TextStyle(fontSize: 26.0, color: Colors.black, fontStyle: FontStyle.italic),)),
                                  // TODO increment the session number dynamically
                                Text("Map", style: TextStyle(fontSize: 16.0, color: Colors.grey[900]),),
                                Container(
                                  padding: EdgeInsets.all(14.0),
                                  child: Text("Shrek's Swamp", style: TextStyle(fontSize: 26.0, color: Colors.black, fontStyle: FontStyle.italic),)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Image.asset('assets/samplemap.jpg'),
                          // TODO, actually load the relevant map image form db.
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text("Notes", style: TextStyle(fontSize: 20.0, color: Colors.grey[600])),
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Text(snapshot.data.documents[0]['notes']),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Text("Party info",
                          style: TextStyle(fontSize: 20.0, color: Colors.yellow),),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.blue,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          decoration: InputDecoration(labelText: "NPCS"),
                        ),
                      ),
                      Container(
                        child: MaterialButton(
                          color: Colors.green,
                          child: Text("API Call", style: TextStyle(fontSize: 30.0),),
                          onPressed: () {
                            Vibrate().smallRoll();
                        },),
                      ),
                      Container( 
                        color: Colors.grey[800],
                        child: MaterialButton(
                          child: Text('Small Roll Test'),
                          onPressed: Vibrate().smallRoll,)
                      ),
                      Container( 
                        color: Colors.grey[800],
                        child: MaterialButton(
                          child: Text('Big Roll Test'),
                          onPressed: Vibrate().bigRoll,)
                      ),
                      Container(
                        color: Colors.grey[800],
                        child: MaterialButton(
                          child: Text('Epic Roll Test'),
                          onPressed: Vibrate().epicRoll,)
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        )
    );
  }
  void _callAPI() async { 
    print(await http.read('http://dnd5eapi.co/api/spells/acid-arrow/'));
  }
} 

