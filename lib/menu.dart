
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  final _headerFont = const TextStyle(fontSize: 20.0, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
              height: 88.0,
              child: DrawerHeader(
                  child: Text('Bingo Menu', style: _headerFont),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  )
              )
          ),
          ListTile(
            title: Text('Gérer les joueurs'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(context, '/players');
            },
          ),
          ListTile(
            title: Text('Statistique des parties (to come)'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

}

