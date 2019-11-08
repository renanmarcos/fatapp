import 'package:fatapp/pages/models/user.dart';
import 'package:fatapp/pages/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './pages/views/login.dart';
import 'dart:convert';

final routes = <String, WidgetBuilder>{
  LoginPage.tag: (context) => LoginPage(),
  HomePage.tag: (context) => HomePage()
};

Future main() async {
  Intl.defaultLocale = 'pt_BR';
  await initializeDateFormatting("pt_BR", null);
  await DotEnv().load('.env');
  StatefulWidget home = await checkLogin();

  runApp(new MaterialApp(
    home: home,
    theme: ThemeData(
      primarySwatch: Colors.red,
      fontFamily: 'Raleway',
    ),
    routes: routes,
  ));
}

Future<StatefulWidget> checkLogin() async {
  SharedPreferences sharedUser = await SharedPreferences.getInstance();

  if (sharedUser.getString('user') != null) {
    Map userMap = json.decode(sharedUser.getString('user'));
    User user = User.create(userMap);

    return HomePage(user: user);
  }
  
  return LoginPage();
}
