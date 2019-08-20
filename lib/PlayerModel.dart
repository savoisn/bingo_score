
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class PlayerModel extends ChangeNotifier {
  static Uuid _uuid = new Uuid();
  /// Internal, private state of the cart.
  List<Player> _players = [
    new Player("Anne", _uuid.v4()),
    new Player("Nico", _uuid.v4()),
    new Player("Eloise", _uuid.v4()),
    new Player("Mathilde", _uuid.v4()),
  ];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Player> get players => UnmodifiableListView(_players);

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Player player) {
    this._players.add(player);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  Player getId(int id){
    return _players[id];
  }

  void remove(String uuid){
    print("before $_players");
    var my_players = this._players.where((f) => f.uuid!=uuid).toList();
    print("after $my_players");
    _players = my_players;
    notifyListeners();
  }

  int size(){
    return this._players.length;
  }
}

class Player {
  Player(String name, String uuid) {
    this.name = name;
    this.uuid = uuid;
  }
  String name = '';
  String uuid = '';
  String toString(){
    return "$name";
  }
}