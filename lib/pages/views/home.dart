import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fatapp/pages/controllers/activityController.dart';
import 'package:fatapp/pages/controllers/eventController.dart';
import 'package:fatapp/pages/models/acitivity.dart';
import 'package:fatapp/pages/models/event.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:fatapp/pages/views/eventDetail.dart';
import 'package:fatapp/pages/views/common/CustomShapeClipper.dart';
import 'package:fatapp/pages/views/eventsList2.dart';
import 'package:fatapp/pages/views/login.dart';
import 'package:fatapp/pages/views/subscriptionPage.dart';
import 'package:fatapp/pages/views/updateUser.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './common/CustomShapeClipper.dart';
import 'package:fatapp/pages/views/ratingPage.dart';
import './eventsList2.dart';
import 'about.dart';

class HomePage extends StatefulWidget {
  const HomePage({this.user});
  final User user;
  static String tag = 'home-page';

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Event> eventList;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    this.verifyOfflineAttendees();
    super.initState();
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  void verifyOfflineAttendees() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> value = preferences.getStringList("qrCodeKeys");
    if (value == null || value.isEmpty) {
      return;
    }
    if (await this.check() == true) {
      this.read(widget.user.id, widget.user.token, value);
      preferences.setStringList('qrCodeKeys', []);
    }
  }

  Future<void> scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      if (await this.check() == true) {
        String jsonData = jsonEncode({"userId": widget.user.id});
        int activityId = jsonDecode(barcode)['id'];
        await ActivityController()
            .attendee(activityId, jsonData, widget.user.token);
        Fluttertoast.showToast(
            msg:
                "O certificado da atividade participada será enviada em seu email",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

        var responseActivity = await ActivityController()
            .getActivity(activityId, widget.user.token);
        Activity activity = Activity.fromJson(responseActivity);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    RatePage(activity: activity, user: widget.user)));
      } else {
        this.saveUrl(barcode);
        Fluttertoast.showToast(
            msg:
                "Você está sem conexão, mas confirmaremos sua presença assim que possível.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        Fluttertoast.showToast(
            msg: "É necessário permissão para acessar a câmera.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on FormatException {
      return false;
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> saveUrl(urlToSave) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getStringList("qrCodeKeys") ?? [];
    urlToSave = jsonDecode(urlToSave);
    value.add(urlToSave['id'].toString());
    prefs.setStringList("qrCodeKeys", value);
  }

  Future<void> read(userId, userToken, List<String> activities) async {
    try {
      for (var activityId in activities) {
        String jsonData = jsonEncode({"userId": userId});
        await ActivityController().attendee(activityId, jsonData, userToken);
        Fluttertoast.showToast(
            msg:
                "O certificado das atividades participadas chegarão em seu email em breve.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async {
          exit(0);
          return true;
        },
        child: new Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: new AppBar(
              backgroundColor: const Color(0xFFCE0000),
              elevation: 0,
              brightness: Brightness.dark),
          drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: new Text(widget.user.name),
                  accountEmail: new Text(widget.user.email),
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
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new EventsList(user: widget.user)));
                    }),
                new ListTile(
                    title: new Text('Inscrições'),
                    trailing: new Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new SubscriptionPage(widget.user)));
                    }),
                new Divider(),
                new ListTile(
                  title: new Text('Sobre a FATEC'),
                  trailing: new Icon(Icons.map),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutPage())),
                ),
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
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    })
              ],
            ),
          ),
          body: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async {
                var refreshEvents =
                    await EventController().getEvents(widget.user.token);
                setState(() {
                  eventList = refreshEvents;
                });
              },
              child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(children: <Widget>[
                    HomeScreenTopPart(),
                    FutureBuilder<List<Event>>(
                        future: EventController().getEvents(widget.user.token),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                                height: 300.0,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 4.0),
                                child: Center(
                                    child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.red))));
                          } else {
                            eventList = snapshot.data;
                            eventList = eventList.where((event) {
                              var now = DateTime.now().toLocal();
                              var finalDate = event.finalDate.toLocal();
                              var isBeforeNow = finalDate.isAfter(now);
                              var isSameNow = finalDate.isAtSameMomentAs(now);

                              return isBeforeNow || isSameNow;
                            }).toList();

                            if (eventList.isEmpty) {
                              return Text(
                                "Não há eventos ativos no momento",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontFamily: 'Raleway',
                                ),
                              );
                            }

                            return CarouselSlider(
                              height: 300.0,
                              initialPage: 0,
                              enlargeCenterPage: true,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              autoPlay: false,
                              reverse: false,
                              enableInfiniteScroll: false,
                              autoPlayInterval: Duration(seconds: 2),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 2000),
                              pauseAutoPlayOnTouch: Duration(seconds: 10),
                              scrollDirection: Axis.horizontal,
                              items: eventList.map((event) {
                                return Builder(builder: (BuildContext context) {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 18.0, horizontal: 4.0),
                                      child: GestureDetector(
                                          child: CachedNetworkImage(
                                              imageUrl: event.imageUrl,
                                              placeholder: (context, url) => Center(
                                                  child: CircularProgressIndicator(
                                                      valueColor:
                                                          new AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Colors.red))),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      new Icon(Icons.error),
                                              httpHeaders: {
                                                "Token": widget.user.token
                                              },
                                              fit: BoxFit.contain),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EventDetail(widget.user,
                                                            event)));
                                          }));
                                });
                              }).toList(),
                            );
                          }
                        })
                  ]))),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                this.scan();
              },
              label: Text('PRESENÇA'),
              icon: Icon(Icons.photo_camera),
              backgroundColor: Color(0xFFB71C1C).withOpacity(0.92)),
        ));
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
  String title = "Fatapp";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 150.0,
            color: const Color(0xFFCE0000),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 1.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60.0, 0.0, 60.0, 00.0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 50.0,
                        child: Image.asset('assets/images/logoText.png'),
                      ),
                      // Text(
                      //   title,
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.w800,
                      //     fontSize: 24.0,
                      //     color: Colors.white,
                      //     fontFamily: 'Raleway',
                      //   ),
                      // ),
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
