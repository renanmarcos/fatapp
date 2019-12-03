import 'dart:convert';
import 'package:fatapp/pages/controllers/responseHandling.dart';
import 'package:fatapp/pages/controllers/userController.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:fatapp/pages/views/register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import './home.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 50.0,
        child: Image.asset('assets/images/logo.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      onSaved: (input) => _email = input,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: InputBorder.none,
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      onSaved: (input) => _password = input,
      decoration: InputDecoration(
        hintText: 'Senha',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: InputBorder.none,
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.all(40.0),
      child: GradientButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        callback: () {
          signIn();
        },
        increaseHeightBy: 20.0,
        increaseWidthBy: 60.0,
        gradient: Gradients.buildGradient(
            Alignment.topLeft,
            Alignment.bottomRight,
            [const Color(0xFFCE0000), const Color(0xFFB71C1C)]),
        shadowColor: Gradients.hotLinear.colors.last.withOpacity(0.25),
        child: Text('Login', style: TextStyle(color: Colors.white)),
        elevation: 8,
      ),
    );

    final registerLabel = FlatButton(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text("Não tem uma conta? ", style: TextStyle(color: Colors.black54)),
          Text(
            "Cadastre-se",
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          )
        ]),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignupPage()));
        });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
              top: 100.0, left: 24.0, right: 24.0, bottom: 50.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            registerLabel
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      if (!ResponseHandling().validateEmail(_email) ||
          !ResponseHandling().validatePassword(_password)) {
        return;
      }

      var jsonData = '{ "email" : "$_email", "password" : "$_password" }';
      try {
        final tokenResponse = await UserController().login(jsonData);

        SharedPreferences sharedUser = await SharedPreferences.getInstance();
        String userString = json.encode(tokenResponse);
        sharedUser.setString('user', userString);

        User user = User.create(tokenResponse);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage(user: user)));
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
  }
}
