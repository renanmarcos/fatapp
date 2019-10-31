import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './pages/views/login.dart';

final routes = <String, WidgetBuilder>{LoginPage.tag: (context) => LoginPage()};

void main() {
  DotEnv().load('.env');
  runApp(new MaterialApp(
    home: new LoginPage(),
    theme: ThemeData(
      primarySwatch: Colors.red,
      fontFamily: 'Raleway',
    ),
    routes: routes,
  ));
}
