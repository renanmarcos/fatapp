import 'dart:io';

import 'package:fatapp/pages/controllers/activityController.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:fatapp/pages/views/login.dart';
import 'package:fatapp/pages/views/qrCodeScan.dart';
import 'package:fatapp/pages/views/updateUser.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './common/CustomShapeClipper.dart';
import './eventsList2.dart';
import './test.dart';

class HomePage extends StatefulWidget {
    const HomePage({
    this.user
  });
  final User user;
  static String tag = 'home-page'; 
  @override 
  _HomePageState createState() => new _HomePageState();
}

readUrlFile(userId,userToken) async {
  try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          final directory = await getApplicationDocumentsDirectory();
          final file = File('${directory.path}/url.txt');
          List<String> text = await file.readAsLines();
          for (var item in text) {
            var jsonData = '{ "userId" : "$userId"}';
          
            ActivityController().attendee(item, jsonData, userToken);
            
          }
        } catch (e) {
      print("Não foi possível ler o arquivo");
      }
    }
  } on SocketException catch (_) {
      print('Sem conexão com a internet');
    }
        
  }

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    readUrlFile(widget.user.id,widget.user.token);
    super.initState();
  }
  

  @override 
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // title: new Text('FATapp'),
        backgroundColor: Colors.red,
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
              accountName: this.getName(),
              accountEmail: this.getEmail(),
              currentAccountPicture: new GestureDetector(
                // child: new CircleAvatar(
                //   // backgroundImage: new AssetImage('assets/images/profileIcon.png'),
                // ),
              ),
              decoration: new BoxDecoration(
                image: DecorationImage(
                  image: new AssetImage('assets/images/fatec-saocaetano.jpg'),
                  fit: BoxFit.fitWidth
                  )
              ),
            ),

            new ListTile(
              title: new Text('Eventos'),
              trailing: new Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new EventsList()));
              }
            ),

            // new ExpansionTile(
            //   title: Text('Eventos'),
            //   children: <Widget>[
            //     new ListTile(
            //       title: new Text('Evento Atual'),
            //       trailing: new Icon(Icons.keyboard_arrow_right),
            //     ),
            //     new ListTile(
            //       title: new Text('Eventos Passados'),
            //       trailing: new Icon(Icons.keyboard_arrow_right),
            //       onTap: () {
            //        Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => EventsList()),
            //       );
            //       }
            //     ),
            //   ],
            // ),
            new ListTile(
              title: new Text('Inscrições'),
              trailing: new Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Test('Página de Teste')));
              }
            ),
           
            new Divider(),
            new ListTile( 
              title: new Text('Perfil'),
              trailing: new Icon(Icons.person),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateUserPage(user: widget.user,))),
            ),
            new ListTile( 
              title: new Text('Sair'),
              trailing: new Icon(Icons.cancel),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ScanScreen()));
        },
        label: Text('PRESENÇA'),
        icon: Icon(Icons.photo_camera),
        backgroundColor: Colors.black87,
      ),
    );
  }
  getEmail() {
    if (DotEnv().env['FATAPP_REQUEST'].compareTo('TRUE') == 0) {
      return new Text(widget.user.email);
    } else {
      return new Text('teste@gmail.com');
    }
  }
  getName() {
    if (DotEnv().env['FATAPP_REQUEST'].compareTo('TRUE') == 0) {
      return new Text(widget.user.name);
    } else {
      return new Text('Teste');
    }
  }
}


class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  String title = "FATapp";
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(height: 150.0, color: Colors.red, 
          child: Column(
            children: <Widget>[
              SizedBox(height: 5.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(60.0, 5.0, 60.0, 10.0),
                child: Row(
                  children: <Widget>[
                    Text(title,
                      style: TextStyle(fontWeight: FontWeight.w800,    
                        fontSize: 24.0,
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Hero(
                        tag: "hero",
                        child: Container(
                          padding: EdgeInsets.only(top: 50.0),
                          height: 80.0,
                          width: 80.0,
                          // child: logo,
                        ),
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
  );}
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
              height: 300.0,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: false,
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
