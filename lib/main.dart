import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import './pages/views/login.dart';

final routes = <String, WidgetBuilder>{LoginPage.tag: (context) => LoginPage()};

void main() {
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting("pt_BR", null);
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
