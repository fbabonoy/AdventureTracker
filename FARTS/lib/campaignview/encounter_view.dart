import 'package:FARTS/models/campaign_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EncounterView extends StatefulWidget {
  @override
  _EncounterViewState createState() => _EncounterViewState();
}

class _EncounterViewState extends State<EncounterView> {
  var _campaignModelStream;

  @override
  Widget build(BuildContext context) {
    _campaignModelStream = Provider.of<CampaignModel>(context);

    return Scaffold(
        body: ListView.builder(
            itemCount: _campaignModelStream.encounters.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.grey[500],
                child: ListTile(
                  trailing: Text("example XP",
                      style: TextStyle(fontSize: 12.0, color: Colors.black)),
                  title: Text(_campaignModelStream.encounters[index],
                      style: TextStyle(color: Colors.black)),
                  onTap:
                      () {}, // TODO inflate or navigate to the corresponding encounter data.
                ),
              );
            }));
  }
}
