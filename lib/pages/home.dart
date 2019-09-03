import 'package:flutter/material.dart';

import './teste.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page'; 
  @override 
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override 
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('FATapp'),
        // actions: <Widget>[
        //   Icon(Icons.notifications),
        // ],
        backgroundColor: Colors.redAccent,
        elevation: 50.0,
        brightness: Brightness.light,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('Beatriz Lamano'),
              accountEmail: new Text('beatrizlamano@fatec.sp.gov.br'),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage("https://66.media.tumblr.com/8b62ddece8e4f00fa2203374eed07bff/tumblr_pguz2k0uEw1use13wo7_400.png"),
                ),
              )
              ,
              decoration: new BoxDecoration(
                image: DecorationImage(
                  image: new NetworkImage('https://data.whicdn.com/images/333269108/large.jpg'),
                  fit: BoxFit.fitWidth
                  )
              ),
            ),
            new ListTile(
              title: new Text('Histórico'),
              trailing: new Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Teste('Página de Teste')));
              }
            ),
            new ListTile(
              title: new Text('Evento Atual'),
              trailing: new Icon(Icons.keyboard_arrow_right),
            ),
            new ListTile(
              title: new Text('Eventos Passados'),
              trailing: new Icon(Icons.keyboard_arrow_right),
            ),
            new Divider(),
            new ListTile( 
              title: new Text('Configurações'),
              trailing: new Icon(Icons.settings),
            ),
            new ListTile( 
              title: new Text('Fechar'),
              trailing: new Icon(Icons.cancel),
              onTap: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
      body: new Center(
        child: new Text("HomePage",
          style: new TextStyle(fontSize: 35.0),
        ),
      ),
    );
  }
}