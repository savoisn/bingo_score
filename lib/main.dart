import 'package:flutter/material.dart';

import 'package:screen/screen.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bingo Score',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
//      home: MyHomePage(title: 'Bingo Score Home Page'),
      home: Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text("Bingo Score")
          ),
          body: Scores()
      )
    );
  }



}

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

                    return Row(
                      children: [
                        Text("Garder l'écran allumé"),
                        Switch(
                          value: isOn.data,
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


  Widget _buildList(){
    return ListView(
      children: <Widget>[
        addControlRow(),
        addPlayerRow("eloise"),
        addPlayerRow("mathilde"),
        addPlayerRow("nicolas"),
        addPlayerRow("anne"),
        addInfoRow(),
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



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have clicked the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
