
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:screen/screen.dart';

import 'PlayerModel.dart';

class ScoresState extends State<Scores> {
  var _scores = {'Eloïse': 0, 'eloise': 0, 'mathilde':0, 'anne':0, 'nicolas':0 };
  final _players = {'eloise': 'Eloïse', 'mathilde': "Mathilde", 'anne':"Anne", 'nicolas':"Nicolas"};
  final _redFont = const TextStyle(fontSize: 18.0, color: Colors.red);
  final _redBiggerFont = const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: Colors.red);
  final _bolderFont = const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black);
  final _biggerBolderFont = const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: Colors.black);

  void updateScore(String name, int value){
    _scores[name] = _scores[name] + value;
  }

  void updateScreenAlwaysOn(bool value){
    Screen.keepOn(value);
  }

  void updateAllScores(int value){
    for(String player in _scores.keys) {
      updateScore(player, value);
    }
  }

  Widget addPlayerScoreButton(name, value, _style){
    return new RawMaterialButton(
      constraints: BoxConstraints.loose(Size.fromWidth(50.0)),
      onPressed: () {setState(() {
        updateScore(name, value);
      });},
      child: new Text(value.toString(), style: _style),
      shape: new CircleBorder(),
      elevation: 2.0,
      fillColor: Colors.white,
      padding: const EdgeInsets.all(10.0),
    );
  }


  Widget addAllPlayerScoreButton(value, _style){
    return new RawMaterialButton(
      constraints: BoxConstraints.tight(Size.fromRadius(40.0)),
      onPressed: () {setState(() {
        updateAllScores(value);
      });},
      child: new Text("All \n"+value.toString(), style:_style, textAlign: TextAlign.center),
      shape: new CircleBorder(),
      elevation: 2.0,
      fillColor: Colors.white,
      padding: const EdgeInsets.all(15.0),
    );
  }

  Widget addControlRow() {
    return Card(
        child: ListTile(
          title: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget>[
                addAllPlayerScoreButton(-5,_redBiggerFont),
                addAllPlayerScoreButton(2,_biggerBolderFont),
                addAllPlayerScoreButton(1,_biggerBolderFont),
              ]),
        )
    );
  }

  Widget addPlayerRow(name) {
    return Card(
        child: ListTile(
          title: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget>[
                Text(_players[name]),
              ]),
          trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(_scores[name].toString(),  style: _bolderFont ),
                addPlayerScoreButton(name, -5, _redFont),
                addPlayerScoreButton(name, 2, _bolderFont),
                addPlayerScoreButton(name, 1, _bolderFont),
              ]),
        )
    );
  }

  Widget addInfoRow() {
    Future<bool> isKeptOn = Screen.isKeptOn;

    return Card(
        child: ListTile(
          title: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget>[
                FutureBuilder<bool>(
                  future: isKeptOn, // a previously-obtained Future<String> or null
                  builder: (BuildContext context, AsyncSnapshot<bool> isOn) {
                    bool _isOn = false;
                    if(isOn.data != null){
                      _isOn = isOn.data;
                    }
                    return Row(
                        children: [
                          Text("Garder l'écran allumé"),
                          Switch(
                              value: _isOn,
                              onChanged: (bool newValue) {
                                setState(() {
                                  updateScreenAlwaysOn(newValue);
                                });
                              }
                          )
                        ]
                    );
                  },
                )
              ]),
        )
    );
  }


  Widget addModelRow() {
    String data = "Coucou";

    return Consumer<PlayerModel>(
      builder: (context, players, child) {
        return Card(
            child: ListTile(
                title: Row(
                    children: [
                      Text("$data  ${players.getId(0).name}"),
                    ]
                )
            )
        );
      },
    );

  }


  Widget _buildList(){
    return ListView(
        children: <Widget>[
          addControlRow(),
          addPlayerRow("eloise"),
          addPlayerRow("mathilde"),
          addPlayerRow("nicolas"),
          addPlayerRow("anne"),
          addInfoRow(),
          addModelRow(),
        ]
    );

  }




  @override
  Widget build(BuildContext context) {
    return _buildList();
  }

}

class Scores extends StatefulWidget {
  @override
  ScoresState createState() => ScoresState();
}
