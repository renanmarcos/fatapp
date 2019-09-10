import 'package:flutter/material.dart';
import './pages/home.dart';
import './pages/login.dart';

final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
};

void main() {
  runApp(new MaterialApp(
    home: new LoginPage(),
    theme: ThemeData(
      primarySwatch: Colors.red,
      fontFamily: 'Raleway',
    ),
    routes: routes,
    
  ));
}
