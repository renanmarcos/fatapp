import 'dart:io' show File, InternetAddress, SocketException, exit;
import 'package:fatapp/pages/controllers/activityController.dart';
import 'package:fatapp/pages/controllers/eventController.dart';
import 'package:fatapp/pages/models/event.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:fatapp/pages/views/eventDetail.dart';
import 'package:fatapp/pages/views/login.dart';
import 'package:fatapp/pages/views/qrCodeScan.dart';
import 'package:fatapp/pages/views/updateUser.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './common/CustomShapeClipper.dart';
import './eventsList2.dart';
import './test.dart';

class HomePage extends StatefulWidget {
  const HomePage({this.user});
  final User user;
  static String tag = 'home-page';
  @override
  _HomePageState createState() => new _HomePageState();
}

readUrlFile(userId, userToken) async {
  try {
    final result = await InternetAddress.lookup(DotEnv().env['FATAPP_API']);

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
  List<Event> eventList;
  @override
  void initState() {
    readUrlFile(widget.user.id, widget.user.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async {
          exit(0);
          return true;
        },
        child: new Scaffold(
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
                  accountName: new Text(widget.user.name),
                  accountEmail: new Text(widget.user.email),
                  currentAccountPicture: new GestureDetector(
                      // child: new CircleAvatar(
                      //   // backgroundImage: new AssetImage('assets/images/profileIcon.png'),
                      // ),
                      ),
                  decoration: new BoxDecoration(
                      image: DecorationImage(
                          image: new AssetImage(
                              'assets/images/fatec-saocaetano.jpg'),
                          fit: BoxFit.fitWidth)),
                ),

                new ListTile(
                    title: new Text('Eventos'),
                    trailing: new Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new EventsList(user: widget.user)));
                    }),

                new ListTile(
                    title: new Text('Inscrições'),
                    trailing: new Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Test('Página de Teste')));
                    }),

                new Divider(),
                new ListTile(
                  title: new Text('Perfil'),
                  trailing: new Icon(Icons.person),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateUserPage(
                                user: widget.user,
                              ))),
                ),
                new ListTile(
                    title: new Text('Sair'),
                    trailing: new Icon(Icons.cancel),
                    onTap: () async {
                      this.deletePreferences();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    })
              ],
            ),
          ),
          body: Column(
            children: <Widget>[
            HomeScreenTopPart(),
            FutureBuilder<List<Event>>(
              future: EventController().getEvents(widget.user.token),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  eventList = snapshot.data;
                  for (Event event in eventList) {
                    String image = DotEnv().env['FATAPP_API'] + 'files/' + event.banner;
                    event.imageUrl = image;
                  }
                  return CarouselSlider(
                    height: 300.0,
                    initialPage: 0,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlay: false,
                    reverse: false,
                    enableInfiniteScroll: true,
                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(milliseconds: 2000),
                    pauseAutoPlayOnTouch: Duration(seconds: 10),
                    scrollDirection: Axis.horizontal,
                    items: eventList.map((event) {
                      return Builder(
                        builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin:
                              EdgeInsets.symmetric(vertical: 18.0, horizontal: 4.0),
                          child: GestureDetector(
                              child: Image.network(
                                event.imageUrl,
                                headers: {
                                  "Token" : widget.user.token
                                },
                                width: 500,
                                height: 300,
                            ),
                            onTap: () {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => EventDetail(user: widget.user, event: event)));
                            }
                          )
                          );
                        }
                    );
                  }).toList(),
                );
              }}
            )]
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScanScreen()));
            },
            label: Text('PRESENÇA'),
            icon: Icon(Icons.photo_camera),
            backgroundColor: Colors.black87,
          ),
        )
      );
  }
  Future<void> deletePreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
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
          child: Container(
            height: 150.0,
            color: Colors.red,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60.0, 5.0, 60.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
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
    );
  }
}

