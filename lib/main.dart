import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './pages/views/home.dart';
import './pages/views/login.dart';

final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
};

void main() {
  DotEnv().load('.env');
  runApp(new MaterialApp(
    home: new HomePage(),
    theme: ThemeData(
      primarySwatch: Colors.red,
      fontFamily: 'Raleway',
    ),
    routes: routes,
    
  ));
}
