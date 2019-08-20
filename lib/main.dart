import 'package:flutter/material.dart';


import './player.dart';
import './score.dart';
import './menu.dart';
import 'package:provider/provider.dart';

import 'package:bingo/PlayerModel.dart';

//void main() => runApp(MyApp());

void main() {
  runApp(
    ChangeNotifierProvider(
      builder: (context) => PlayerModel(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bingo Score',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/players': (context) => PlayersScreen(),
        },
    );
  }
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
      title: Text("Bingo Score")
      ),
      drawer: Menu(),
      body: Scores()
    );
  }
}


