import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import './common/CustomShapeClipper.dart';
import './test.dart';

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
        backgroundColor: Colors.red[900],
        elevation: 0,
        brightness: Brightness.light,
        // centerTitle: true,
        // actions: <Widget>[
        //   Icon(Icons.notifications),
        // ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('Beatriz Lamano'),
              accountEmail: new Text('beatrizlamano@fatec.sp.gov.br'),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundImage: new AssetImage('assets/images/profileIcon.png'),
                ),
              )
              ,
              decoration: new BoxDecoration(
                image: DecorationImage(
                  image: new AssetImage('assets/images/header.jpg'),
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
                  builder: (BuildContext context) => new Test('Página de Teste')));
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
      body: Column(
        children: <Widget>[
          HomeScreenTopPart(),
          HomeScreenBottomPart(),
        ],
      ),
    );
  }
}


class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  String welcomeMessage = "Fatec app";
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(height: 150.0, color: Colors.red[900], 
          child: Column(
            children: <Widget>[
              SizedBox(height: 40.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(60.0, 5.0, 60.0, 10.0),
                child: Row(
                  children: <Widget>[
                    Text(welcomeMessage,
                      style: TextStyle(fontWeight: FontWeight.w800,    
                        fontSize: 24.0,
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        ),
                    ),
                  ],
                ),
              )
            ],
          ),
          ),
        )
      ],
    );
  }

}

int photoIndex = 0;

  List imgList = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
    'assets/images/banner4.jpg',
  ];

class HomeScreenBottomPart extends StatefulWidget {
  @override
  _HomeScreenBottomPartState createState() => _HomeScreenBottomPartState();
}

class _HomeScreenBottomPartState extends State<HomeScreenBottomPart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CarouselSlider(
              height: 400.0,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
              pauseAutoPlayOnTouch: Duration(seconds: 10),
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {
                  photoIndex = index;
                });
              },
              items: imgList.map((imgUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                      child: Image.asset(
                        imgUrl,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList(), 
            ),
          ],
      ),
    );
  }
}
