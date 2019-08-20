import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'PlayerModel.dart';


// Create a Form widget.
class PlayersForm extends StatefulWidget {
  @override
  PlayerFormState createState() {
    return PlayerFormState();
  }
}

class PlayerFormState extends State<PlayersForm>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int nbPlayers = 0;
  bool changed = false;
  Uuid uuid = new Uuid();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
        padding: EdgeInsets.all(20.0),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          Consumer<PlayerModel>(builder: (context, players, child) {
            int _nbPlayers = changed ? nbPlayers : players.size();
            return Row(
              children: <Widget>[
                FlatButton(child: Icon(Icons.remove),onPressed: () {
                  setState(() {
                    if (!changed) {
                      nbPlayers = players.size();
                    }
                    changed = true;
                    nbPlayers = nbPlayers - 1;
                  });
                }),
                Text("$_nbPlayers", style: TextStyle(fontSize: 20),),
                FlatButton(onPressed: () {
                  setState(() {
                    if (!changed) {
                      nbPlayers = players.size();
                    }
                    changed = true;
                    nbPlayers = nbPlayers + 1;
                  });
                }, child: Icon(Icons.add)),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
            );
          }),
          playerList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              Consumer<PlayerModel>(builder: (context, players, child) {
                return
                  FlatButton(
                    child: Text("Add Player"),
                    onPressed: (){
                      setState(() {
                        players.add(new Player(null, uuid.v4()));
                      });
                    },
                  );
              }),
              FlatButton(
                child: Text("Save"),
                onPressed: (){
                  setState(() {
                    setState(() {
                      print("ok");
                    });
                  });
                },
              ),
            ]
          )
        ]
    );
//    return playerList();
  }

  Widget playerList(){
    return Container(
        child:
        Form(
            key: this._formKey,
            child:
            Consumer<PlayerModel>(builder: (context, players, child) {
              print("inside playlist consumer");
              return ColumnBuilder(
                    itemCount: changed?nbPlayers:players.size(),
                    itemBuilder: (BuildContext ctxt, int index) =>
                        playerInput(players,index)
                );
            }
            )
        )
    );
  }

  Widget playerInput(PlayerModel players, index) {
    Player player = new Player(null, uuid.v4());
    if (index < players.size()) {
      player = players.getId(index);
    }
    print("playerInput ${player.name}");

    final TextEditingController playerNameController =
    new TextEditingController();
    //_firstNameController.value = new TextEditingValue(text: User.instance.first_name);
    playerNameController.text = player.name;

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        Flexible(
          child: TextFormField(
            controller: playerNameController,
            decoration: InputDecoration(
                hintText: 'Player Name',
                labelText: 'player ${index+1}'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onFieldSubmitted: (String str){
              print("field submitted");
            },
            onEditingComplete: (){
              print("Edit complete");
            },
          )
      ),
          IconButton(icon: Icon(Icons.delete),onPressed: (){
            setState(() {
              players.remove(player.uuid);
            });
          },)
      ]
    );
  }
}

class PlayersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Gestion des joueurs"),
        ),
        body: PlayersForm()
    );
  }

  Widget listPlayers(players){

  }
}

class PlayerManagementState extends State<PlayerManagement> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class PlayerManagement extends StatefulWidget {
  final int nbPlayer = 4;
  final players = {'1': 'Eloïse', '2': "Mathilde", '3': "Anne", '4': "Nicolas"};

  @override
  PlayerManagementState createState() => PlayerManagementState();
}


class ColumnBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final int itemCount;

  const ColumnBuilder({
    Key key,
    @required this.itemBuilder,
    @required this.itemCount,
    this.mainAxisAlignment: MainAxisAlignment.start,
    this.mainAxisSize: MainAxisSize.max,
    this.crossAxisAlignment: CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection: VerticalDirection.down,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(this.itemCount,
              (index) => this.itemBuilder(context, index)).toList(),
    );
  }
}